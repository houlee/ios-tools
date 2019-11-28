#ifndef _BASE64_H
#define _BASE64_H 1

char * base64_encode( const unsigned char * bindata, char * base64, int binlength );
int base64_decode( const char * base64, unsigned char * bindata );
void encode(FILE * fp_in, FILE * fp_out);
void decode(FILE * fp_in, FILE * fp_out);





#endif /* base64.c */

