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

# v1.6.3: 2023-02-02, update deck path
## GEOIPS#170: 2023-02-02, fix test script deck path
### Release Updates
* Update VERSION to 1.6.3, add CHANGELOG 1.6.3 line
### Testing Updates
#### Replace test_data_viirs deck path
```
modified: tests/scripts/viirs.sh
```

# v1.5.3: 2022-11-07, update test repo outputs (remove YAML metadata)

## GEOIPS#103: 2022-10-20, Remove YAML metadata output
### Test Repo Outputs
#### Remove YAML metadata outputs from test output files
* Avoid unnecessary test output updates with slight modifications to metadata output
* Prompted by addition of "storm_start_datetime" field in sector_info
* Metadata outputs will be tested separately from a consolidated test location
    * Provide a single location to test all metadata output, with only a single repo update required with changes
* Removed files:
```
deleted:    tests/outputs/abi/TrueColor_image/20210718_015031_EP062021_abi_goes-17_TrueColor_120kts_100p00_1p0-clean.png.yaml
deleted:    tests/outputs/ahi/TrueColor_image/20200405_000000_SH252020_ahi_himawari-8_TrueColor_100kts_100p00_1p0-clean.png.yaml
deleted:    tests/outputs/modis/TrueColor_image/20210705_184500_AL052021_modis_aqua_TrueColor_50kts_100p00_1p0-clean.png.yaml
deleted:    tests/outputs/viirs/TrueColor_image/20210205_080611_SH192021_viirs_npp_TrueColor_40kts_100p00_1p0-clean.png.yaml
```
#### Remove YAML metadata outputs from test scripts
* YAML metadata tests will be performed from a consolidated testing location
    * Allow for a single update of all YAML metadata outputs when updates required
* Updated scripts:
```
modified:   tests/scripts/abi.sh
modified:   tests/scripts/ahi.sh
modified:   tests/scripts/modis.sh
modified:   tests/scripts/viirs.sh
```


# v1.5.1: 2022-07-13, geoips2->geoips

### Refactor
* **File modifications**
    * Update all instances of 'geoips2' with 'geoips'
    * Update all instances of 'GEOIPS2' with 'GEOIPS'

### Documentation Updates
* Update \*.md Distro statement headers to use 4 spaces prefix rather than ### (formatting improvement)


# v1.4.8: 2022-05-16, update true color build to include all dependencies

### Improvements
* **Installation**
    * Add makefile for top level true\_color. Builds all dependencies
        * rayleigh (which includes fortran_utils and ancildat)
        * synth_green (which includes fortran_utils)

### Bug fixes
* **uninstallation**
    * Install all plugins *before* pip installing true\_color 
    * pip uninstall all plugins *before* running make clean on true\_color repository


# v1.4.7: 2022-05-06, setup_true_color.sh->setup.sh, add makeclean

### Improvements
* Add makeclean command
    * ./setup.sh makeclean calls make clean on each of the plugins.
* For consistency and brevity, rename
    * setup_true_color.sh install_true_color
        TO
    * setup.sh install


# v1.4.5: 2022-03-18, compare_paths->compare_path

### Refactor
* Replace compare_paths with compare_path in test scripts
    * abi.sh
    * ahi.sh
    * modis.sh
    * viirs.sh


# v1.4.2: 2022-02-05, replaced annotated imagery output with clean, added --resampled_read argument to ABI call

### Test Repo Updates
    * Replaced annotated imagery output with clean imagery

### Refactor
    * Add --resampled_read argument to ABI and AHI True Color test scripts
    * Removed "latitude" and "longitude" variables from AHI product_params (automatically included)


# v1.4.1: 2022-01-21, updated MODIS True Color output to reflect streamlined get_alg_xarray logic

### Breaking Test Repo Updates
    * Updated MODIS True Color output to reflect streamlined get_alg_xarray logic
        * Previously get_alg_xarray would interpolate geolocation variables for every resolution - modified so it will only interpolate once.

# v1.4.0: 2021-11-25, atcf->tc, add explicit metadata requests for all test scripts

### Refactor
    * Added explicit default metadata output requests for all true_color test scripts
        * abi
        * ahi
        * modis
        * viirs


# v1.3.0: 2021-11-25, atcf->tc, update paths

### Breaking Test Repo Updates
    * Update TC YAML metadata outputs
        * to geoips_outdirs/preprocessed/tcwww
        * add sector_type: tc


# v1.2.4: 2021-11-12, original\_source\_filename->original\_source\_filenames, simplified README.md

### Breaking Test Repo Updates
    * Updated metadata YAML outputs with single original\_source\_filename with list of original\_source\_filenames

### Improvements
    * Simplified installation and test instructions
        * Use geoips base_install_and_test.sh for geoips_conda environment
        * Updated to new style test calls


# v1.2.3: 2021-11-05, simplified test scripts

### Improvements
    * Removed old testing construct
    * Simplified test scripts include explicit command line calls with valid return codes
        * abi.sh
        * ahi.sh
        * modis.sh
        * viirs.sh


# v1.2.1: 2021-10-05, Standardized README and setup scripts, true_color-based build

### Breaking Test Repo Updates
    * Updated cartopy to 0.20.0 and matplotlib to v3.4.3
        * test repo outputs incompatible with matplotlib < 3.4.0 and cartopy < 0.19.0
        * Older versions have figures that are very slightly shifted from later versions
        * Exclusively a qualitative difference, but it *does* cause the test comparisons to fail
    * No longer recentering all TC outputs by default
        * true_color outputs are *not* recentered as of 1.2.1 - test recentering separately from other functionality

### Refactor
    * Moved recenter_tc plugin to a separate installable repository
    * Build fortran libraries directly within their own package, no longer within geoips package
        * Required updating all python imports within true_color that use the fortran compiled libraries 

### Major New Functionality:
    * Added exhaustive "test_all.sh" script with successful 0 return.
        * Input data stored within test_data_<sensor>, test outputs stored within true_color plugin repo

### Improvements
    * Standardized and formalized the README, setup script, and test script format for all plugin repos
    * Removed requirement to link test scripts from plugin repos into the main geoips test directory
