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
static const char *ng0 = "C:/Users/Lenovo/Desktop/singleCPU/DATA_RAM.v";
static unsigned int ng1[] = {4294967295U, 4294967295U};
static int ng2[] = {2, 0};
static int ng3[] = {0, 0};
static int ng4[] = {3, 0};
static int ng5[] = {1, 0};
static int ng6[] = {6, 0};
static int ng7[] = {31, 0};
static int ng8[] = {5, 0};



static void Cont_33_0(char *t0)
{
    char t3[8];
    char t4[8];
    char t19[8];
    char t26[8];
    char *t1;
    char *t2;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    unsigned int t13;
    unsigned int t14;
    unsigned int t15;
    char *t16;
    char *t17;
    char *t18;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;
    char *t25;
    char *t27;
    char *t28;
    char *t29;
    unsigned int t30;
    unsigned int t31;
    unsigned int t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    unsigned int t37;
    unsigned int t38;
    unsigned int t39;
    char *t40;
    char *t41;
    char *t42;
    char *t43;
    char *t44;
    char *t45;
    char *t46;

LAB0:    t1 = (t0 + 3328U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(33, ng0);
    t2 = (t0 + 1848U);
    t5 = *((char **)t2);
    memset(t4, 0, 8);
    t2 = (t5 + 4);
    t6 = *((unsigned int *)t2);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 & 1U);
    if (t10 != 0)
        goto LAB4;

LAB5:    if (*((unsigned int *)t2) != 0)
        goto LAB6;

LAB7:    t12 = (t4 + 4);
    t13 = *((unsigned int *)t4);
    t14 = *((unsigned int *)t12);
    t15 = (t13 || t14);
    if (t15 > 0)
        goto LAB8;

LAB9:    t36 = *((unsigned int *)t4);
    t37 = (~(t36));
    t38 = *((unsigned int *)t12);
    t39 = (t37 || t38);
    if (t39 > 0)
        goto LAB10;

LAB11:    if (*((unsigned int *)t12) > 0)
        goto LAB12;

LAB13:    if (*((unsigned int *)t4) > 0)
        goto LAB14;

LAB15:    memcpy(t3, t40, 8);

LAB16:    t41 = (t0 + 4240);
    t42 = (t41 + 56U);
    t43 = *((char **)t42);
    t44 = (t43 + 56U);
    t45 = *((char **)t44);
    memcpy(t45, t3, 8);
    xsi_driver_vfirst_trans(t41, 0, 31);
    t46 = (t0 + 4144);
    *((int *)t46) = 1;

LAB1:    return;
LAB4:    *((unsigned int *)t4) = 1;
    goto LAB7;

LAB6:    t11 = (t4 + 4);
    *((unsigned int *)t4) = 1;
    *((unsigned int *)t11) = 1;
    goto LAB7;

LAB8:    t16 = (t0 + 2248);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t20 = (t0 + 2248);
    t21 = (t20 + 72U);
    t22 = *((char **)t21);
    t23 = (t0 + 2248);
    t24 = (t23 + 64U);
    t25 = *((char **)t24);
    t27 = (t0 + 1528U);
    t28 = *((char **)t27);
    memset(t26, 0, 8);
    t27 = (t26 + 4);
    t29 = (t28 + 4);
    t30 = *((unsigned int *)t28);
    t31 = (t30 >> 2);
    *((unsigned int *)t26) = t31;
    t32 = *((unsigned int *)t29);
    t33 = (t32 >> 2);
    *((unsigned int *)t27) = t33;
    t34 = *((unsigned int *)t26);
    *((unsigned int *)t26) = (t34 & 31U);
    t35 = *((unsigned int *)t27);
    *((unsigned int *)t27) = (t35 & 31U);
    xsi_vlog_generic_get_array_select_value(t19, 32, t18, t22, t25, 2, 1, t26, 5, 2);
    goto LAB9;

LAB10:    t40 = ((char*)((ng1)));
    goto LAB11;

LAB12:    xsi_vlog_unsigned_bit_combine(t3, 32, t19, 32, t40, 32);
    goto LAB16;

LAB14:    memcpy(t3, t19, 8);
    goto LAB16;

}

static void Always_35_1(char *t0)
{
    char t13[8];
    char t14[8];
    char t21[8];
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    unsigned int t6;
    unsigned int t7;
    unsigned int t8;
    unsigned int t9;
    unsigned int t10;
    char *t11;
    char *t12;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t22;
    char *t23;
    char *t24;
    unsigned int t25;
    unsigned int t26;
    unsigned int t27;
    unsigned int t28;
    unsigned int t29;
    unsigned int t30;
    char *t31;
    unsigned int t32;
    int t33;
    char *t34;
    unsigned int t35;
    int t36;
    int t37;
    unsigned int t38;
    unsigned int t39;
    int t40;
    int t41;

LAB0:    t1 = (t0 + 3576U);
    t2 = *((char **)t1);
    if (t2 == 0)
        goto LAB2;

LAB3:    goto *t2;

LAB2:    xsi_set_current_line(35, ng0);
    t2 = (t0 + 4160);
    *((int *)t2) = 1;
    t3 = (t0 + 3608);
    *((char **)t3) = t2;
    *((char **)t1) = &&LAB4;

LAB1:    return;
LAB4:    xsi_set_current_line(35, ng0);

LAB5:    xsi_set_current_line(36, ng0);
    t4 = (t0 + 1688U);
    t5 = *((char **)t4);
    t4 = (t5 + 4);
    t6 = *((unsigned int *)t4);
    t7 = (~(t6));
    t8 = *((unsigned int *)t5);
    t9 = (t8 & t7);
    t10 = (t9 != 0);
    if (t10 > 0)
        goto LAB6;

LAB7:
LAB8:    goto LAB2;

LAB6:    xsi_set_current_line(36, ng0);
    t11 = (t0 + 1368U);
    t12 = *((char **)t11);
    t11 = (t0 + 2248);
    t15 = (t0 + 2248);
    t16 = (t15 + 72U);
    t17 = *((char **)t16);
    t18 = (t0 + 2248);
    t19 = (t18 + 64U);
    t20 = *((char **)t19);
    t22 = (t0 + 1528U);
    t23 = *((char **)t22);
    memset(t21, 0, 8);
    t22 = (t21 + 4);
    t24 = (t23 + 4);
    t25 = *((unsigned int *)t23);
    t26 = (t25 >> 2);
    *((unsigned int *)t21) = t26;
    t27 = *((unsigned int *)t24);
    t28 = (t27 >> 2);
    *((unsigned int *)t22) = t28;
    t29 = *((unsigned int *)t21);
    *((unsigned int *)t21) = (t29 & 31U);
    t30 = *((unsigned int *)t22);
    *((unsigned int *)t22) = (t30 & 31U);
    xsi_vlog_generic_convert_array_indices(t13, t14, t17, t20, 2, 1, t21, 5, 2);
    t31 = (t13 + 4);
    t32 = *((unsigned int *)t31);
    t33 = (!(t32));
    t34 = (t14 + 4);
    t35 = *((unsigned int *)t34);
    t36 = (!(t35));
    t37 = (t33 && t36);
    if (t37 == 1)
        goto LAB9;

LAB10:    goto LAB8;

LAB9:    t38 = *((unsigned int *)t13);
    t39 = *((unsigned int *)t14);
    t40 = (t38 - t39);
    t41 = (t40 + 1);
    xsi_vlogvar_assign_value(t11, t12, 0, *((unsigned int *)t14), t41);
    goto LAB10;

}

static void Initial_41_2(char *t0)
{
    char t3[8];
    char t4[8];
    char t24[8];
    char *t1;
    char *t2;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    char *t12;
    unsigned int t13;
    int t14;
    char *t15;
    unsigned int t16;
    int t17;
    int t18;
    unsigned int t19;
    unsigned int t20;
    int t21;
    int t22;
    unsigned int t23;
    char *t25;
    char *t26;
    char *t27;
    char *t28;
    char *t29;
    char *t30;
    unsigned int t31;
    char *t32;
    unsigned int t33;
    unsigned int t34;
    unsigned int t35;

LAB0:    xsi_set_current_line(41, ng0);

LAB2:    xsi_set_current_line(42, ng0);
    t1 = ((char*)((ng2)));
    t2 = (t0 + 2248);
    t5 = (t0 + 2248);
    t6 = (t5 + 72U);
    t7 = *((char **)t6);
    t8 = (t0 + 2248);
    t9 = (t8 + 64U);
    t10 = *((char **)t9);
    t11 = ((char*)((ng3)));
    xsi_vlog_generic_convert_array_indices(t3, t4, t7, t10, 2, 1, t11, 32, 1);
    t12 = (t3 + 4);
    t13 = *((unsigned int *)t12);
    t14 = (!(t13));
    t15 = (t4 + 4);
    t16 = *((unsigned int *)t15);
    t17 = (!(t16));
    t18 = (t14 && t17);
    if (t18 == 1)
        goto LAB3;

LAB4:    xsi_set_current_line(43, ng0);
    t1 = ((char*)((ng4)));
    t2 = (t0 + 2248);
    t5 = (t0 + 2248);
    t6 = (t5 + 72U);
    t7 = *((char **)t6);
    t8 = (t0 + 2248);
    t9 = (t8 + 64U);
    t10 = *((char **)t9);
    t11 = ((char*)((ng5)));
    xsi_vlog_generic_convert_array_indices(t3, t4, t7, t10, 2, 1, t11, 32, 1);
    t12 = (t3 + 4);
    t13 = *((unsigned int *)t12);
    t14 = (!(t13));
    t15 = (t4 + 4);
    t16 = *((unsigned int *)t15);
    t17 = (!(t16));
    t18 = (t14 && t17);
    if (t18 == 1)
        goto LAB5;

LAB6:    xsi_set_current_line(44, ng0);
    t1 = ((char*)((ng6)));
    t2 = (t0 + 2248);
    t5 = (t0 + 2248);
    t6 = (t5 + 72U);
    t7 = *((char **)t6);
    t8 = (t0 + 2248);
    t9 = (t8 + 64U);
    t10 = *((char **)t9);
    t11 = ((char*)((ng2)));
    xsi_vlog_generic_convert_array_indices(t3, t4, t7, t10, 2, 1, t11, 32, 1);
    t12 = (t3 + 4);
    t13 = *((unsigned int *)t12);
    t14 = (!(t13));
    t15 = (t4 + 4);
    t16 = *((unsigned int *)t15);
    t17 = (!(t16));
    t18 = (t14 && t17);
    if (t18 == 1)
        goto LAB7;

LAB8:    xsi_set_current_line(45, ng0);
    xsi_set_current_line(45, ng0);
    t1 = ((char*)((ng4)));
    t2 = (t0 + 2408);
    xsi_vlogvar_assign_value(t2, t1, 0, 0, 32);

LAB9:    t1 = (t0 + 2408);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = ((char*)((ng7)));
    memset(t3, 0, 8);
    xsi_vlog_signed_leq(t3, 32, t5, 32, t6, 32);
    t7 = (t3 + 4);
    t13 = *((unsigned int *)t7);
    t16 = (~(t13));
    t19 = *((unsigned int *)t3);
    t20 = (t19 & t16);
    t23 = (t20 != 0);
    if (t23 > 0)
        goto LAB10;

LAB11:
LAB1:    return;
LAB3:    t19 = *((unsigned int *)t3);
    t20 = *((unsigned int *)t4);
    t21 = (t19 - t20);
    t22 = (t21 + 1);
    xsi_vlogvar_assign_value(t2, t1, 0, *((unsigned int *)t4), t22);
    goto LAB4;

LAB5:    t19 = *((unsigned int *)t3);
    t20 = *((unsigned int *)t4);
    t21 = (t19 - t20);
    t22 = (t21 + 1);
    xsi_vlogvar_assign_value(t2, t1, 0, *((unsigned int *)t4), t22);
    goto LAB6;

LAB7:    t19 = *((unsigned int *)t3);
    t20 = *((unsigned int *)t4);
    t21 = (t19 - t20);
    t22 = (t21 + 1);
    xsi_vlogvar_assign_value(t2, t1, 0, *((unsigned int *)t4), t22);
    goto LAB8;

LAB10:    xsi_set_current_line(45, ng0);
    t8 = ((char*)((ng8)));
    t9 = (t0 + 2248);
    t10 = (t0 + 2248);
    t11 = (t10 + 72U);
    t12 = *((char **)t11);
    t15 = (t0 + 2248);
    t25 = (t15 + 64U);
    t26 = *((char **)t25);
    t27 = (t0 + 2408);
    t28 = (t27 + 56U);
    t29 = *((char **)t28);
    xsi_vlog_generic_convert_array_indices(t4, t24, t12, t26, 2, 1, t29, 32, 1);
    t30 = (t4 + 4);
    t31 = *((unsigned int *)t30);
    t14 = (!(t31));
    t32 = (t24 + 4);
    t33 = *((unsigned int *)t32);
    t17 = (!(t33));
    t18 = (t14 && t17);
    if (t18 == 1)
        goto LAB12;

LAB13:    xsi_set_current_line(45, ng0);
    t1 = (t0 + 2408);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = ((char*)((ng5)));
    memset(t3, 0, 8);
    xsi_vlog_signed_add(t3, 32, t5, 32, t6, 32);
    t7 = (t0 + 2408);
    xsi_vlogvar_assign_value(t7, t3, 0, 0, 32);
    goto LAB9;

LAB12:    t34 = *((unsigned int *)t4);
    t35 = *((unsigned int *)t24);
    t21 = (t34 - t35);
    t22 = (t21 + 1);
    xsi_vlogvar_assign_value(t9, t8, 0, *((unsigned int *)t24), t22);
    goto LAB13;

}


extern void work_m_00000000002065329345_1939551284_init()
{
	static char *pe[] = {(void *)Cont_33_0,(void *)Always_35_1,(void *)Initial_41_2};
	xsi_register_didat("work_m_00000000002065329345_1939551284", "isim/computer_test_isim_beh.exe.sim/work/m_00000000002065329345_1939551284.didat");
	xsi_register_executes(pe);
}
