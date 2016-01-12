#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include "hazy-cosmic-jive-perl.c"

typedef hazy_cosmic_jive_t * Hazy__Cosmic__Jive;

MODULE=Hazy::Cosmic::Jive PACKAGE=Hazy::Cosmic::Jive

PROTOTYPES: DISABLE

BOOT:
	/* Hazy__Cosmic__Jive_error_handler = perl_error_handler; */

