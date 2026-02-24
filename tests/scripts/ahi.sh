#!/bin/bash

# # # This source code is subject to the license referenced at
# # # https://github.com/NRLMMD-GEOIPS.

geoips run single_source $GEOIPS_TESTDATA_DIR/test_data_ahi/data/20200405_0000/* \
          --procflow single_source \
          --reader_name ahi_hsd \
          --resampled_read \
          --product_name TrueColor \
          --compare_path "$GEOIPS_PACKAGES_DIR/true_color/tests/outputs/ahi//<product>_image" \
         --output_formatter imagery_clean \
         --filename_formatter tc_clean_fname \
         --trackfile_parser bdeck_parser \
         --trackfiles $GEOIPS_PACKAGES_DIR/geoips/tests/sectors/tc_bdecks/bsh252020.dat \
         --feature_annotator tc_visir \
         --gridline_annotator tc_visir

retval=$?
exit $retval
