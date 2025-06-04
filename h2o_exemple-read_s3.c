#include <stdio.h>
#include <stdlib.h>
#include <trexio.h>
#include <trexio_s3_rust.h>

int main() {
	const char* input_filename = "poc-trexio-b1/h2o_exemple.trexio";
	const char* output_filename = "h2o_exemple-RS3.out";
	FILE* output_unit;
        trexio_exit_code rc;

  // Open the TREXIO file in read mode with S3 backend
  trexio_t* trexio_file = trexio_open(input_filename, 'r', TREXIO_S3, &rc);
  if (rc != TREXIO_SUCCESS) {
    fprintf(stderr, "Error on open: %s\n", trexio_string_of_error(rc));
    return -1;
 } 
 // Open the output file
  output_unit=fopen(output_filename, "w");
  if(output_unit==NULL){
	perror("Erreur lors de l'ouverture dufichier de sortie");
	trexio_close(trexio_file);
        return -1;
  }
 // READ the number of nuclei
  int num;
  rc = trexio_read_nucleus_num(trexio_file,&num);
  if (rc != TREXIO_SUCCESS) {
    fprintf(stderr, "Error reading num: %s\n", trexio_string_of_error(rc));
    trexio_close(trexio_file);
    fclose(output_unit);
    return -1;
  }
  fprintf(output_unit,"nucleus_num %d\n",num); 
  
 // READ the nuclear coordinates
     //dynamic allocation : coord[num][3]
  double** coord=malloc(num*sizeof(double*));
  if(coord==NULL){
    fprintf(stderr, "Memory allocation failed.\n");
    fclose(output_unit);
    trexio_close(trexio_file);
    return -1;
  }
  for(int i=0; i<num; i++){
     coord[i]=malloc(3*sizeof(double));
     if(coord[i]==NULL){
	fprintf(stderr, "Memory allocation failed.\n");
	for(int j=0; j<i; j++) free(coord[j]);
	free(coord);
	fclose(output_unit);
	trexio_close(trexio_file);
        return -1;
	}
   }
	//Read the coordinates
  rc = trexio_read_nucleus_coord(trexio_file, &coord[0][0]);
  if (rc != TREXIO_SUCCESS) {
    fprintf(stderr, "Error reading coord: %s\n", trexio_string_of_error(rc));
    for(int i=0; i<num; i++) free(coord[i]);
    free(coord);
    fclose(output_unit);
    trexio_close(trexio_file);
    return -1;
  }
  printf("coord = \n");
  fprintf(output_unit, "coord = \n");

  for (int j=0; j<num; j++){
     printf("%20.10f, %20.10f, %20.10f", coord[j][0], coord[j][1], coord[j][2]); 
     fprintf(output_unit, "%20.10f, %20.10f, %20.10f", coord[j][0], coord[j][1], coord[j][2]); 
  }
  for(int i=0; i<num; i++) free(coord[i]);
  free(coord);

  // Close the TREXIO file
  fclose(output_unit);
  rc = trexio_close(trexio_file);
  if (rc != TREXIO_SUCCESS) {
    fprintf(stderr, "Error on close: %s\n", trexio_string_of_error(rc));
    return -1;
  }

  return 0;
}
