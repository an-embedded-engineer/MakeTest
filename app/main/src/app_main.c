#include "app_main_public.h"
#include <stdio.h>

/* Application Main */
void app_main(void)
{
    printf("app_main() is called\n");

    printf("sint8  : %lu\n", sizeof(sint8));
    printf("uint8  : %lu\n", sizeof(uint8));
    printf("sint16 : %lu\n", sizeof(sint16));
    printf("uint16 : %lu\n", sizeof(uint16));
    printf("sint32 : %lu\n", sizeof(sint32));
    printf("uint32 : %lu\n", sizeof(uint32));
    printf("sint64 : %lu\n", sizeof(sint64));
    printf("uint64 : %lu\n", sizeof(uint64));

}
