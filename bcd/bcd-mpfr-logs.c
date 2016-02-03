#include <stdio.h>
#include <math.h>
#include <gmp.h>
#include <mpfr.h>

#include "split-double.h"

int main (int argc, char ** argv)
{
    const int maxexp = (1<<11) - 1;
    int i;
    printf ("[\n");
    for (i = 1; i < maxexp; i++) {
	split_double_t sp = {0};
	double * spd;
	double log_10_sp;
	int powten;
	double reduced;
	double log_10_r;
	char logout[0x20];
	sp.exp = i;
	spd = (double *) & sp;
	log_10_sp = log10 (*spd);
	powten = (int) round (log_10_sp);
	reduced = (*spd) / pow (10.0, (double) powten);
	reduced /= 10.0;
	while (reduced < 0.1) {
//	    printf ("Multiplying %g!!\n", reduced);
	    reduced *= 10.0;
	    powten--;
	}
	log_10_r = log10 (reduced);
	snprintf (logout, 0x20, "%0.18f", reduced);
	printf ("%d, %g, %g, %0.18f,\n", powten, log_10_sp, * spd, reduced);
//continue;
	printf ("\"log_{10}(2^{%d}) = %g %.15g %g %s\",\n", i - 1023, (*spd), log_10_sp, reduced, logout);
	printf ("{\"pow2\":%d,\"exp\":%d,\"upper\":\"0x%.*s\",\"lower\":\"0x%.*s\"},\n", i-1023, powten, 8, logout + 2, 8, logout + 10);
    }
    printf ("\"end\"]\n");
    return 0;
}
