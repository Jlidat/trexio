#include <stdio.h>
#include <trexio.h>
//#include <trexio_s3.h>

int main() {
  int num = 3;  // Number of atoms
  double coord[][3] = {
    {0.0,  0.0       , -0.24962655},
    {0.0,  2.70519714,  1.85136466},
    {0.0, -2.70519714,  1.85136466}
  };

  trexio_exit_code rc;

  // Open the TREXIO file in write mode with S3 backend
  trexio_t* f = trexio_open("poc-trexio-b1/h2o_exemple.trexio", 'w', TREXIO_S3, &rc);
  if (rc != TREXIO_SUCCESS) {
    fprintf(stderr, "Error on open: %s\n", trexio_string_of_error(rc));
    return -1;
  }

  // Write the number of nuclei
  rc = trexio_write_nucleus_num(f, num);
  if (rc != TREXIO_SUCCESS) {
    fprintf(stderr, "Error writing num: %s\n", trexio_string_of_error(rc));
    trexio_close(f);
    return -1;
  }

  // Write the nuclear coordinates
  rc = trexio_write_nucleus_coord(f, &coord[0][0]);
  if (rc != TREXIO_SUCCESS) {
    fprintf(stderr, "Error writing coord: %s\n", trexio_string_of_error(rc));
    trexio_close(f);
    return -1;
  }

  // Close the TREXIO file
  rc = trexio_close(f);
  if (rc != TREXIO_SUCCESS) {
    fprintf(stderr, "Error on close: %s\n", trexio_string_of_error(rc));
    return -1;
  }

  printf("TREXIO file 'h2o_exemple.h5' created successfully.\n");
  return 0;
}
