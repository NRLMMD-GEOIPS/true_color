# # # This source code is subject to the license referenced at
# # # https://github.com/NRLMMD-GEOIPS.

"""True Color GeoIPS algorithm plugin."""

import logging

# Python Standard Libraries
from math import log10

# Installed Libraries
import numpy as np

LOG = logging.getLogger(__name__)

interface = "algorithms"
family = "xarray_to_numpy"
name = "TrueColor"


def call(xobj):
    """Apply rayleigh correction.

    Since ABI needs lat/lon info, we just bring "xobj" as the xarray fileds,
    not as the numpy arrays for other single source algorithms.
    """
    source_name = xobj.source_name  # find out the sensor name
    # find the rayleigh.py in the Rrayleigh package by using the find_module module
    # from geoips.geoips_utils import find_module
    # alg = find_module(subpackage_name='src',
    #                      module_name='rayleigh',
    #                      method_name='rayleigh')
    # ref_data=alg(xobj)

    # apply the Rayleigh correction
    from rayleigh.rayleigh import rayleigh

    ref_data = rayleigh(xobj)

    if source_name == "ahi":
        # This is a correction applied specifically to AHI data because AHI's green
        # channel is not centered on the chlorophyl peak like MODIS and VIIRS.
        # This causes AHI imagery to be too red without correction.  To correct
        # we add 93% of the Green band and 7% of the 1.6um band.
        print("********************************DOING AHI")
        ref_data = np.ma.dstack(
            [
                ref_data["RED"],
                0.93 * ref_data["GRN"] + 0.07 * ref_data["NIR"],
                ref_data["BLU"],
            ]
        )

    elif source_name == "abi":
        # Get land/sea mask
        from ancildat.lib.libancildat import ancildat

        land_sea_mask = ancildat.land_sea_mask
        lons = xobj["longitude"]
        lats = xobj["latitude"]
        ls_mask = land_sea_mask(lons, lats)[0]

        # ABI does not have a green channel, so the green gun must be synthesized
        # using lookup tables generated from AHI imagery that relate the blue, red,
        # and near infrared channels to AHI green channel values
        try:
            from synth_green.lib.libsynth_green import synth_green

            synth_green = synth_green.get_synth_green
        except Exception:
            print(
                "from .libsynth_green import synth_green FAILURE"
                "if you need it, get it."
            )
        ref_data = np.ma.dstack(
            [
                ref_data["RED"],
                synth_green(ref_data["NIR"], ref_data["RED"], ref_data["BLU"], ls_mask)[
                    0
                ],
                ref_data["BLU"],
            ]
        )

    else:
        # All of the other sensors require nothing special
        ref_data = np.ma.dstack([ref_data["RED"], ref_data["GRN"], ref_data["BLU"]])

    # This should all be the same for all sensors.  log10(0.0223) is required
    # to avoid having values outside of the range 0-1.
    # I'm not sure why Steve is using a different value, but it is very similar
    # and breaks things if we use the "newer" value.
    min_ref = 0.0223
    max_ref = 1.0
    log_min_ref = log10(min_ref)
    log_max_ref = log10(max_ref)
    # Must do first to avoid underflow error
    ref_data[np.ma.where(ref_data < min_ref)] = min_ref
    ref_data = np.ma.log10(ref_data)
    ref_data = (ref_data - log_min_ref) / (log_max_ref - log_min_ref)
    ref_data[ref_data < 0] = 0
    ref_data[ref_data > 1] = 1

    # re-arrange RGB arrays for a true-color product
    red = ref_data[:, :, 0]
    grn = ref_data[:, :, 1]
    blu = ref_data[:, :, 2]

    from geoips.image_utils.mpl_utils import alpha_from_masked_arrays, rgba_from_arrays

    alp = alpha_from_masked_arrays([red, grn, blu])
    rgba = rgba_from_arrays(red, grn, blu, alp)

    return rgba
