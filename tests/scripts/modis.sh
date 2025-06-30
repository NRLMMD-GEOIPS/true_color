#!/bin/bash

# # # This source code is subject to the license referenced at
# # # https://github.com/NRLMMD-GEOIPS.

run_procflow $GEOIPS_TESTDATA_DIR/test_data_modis/data/aqua/20210705/*/* \
          --procflow single_source \
          --reader_name modis_hdf4 \
          --product_name TrueColor \
          --compare_path "$GEOIPS_PACKAGES_DIR/true_color/tests/outputs/modis//<product>_image" \
         --output_formatter imagery_clean \
         --filename_formatter tc_clean_fname \
         --trackfile_parser bdeck_parser \
         --trackfiles $GEOIPS_PACKAGES_DIR/geoips/tests/sectors/tc_bdecks/bal052021.dat \
         --feature_annotator tc_visir \
         --gridline_annotator tc_visir
retval=$?
exit $retval
