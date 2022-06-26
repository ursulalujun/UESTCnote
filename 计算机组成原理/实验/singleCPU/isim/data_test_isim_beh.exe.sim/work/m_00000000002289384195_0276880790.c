/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "C:/Users/Lenovo/Desktop/singleCPU/Sign_Extender.v";
static unsigned int ng1[] = {65535U, 0U};
static unsigned int ng2[] = {0U, 0U};



static void Cont_27_0(char *t0)
{
    char t3[8];
    char t5[8];
    char t6[8];
    char t8[8];
    char *t1;
    char *t2;
    char *t4;
    char *t7;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    unsigned int t19;
    unsigned int t20;
    unsigned int t21;
    char *t22;
    char *t23;
    unsigned int t24;
    unsigned int t25;
    unsigned int t26;
    char *t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    unsigned int t31;
    char *t32;
    char *t33;
    char *t34;
    char *t35;
    char *t36;
    char *t37;
    char *t38;

LAB0:    t1 = (t0 + 2368U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(27, ng0);
    t2 = (t0 + 1048U);
    t4 = *((char **)t2);
    t2 = (t0 + 1048U);
    t7 = *((char **)t2);
    memset(t8, 0, 8);
    t2 = (t8 + 4);
    t9 = (t7 + 4);
    t10 = *((unsigned int *)t7);
    t11 = (t10 >> 15);
    t12 = (t11 & 1);
    *((unsigned int *)t8) = t12;
    t13 = *((unsigned int *)t9);
    t14 = (t13 >> 15);
    t15 = (t14 & 1);
    *((unsigned int *)t2) = t15;
    memset(t6, 0, 8);
    t16 = (t8 + 4);
    t17 = *((unsigned int *)t16);
    t18 = (~(t17));
    t19 = *((unsigned int *)t8);
    t20 = (t19 & t18);
    t21 = (t20 & 1U);
    if (t21 != 0)
        goto LAB4;

LAB5:    if (*((unsigned int *)t16) != 0)
        goto LAB6;

LAB7:    t23 = (t6 + 4);
    t24 = *((unsigned int *)t6);
    t25 = *((unsigned int *)t23);
    t26 = (t24 || t25);
    if (t26 > 0)
        goto LAB8;

LAB9:    t28 = *((unsigned int *)t6);
    t29 = (~(t28));
    t30 = *((unsigned int *)t23);
    t31 = (t29 || t30);
    if (t31 > 0)
        goto LAB10;

LAB11:    if (*((unsigned int *)t23) > 0)
        goto LAB12;

LAB13:    if (*((unsigned int *)t6) > 0)
        goto LAB14;

LAB15:    memcpy(t5, t32, 8);

LAB16:    xsi_vlogtype_concat(t3, 32, 32, 2U, t5, 16, t4, 16);
    t33 = (t0 + 2768);
    t34 = (t33 + 56U);
    t35 = *((char **)t34);
    t36 = (t35 + 56U);
    t37 = *((char **)t36);
    memcpy(t37, t3, 8);
    xsi_driver_vfirst_trans(t33, 0, 31);
    t38 = (t0 + 2688);
    *((int *)t38) = 1;

LAB1:    return;
LAB4:    *((unsigned int *)t6) = 1;
    goto LAB7;

LAB6:    t22 = (t6 + 4);
    *((unsigned int *)t6) = 1;
    *((unsigned int *)t22) = 1;
    goto LAB7;

LAB8:    t27 = ((char*)((ng1)));
    goto LAB9;

LAB10:    t32 = ((char*)((ng2)));
    goto LAB11;

LAB12:    xsi_vlog_unsigned_bit_combine(t5, 16, t27, 16, t32, 16);
    goto LAB16;

LAB14:    memcpy(t5, t27, 8);
    goto LAB16;

}


extern void work_m_00000000002289384195_0276880790_init()
{
	static char *pe[] = {(void *)Cont_27_0};
	xsi_register_didat("work_m_00000000002289384195_0276880790", "isim/data_test_isim_beh.exe.sim/work/m_00000000002289384195_0276880790.didat");
	xsi_register_executes(pe);
}
