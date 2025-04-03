    # # # Distribution Statement A. Approved for public release. Distribution unlimited.
    # # #
    # # # Author:
    # # # Naval Research Laboratory, Marine Meteorology Division
    # # #
    # # # This program is free software: you can redistribute it and/or modify it under
    # # # the terms of the NRLMMD License included with this program. This program is
    # # # distributed WITHOUT ANY WARRANTY; without even the implied warranty of
    # # # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the included license
    # # # for more details. If you did not receive the license, for more information see:
    # # # https://github.com/U-S-NRL-Marine-Meteorology-Division/


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
