#include <stdio.h>
#include "xil_printf.h"
#include "sleep.h"
#include "pwm.h"
#include "xparameters.h"




void battement(void) {
    int i;
    
    for (i = 0; i <= INTENSITE_MAX; i += 20) {
        PWM_mWriteReg(PWM_BASEADDR, PWM_S00_AXI_SLV_REG0_OFFSET, i);
        usleep(2000);
    }
    
    for (i = INTENSITE_MAX; i >= 0; i -= 20) {
        PWM_mWriteReg(PWM_BASEADDR, PWM_S00_AXI_SLV_REG0_OFFSET, i);
        usleep(2000);
    }
}


int main()
{
    
    PWM_mWriteReg(PWM_BASEADDR, PWM_S00_AXI_SLV_REG0_OFFSET, 0);
    
    while(1) {
        battement();
    }
    
    return 0;
}