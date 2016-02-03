#include <stdio.h>

#include <gmp.h>
#include <mpfr.h>

int main (void)
{
    unsigned int i;
    mpfr_t s, t, u;
    const int maxexp = (1<<11) - 1;

    mpfr_init2 (t, 200);
    mpfr_set_d (t, 1.0, MPFR_RNDD);
    mpfr_init2 (s, 200);
    mpfr_set_d (s, 2.0, MPFR_RNDD);
    for (i = 1; i <= maxexp; i++) {
	mpfr_div (t, t, s, MPFR_RNDD);
	printf ("2^{-%d} = ", i);
	mpfr_out_str (stdout, 10, 0, t, MPFR_RNDD);
	putchar ('\n');
    }
    mpfr_init2 (u, 200);

    mpfr_set_d (u, 1.0, MPFR_RNDD);
    for (i = 1; i <= maxexp; i++) {
	mpfr_mul (u, u, s, MPFR_RNDD);
	printf ("2^{%d} = ", i);
	mpfr_out_str (stdout, 10, 0, u, MPFR_RNDD);
	putchar ('\n');
    }
    mpfr_clear (s);
    mpfr_clear (t);
    mpfr_clear (u);
    return 0;
}
