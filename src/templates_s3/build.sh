#!/bin/bash

cat prefix_s3.c   > trexio_s3.c
cat prefix_s3.h   > trexio_s3.h

cat basic_s3.c   >> trexio_s3.c
cat populated/pop_basic_s3_group.c >> trexio_s3.c

cat populated/pop_struct_s3_group.h >> trexio_s3.h
cat basic_s3.h   >> trexio_s3.h

cat hrw_determinant_s3.h >> trexio_s3.h
cat *_determinant_s3.c >> trexio_s3.c

cat populated/pop_has_group_s3.c >> trexio_s3.c
cat populated/pop_hrw_group_s3.h >> trexio_s3.h

cat populated/pop_free_group_s3.c >> trexio_s3.c
cat populated/pop_read_group_s3.c >> trexio_s3.c
cat populated/pop_flush_group_s3.c >> trexio_s3.c
cat populated/pop_delete_group_s3.c >> trexio_s3.c
cat populated/pop_free_group_s3.h >> trexio_s3.h
cat populated/pop_read_group_s3.h >> trexio_s3.h
cat populated/pop_flush_group_s3.h >> trexio_s3.h
cat populated/pop_delete_group_s3.h >> trexio_s3.h

cat populated/pop_has_dset_data_s3.c >> trexio_s3.c
cat populated/pop_has_dset_str_s3.c >> trexio_s3.c
cat populated/pop_has_dset_sparse_s3.c >> trexio_s3.c
cat populated/pop_has_attr_num_s3.c >> trexio_s3.c
cat populated/pop_has_attr_str_s3.c >> trexio_s3.c
cat populated/pop_has_buffered_s3.c >> trexio_s3.c

cat populated/pop_read_dset_data_s3.c >> trexio_s3.c
cat populated/pop_read_dset_str_s3.c >> trexio_s3.c
cat populated/pop_read_dset_sparse_s3.c >> trexio_s3.c
cat populated/pop_read_attr_str_s3.c >> trexio_s3.c
cat populated/pop_read_attr_num_s3.c >> trexio_s3.c
cat populated/pop_read_buffered_s3.c >> trexio_s3.c

cat populated/pop_write_dset_data_s3.c >> trexio_s3.c
cat populated/pop_write_dset_str_s3.c >> trexio_s3.c
cat populated/pop_write_dset_sparse_s3.c >> trexio_s3.c
cat populated/pop_write_attr_str_s3.c >> trexio_s3.c
cat populated/pop_write_attr_num_s3.c >> trexio_s3.c
cat populated/pop_write_buffered_s3.c >> trexio_s3.c

cat populated/pop_hrw_dset_data_s3.h >> trexio_s3.h
cat populated/pop_hrw_dset_str_s3.h >> trexio_s3.h
cat populated/pop_hrw_dset_sparse_s3.h >> trexio_s3.h
cat populated/pop_hrw_attr_num_s3.h >> trexio_s3.h
cat populated/pop_hrw_attr_str_s3.h >> trexio_s3.h
cat populated/pop_hrw_buffered_s3.h >> trexio_s3.h

cat suffix_s3.h   >> trexio_s3.h
