#!/bin/bash

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

# Do not rename this script or test directory - automated integration
# tests look for the tests/test_all.sh script for complete testing.

# This should contain test calls to cover ALL required functionality tests
# for the true_color repo.

# The $GEOIPS_PACKAGES_DIR/geoips tests modules sourced within this script handle:
   # setting up the appropriate associative arrays for tracking the overall
   #   return value,
   # calling the test scripts appropriately, and
   # setting the final return value.

if [[ ! -d $GEOIPS_PACKAGES_DIR/geoips ]]; then
    echo "Must CLONE geoips repository into \$GEOIPS_PACKAGES_DIR location"
    echo "to use test_all.sh testing utility."
    echo ""
    echo "export GEOIPS_PACKAGES_DIR=<path_to_geoips_cloned_packages>"
    echo "git clone https://github.com/NRLMMD-GEOIPS/geoips $GEOIPS_PACKAGES_DIR/geoips"
    echo ""
    exit 1
fi

. $GEOIPS/tests/utils/test_all_pre.sh true_color

echo ""

# Note you must use the variable "call" in the for the loop
# "call" used in test_all_run.sh
for call in \
    "$GEOIPS_PACKAGES_DIR/geoips/tests/utils/check_code.sh all `dirname $0`/../" \
    "$GEOIPS_PACKAGES_DIR/true_color/tests/scripts/viirs.sh" \
    "$GEOIPS_PACKAGES_DIR/true_color/tests/scripts/modis.sh" \
    "$GEOIPS_PACKAGES_DIR/true_color/tests/scripts/ahi.sh" \
    "$GEOIPS_PACKAGES_DIR/true_color/tests/scripts/abi.sh"
do
    . $GEOIPS/tests/utils/test_all_run.sh
done

. $GEOIPS/tests/utils/test_all_post.sh
