    # # # This source code is subject to the license referenced at
    # # # https://github.com/NRLMMD-GEOIPS.


| ⚠️ **Warning** |
| -------------- |
| This package is an early release and should be expected to change in the future. We don’t expect the functionality to change in significant ways. We intend to improve the installation process, consolidate packages and, potentially, convert Fortran routines to Python to avoid complexity in installation. |

True Color GeoIPS Plugin
========================

The true_color package is a GeoIPS-compatible plugin, intended to be used within
the GeoIPS ecosystem.  Please see the
[GeoIPS Documentation](https://github.com/NRLMMD-GEOIPS/geoips#readme) for
more information on the GeoIPS plugin architecture and base infrastructure.

Package Overview
-----------------

The True Color package performs rayleigh scatterring corrections to produce
true color imagery.

System Requirements
---------------------

* geoips >= 1.10.0
* gfortran or ifort
* ancildat
* fortran_utils
* rayleigh
* Test data repos contained in $GEOIPS_TESTDATA_DIR for tests to pass.

IF REQUIRED: Install base geoips package
------------------------------------------------------------
SKIP IF YOU HAVE ALREADY INSTALLED BASE GEOIPS ENVIRONMENT

If GeoIPS Base is not yet installed, follow the
[installation instructions](https://github.com/NRLMMD-GEOIPS/geoips#installation)
within the geoips source repo documentation:

Install GeoIPS Plugin Package Dependencies
------------------------------------------

NOTE: There is a very specific order currently to ensure dependencies are installed
consistently so they work with all GeoIPS plugin packages.  Please follow the README's
in order for each of these packages when installing True Color.  These must be cloned
and installed in this order from the beginning to avoid conflicting dependency versions.

* https://github.com/NRLMMD-GEOIPS/geoips#readme
* https://github.com/NRLMMD-GEOIPS/fortran_utils#readme
* https://github.com/NRLMMD-GEOIPS/ancildat#readme
* https://github.com/NRLMMD-GEOIPS/synth_green#readme
* https://github.com/NRLMMD-GEOIPS/rayleigh#readme
* https://github.com/NRLMMD-GEOIPS/true_color#readme

Install true_color package
----------------------------
```bash

    # Ensure GeoIPS Python environment is enabled.

    # Clone and install true_color
    git clone https://github.com/NRLMMD-GEOIPS/true_color $GEOIPS_PACKAGES_DIR/true_color
    pip install -e $GEOIPS_PACKAGES_DIR/true_color

    # Add any additional clone/install/setup steps here
```

Test true_color installation
-----------------------------
```bash

    # Ensure GeoIPS Python environment is enabled.

    # This script will run ALL tests within this package
    $GEOIPS_PACKAGES_DIR/true_color/tests/test_all.sh

    # Individual direct test calls, for reference
    $GEOIPS_PACKAGES_DIR/true_color/tests/scripts/modis.sh
    $GEOIPS_PACKAGES_DIR/true_color/tests/scripts/viirs.sh
    $GEOIPS_PACKAGES_DIR/true_color/tests/scripts/abi.sh
    $GEOIPS_PACKAGES_DIR/true_color/tests/scripts/ahi.sh
```
