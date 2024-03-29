#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	new g_BarcosAss[193];
	g_BarcosAss[0] = CreateDynamicObject(19486, 881.8975, -3582.6794, 4.7694, 0.0000, 0.0000, 180.0000); //burg_SFS_01
	g_BarcosAss[1] = CreateDynamicObject(19529, 880.1580, -3591.9069, 2.1986, 0.0000, 0.0000, 0.0000); //Plane125x125Grass1
	SetObjectMaterial(g_BarcosAss[1], 0, 10765, "airportgnd_sfse", "desgreengrass", 0xFFFFFFFF);
	g_BarcosAss[2] = CreateDynamicObject(17026, 949.0219, -3601.6865, -3.8159, -3.4999, 0.0000, 146.2998); //cunt_rockgp2_
	g_BarcosAss[3] = CreateDynamicObject(17026, 952.5347, -3555.5996, -1.3514, -3.4999, 0.0000, 146.2998); //cunt_rockgp2_
	g_BarcosAss[4] = CreateDynamicObject(17026, 945.8770, -3647.5300, -4.2918, -3.4999, 0.0000, 146.2998); //cunt_rockgp2_
	g_BarcosAss[5] = CreateDynamicObject(17026, 915.2819, -3662.8979, -3.7028, -3.4999, 0.0000, 51.7000); //cunt_rockgp2_
	g_BarcosAss[6] = CreateDynamicObject(10230, 3773.9494, 476.2615, 7.5040, 0.0000, 0.0000, 0.0000); //freighter_sfe
	g_BarcosAss[7] = CreateDynamicObject(10140, 3788.7143, 475.2207, 7.6630, 0.0000, 0.0000, 0.0000); //freig2_intSFE
	g_BarcosAss[8] = CreateDynamicObject(17026, 875.1036, -3662.2753, -4.6634, -3.4999, 0.0000, 51.7000); //cunt_rockgp2_
	g_BarcosAss[9] = CreateDynamicObject(17026, 841.4448, -3658.8586, -4.8555, -3.4999, 0.0000, 51.7000); //cunt_rockgp2_
	g_BarcosAss[10] = CreateDynamicObject(2332, 3773.2563, 474.0725, 1.8398, 0.0000, 0.0000, -90.0000); //KEV_SAFE
	g_BarcosAss[11] = CreateDynamicObject(17026, 818.8305, -3635.0659, -7.4766, -3.4999, 0.0000, -44.0998); //cunt_rockgp2_
	g_BarcosAss[12] = CreateDynamicObject(1550, 3773.3715, 474.7620, 1.7312, 0.0000, 0.0000, 0.0000); //CJ_MONEY_BAG
	g_BarcosAss[13] = CreateDynamicObject(19941, 3773.3972, 474.0350, 2.3120, 0.0000, 0.0000, 27.1998); //GoldBar1
	g_BarcosAss[14] = CreateDynamicObject(19941, 3773.2299, 473.7691, 2.3120, 0.0000, 0.0000, 78.0998); //GoldBar1
	g_BarcosAss[15] = CreateDynamicObject(19941, 3773.1816, 474.3211, 2.3120, 0.0000, 0.0000, 118.6998); //GoldBar1
	g_BarcosAss[16] = CreateDynamicObject(19941, 3773.4909, 474.2741, 2.3120, 0.0000, 0.0000, 87.1999); //GoldBar1
	g_BarcosAss[17] = CreateDynamicObject(2944, 3817.0322, 480.2521, 2.8534, 0.0000, 0.0000, 0.0000); //freight_SFW_door
	g_BarcosAss[18] = CreateDynamicObject(17026, 817.9190, -3591.7150, -5.5546, -3.4999, 0.0000, -44.0998); //cunt_rockgp2_
	g_BarcosAss[19] = CreateDynamicObject(2922, 3818.1965, 481.4523, 2.7711, 0.0000, 0.0000, 180.0000); //kmb_keypad
	g_BarcosAss[20] = CreateDynamicObject(2922, 3814.9248, 481.4523, 2.7711, 0.0000, 0.0000, 180.0000); //kmb_keypad
	g_BarcosAss[21] = CreateDynamicObject(11713, 3824.3391, 481.9473, 2.6396, 0.0000, 0.0000, -90.0000); //FireExtPanel1
	g_BarcosAss[22] = CreateDynamicObject(17026, 819.4511, -3548.1896, -5.9987, -3.4999, 0.0000, -44.0998); //cunt_rockgp2_
	g_BarcosAss[23] = CreateDynamicObject(17026, 859.3572, -3526.0876, 0.1262, -3.4999, 0.0000, -125.8999); //cunt_rockgp2_
	g_BarcosAss[24] = CreateDynamicObject(19805, 3816.8916, 473.8493, 12.2218, 0.0000, 0.0000, -90.0000); //Whiteboard1
	g_BarcosAss[25] = CreateDynamicObject(17026, 894.0665, -3526.2634, -5.7666, -3.6998, 0.0000, 42.7999); //cunt_rockgp2_
	g_BarcosAss[26] = CreateDynamicObject(2716, 3816.8942, 474.0934, 12.0535, 0.0000, -37.3998, 90.0000); //CJ_DON_POSTER3
	SetObjectMaterialText(g_BarcosAss[26], "RPG", 0, 90, "Arial", 35, 1, 0xFF4A4442, 0x0, 0);
	g_BarcosAss[27] = CreateDynamicObject(2716, 3816.8942, 473.6057, 12.0329, 0.0000, -37.3998, 90.0000); //CJ_DON_POSTER3
	SetObjectMaterialText(g_BarcosAss[27], "PERFECT CITY", 0, 90, "Arial", 35, 1, 0xFF1B376D, 0x0, 0);
	g_BarcosAss[28] = CreateDynamicObject(17026, 957.5859, -3655.7380, -15.0050, -4.2999, -3.7999, 135.8999); //cunt_rockgp2_
	g_BarcosAss[29] = CreateDynamicObject(17026, 922.1296, -3530.8178, -9.0075, -3.6998, 0.0000, 42.7999); //cunt_rockgp2_
	g_BarcosAss[30] = CreateDynamicObject(2174, 3820.3999, 474.3905, 10.7258, 0.0000, 0.0000, -90.0000); //MED_OFFICE4_DESK_2
	g_BarcosAss[31] = CreateDynamicObject(17026, 953.3209, -3652.0239, -10.9933, -4.2999, -3.7999, 135.8999); //cunt_rockgp2_
	g_BarcosAss[32] = CreateDynamicObject(1806, 3819.7368, 473.5040, 10.7131, 0.0000, 0.0000, -51.2999); //MED_OFFICE_CHAIR
	g_BarcosAss[33] = CreateDynamicObject(17026, 958.1029, -3628.1552, -13.8158, -4.2999, -2.7000, -167.9002); //cunt_rockgp2_
	g_BarcosAss[34] = CreateDynamicObject(2716, 3816.8942, 474.3904, 11.9666, 0.0000, 0.0000, 90.0000); //CJ_DON_POSTER3
	SetObjectMaterialText(g_BarcosAss[34], "T", 0, 30, "Webdings", 40, 0, 0xFF4A4442, 0x0, 0);
	g_BarcosAss[35] = CreateDynamicObject(3111, 3818.8330, 471.5816, 12.0897, 90.0000, 0.0000, 0.0000); //st_arch_plan
	g_BarcosAss[36] = CreateDynamicObject(11706, 3817.2968, 472.0896, 10.6908, 0.0000, 0.0000, -42.6999); //SmallWasteBin1
	g_BarcosAss[37] = CreateDynamicObject(2961, 3816.8647, 475.6072, 12.1771, 0.0000, 0.0000, 90.0000); //fire_break
	g_BarcosAss[38] = CreateDynamicObject(17026, 958.0441, -3614.7531, -11.8052, -4.2999, -2.7000, -167.9002); //cunt_rockgp2_
	g_BarcosAss[39] = CreateDynamicObject(2007, 3819.5695, 479.9883, 10.7082, 0.0000, 0.0000, 0.0000); //filing_cab_nu01
	g_BarcosAss[40] = CreateDynamicObject(17026, 955.7476, -3604.0371, -10.9813, -4.2999, -2.7000, -167.9002); //cunt_rockgp2_
	g_BarcosAss[41] = CreateDynamicObject(17026, 957.1140, -3594.9931, -11.6654, -4.2999, -2.7000, -167.9002); //cunt_rockgp2_
	g_BarcosAss[42] = CreateDynamicObject(2007, 3818.5891, 479.9883, 10.7082, 0.0000, 0.0000, 0.0000); //filing_cab_nu01
	g_BarcosAss[43] = CreateDynamicObject(17026, 954.9279, -3584.7949, -10.8811, -4.2999, -2.7000, -167.9002); //cunt_rockgp2_
	g_BarcosAss[44] = CreateDynamicObject(948, 3817.4423, 479.9265, 10.7010, 0.0000, 0.0000, 0.0000); //Plant_Pot_10
	g_BarcosAss[45] = CreateDynamicObject(17026, 955.5963, -3573.1376, -10.1809, -4.2999, -2.7000, -167.9002); //cunt_rockgp2_
	g_BarcosAss[46] = CreateDynamicObject(948, 3820.4526, 479.9265, 10.7010, 0.0000, 0.0000, 0.0000); //Plant_Pot_10
	g_BarcosAss[47] = CreateDynamicObject(2162, 3816.8195, 478.1940, 10.7049, 0.0000, 0.0000, 90.0000); //MED_OFFICE_UNIT_1
	g_BarcosAss[48] = CreateDynamicObject(17026, 956.3519, -3558.8381, -9.3282, -4.2999, -2.7000, -167.9002); //cunt_rockgp2_
	g_BarcosAss[49] = CreateDynamicObject(17026, 954.8839, -3545.7185, -9.1557, -4.2999, -2.7000, -167.9002); //cunt_rockgp2_
	g_BarcosAss[50] = CreateDynamicObject(1523, 3821.1376, 475.9610, 10.4793, 0.0000, 0.0000, 90.0000); //Gen_doorEXT10
	g_BarcosAss[51] = CreateDynamicObject(17026, 952.7252, -3530.8093, -9.4892, -4.2999, -2.7000, -167.9002); //cunt_rockgp2_
	g_BarcosAss[52] = CreateDynamicObject(10231, 3773.0280, 474.7549, 8.9666, 0.0000, 0.0000, 0.0000); //freightboxes
	g_BarcosAss[53] = CreateDynamicObject(17026, 949.5648, -3518.6430, -15.1864, -4.2999, -2.7000, -133.3999); //cunt_rockgp2_
	g_BarcosAss[54] = CreateDynamicObject(10229, 3773.7075, 474.8317, 6.3206, 0.0000, 0.0000, 0.0000); //freighter2b_SFE
	g_BarcosAss[55] = CreateDynamicObject(17026, 922.0916, -3530.7824, -8.1493, -3.6998, 0.0000, 42.7999); //cunt_rockgp2_
	g_BarcosAss[56] = CreateDynamicObject(17026, 938.8370, -3520.5712, -20.0277, -4.2999, -2.7000, -133.3999); //cunt_rockgp2_
	g_BarcosAss[57] = CreateDynamicObject(17026, 939.0947, -3520.6232, -17.0692, -4.2999, -2.7000, -133.3999); //cunt_rockgp2_
	g_BarcosAss[58] = CreateDynamicObject(17026, 915.9207, -3517.8488, -13.0893, -4.2999, -2.7000, -100.4000); //cunt_rockgp2_
	g_BarcosAss[59] = CreateDynamicObject(17026, 897.7296, -3516.7792, -13.8125, -4.2999, -2.7000, -100.4000); //cunt_rockgp2_
	g_BarcosAss[60] = CreateDynamicObject(17026, 883.5374, -3514.1743, -12.7276, -4.2999, -2.7000, -100.4000); //cunt_rockgp2_
	g_BarcosAss[61] = CreateDynamicObject(17026, 872.8295, -3511.8605, -15.2435, -4.2999, -2.7000, -100.4000); //cunt_rockgp2_
	g_BarcosAss[62] = CreateDynamicObject(17026, 858.5364, -3513.7065, -12.0419, -4.2999, -2.7000, -83.5000); //cunt_rockgp2_
	g_BarcosAss[63] = CreateDynamicObject(17026, 845.3291, -3515.2097, -11.0424, -4.2999, -2.7000, -83.5000); //cunt_rockgp2_
	g_BarcosAss[64] = CreateDynamicObject(17026, 836.8814, -3512.8737, -10.5862, -4.2999, -2.7000, -82.1999); //cunt_rockgp2_
	g_BarcosAss[65] = CreateDynamicObject(17026, 827.4984, -3513.6254, -13.3985, -4.2999, -2.7000, -83.4000); //cunt_rockgp2_
	g_BarcosAss[66] = CreateDynamicObject(17026, 813.4282, -3537.8259, -16.3577, -4.2999, -2.7000, -47.7000); //cunt_rockgp2_
	g_BarcosAss[67] = CreateDynamicObject(17026, 810.7561, -3550.3862, -15.7409, -4.2999, -2.7000, -47.7000); //cunt_rockgp2_
	g_BarcosAss[68] = CreateDynamicObject(17026, 810.5853, -3585.5915, -11.9858, -4.2999, -2.7000, -14.8000); //cunt_rockgp2_
	g_BarcosAss[69] = CreateDynamicObject(17026, 807.6137, -3597.0380, -12.1784, -4.2999, -2.7000, -14.8000); //cunt_rockgp2_
	g_BarcosAss[70] = CreateDynamicObject(17026, 804.3406, -3609.7976, -13.2211, -4.2999, -2.7000, -14.8000); //cunt_rockgp2_
	g_BarcosAss[71] = CreateDynamicObject(17026, 804.3580, -3629.6286, -10.0543, -4.2999, -2.7000, -16.3999); //cunt_rockgp2_
	g_BarcosAss[72] = CreateDynamicObject(17026, 801.4515, -3641.2453, -15.5619, -4.2999, -2.7000, 5.8998); //cunt_rockgp2_
	g_BarcosAss[73] = CreateDynamicObject(17026, 804.2557, -3657.9204, -16.7220, -4.2999, -2.7000, 13.4998); //cunt_rockgp2_
	g_BarcosAss[74] = CreateDynamicObject(17026, 791.2000, -3642.3930, -18.5153, -4.2999, -2.7000, 13.4998); //cunt_rockgp2_
	g_BarcosAss[75] = CreateDynamicObject(690, 838.7863, -3559.3991, 1.6765, 0.0000, 0.0000, 0.0000); //sm_fir_copse2
	g_BarcosAss[76] = CreateDynamicObject(17026, 791.2000, -3642.3930, -18.5153, -4.2999, -2.7000, 13.4998); //cunt_rockgp2_
	g_BarcosAss[77] = CreateDynamicObject(690, 853.8359, -3566.0603, 1.6765, 0.0000, 0.0000, 0.0000); //sm_fir_copse2
	g_BarcosAss[78] = CreateDynamicObject(17026, 836.3535, -3670.7744, -10.7883, -4.2999, -2.7000, 48.7999); //cunt_rockgp2_
	g_BarcosAss[79] = CreateDynamicObject(690, 869.8565, -3559.7072, 1.6765, 0.0000, 0.0000, 0.0000); //sm_fir_copse2
	g_BarcosAss[80] = CreateDynamicObject(690, 882.2362, -3555.6691, 1.6765, 0.0000, 0.0000, 35.2999); //sm_fir_copse2
	g_BarcosAss[81] = CreateDynamicObject(690, 884.7611, -3565.1525, 1.6765, 0.0000, 0.0000, 35.2999); //sm_fir_copse2
	g_BarcosAss[82] = CreateDynamicObject(690, 898.3483, -3553.8168, 1.6765, 0.0000, 0.0000, 35.2999); //sm_fir_copse2
	g_BarcosAss[83] = CreateDynamicObject(690, 898.1035, -3560.7900, 1.6765, 0.0000, 0.0000, 35.2999); //sm_fir_copse2
	g_BarcosAss[84] = CreateDynamicObject(17026, 836.3535, -3670.7744, -10.7883, -4.2999, -2.7000, 48.7999); //cunt_rockgp2_
	g_BarcosAss[85] = CreateDynamicObject(17026, 862.1795, -3666.5468, -14.8002, -4.2999, -2.7000, 45.7999); //cunt_rockgp2_
	g_BarcosAss[86] = CreateDynamicObject(690, 911.3884, -3551.3640, 1.6765, 0.0000, 0.0000, 74.8000); //sm_fir_copse2
	g_BarcosAss[87] = CreateDynamicObject(690, 920.5037, -3555.4560, 1.6765, 0.0000, 0.0000, 74.8000); //sm_fir_copse2
	g_BarcosAss[88] = CreateDynamicObject(690, 919.9757, -3569.7888, 1.6765, 0.0000, 0.0000, 74.8000); //sm_fir_copse2
	g_BarcosAss[89] = CreateDynamicObject(690, 919.8665, -3582.0878, 1.6765, 0.0000, 0.0000, 74.8000); //sm_fir_copse2
	g_BarcosAss[90] = CreateDynamicObject(17026, 863.4104, -3675.0585, -16.4197, -4.2999, -2.7000, 71.0999); //cunt_rockgp2_
	g_BarcosAss[91] = CreateDynamicObject(690, 921.7758, -3592.6030, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[92] = CreateDynamicObject(690, 925.1204, -3604.1613, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[93] = CreateDynamicObject(17026, 869.9467, -3674.1657, -18.1252, -4.2999, -2.7000, 71.0999); //cunt_rockgp2_
	g_BarcosAss[94] = CreateDynamicObject(17026, 892.7443, -3672.0910, -12.7386, -4.2999, -2.7000, 77.9000); //cunt_rockgp2_
	g_BarcosAss[95] = CreateDynamicObject(690, 920.9713, -3612.9272, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[96] = CreateDynamicObject(690, 921.3790, -3629.6762, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[97] = CreateDynamicObject(17026, 903.8870, -3675.6105, -14.3358, -4.2999, -2.7000, 77.9000); //cunt_rockgp2_
	g_BarcosAss[98] = CreateDynamicObject(17026, 903.8870, -3675.6105, -14.3358, -4.2999, -2.7000, 77.9000); //cunt_rockgp2_
	g_BarcosAss[99] = CreateDynamicObject(690, 916.7133, -3642.9504, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[100] = CreateDynamicObject(17026, 917.5529, -3677.7197, -15.2175, -4.2999, -2.7000, 77.9000); //cunt_rockgp2_
	g_BarcosAss[101] = CreateDynamicObject(690, 898.3463, -3640.7524, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[102] = CreateDynamicObject(17026, 930.2390, -3679.7624, -15.9783, -4.2999, -2.7000, 77.9000); //cunt_rockgp2_
	g_BarcosAss[103] = CreateDynamicObject(17026, 930.2390, -3679.7624, -15.9783, -4.2999, -2.7000, 77.9000); //cunt_rockgp2_
	g_BarcosAss[104] = CreateDynamicObject(690, 905.3109, -3637.4741, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[105] = CreateDynamicObject(690, 886.2946, -3636.6027, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[106] = CreateDynamicObject(690, 873.7791, -3642.5576, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[107] = CreateDynamicObject(690, 875.6334, -3634.3305, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[108] = CreateDynamicObject(690, 860.7827, -3638.0361, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[109] = CreateDynamicObject(690, 849.3098, -3637.8642, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[110] = CreateDynamicObject(690, 838.0333, -3638.9731, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[111] = CreateDynamicObject(690, 834.8798, -3625.2236, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[112] = CreateDynamicObject(690, 836.1314, -3613.0512, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[113] = CreateDynamicObject(690, 834.9896, -3602.9340, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[114] = CreateDynamicObject(690, 837.0305, -3590.8686, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[115] = CreateDynamicObject(690, 836.9197, -3574.1296, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[116] = CreateDynamicObject(690, 841.1522, -3577.6433, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[117] = CreateDynamicObject(690, 836.9019, -3587.1201, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[118] = CreateDynamicObject(690, 831.6514, -3645.3444, 1.6765, 0.0000, 0.0000, -34.6999); //sm_fir_copse2
	g_BarcosAss[119] = CreateDynamicObject(690, 839.3162, -3550.0373, 1.6765, 0.0000, 0.0000, -18.3999); //sm_fir_copse2
	g_BarcosAss[120] = CreateDynamicObject(690, 853.1450, -3550.4448, 1.6765, 0.0000, 0.0000, -18.3999); //sm_fir_copse2
	g_BarcosAss[121] = CreateDynamicObject(690, 882.0836, -3541.5397, 1.6765, 0.0000, 0.0000, -18.3999); //sm_fir_copse2
	g_BarcosAss[122] = CreateDynamicObject(690, 870.2800, -3552.4870, 1.6765, 0.0000, 0.0000, 24.0998); //sm_fir_copse2
	g_BarcosAss[123] = CreateDynamicObject(690, 924.0291, -3546.8183, 1.6765, 0.0000, 0.0000, 24.0998); //sm_fir_copse2
	g_BarcosAss[124] = CreateDynamicObject(690, 900.6536, -3542.8583, 1.6765, 0.0000, 0.0000, 24.0998); //sm_fir_copse2
	g_BarcosAss[125] = CreateDynamicObject(2332, 866.6682, -3586.2739, 2.6763, 0.0000, 0.0000, 90.0000); //KEV_SAFE
	g_BarcosAss[126] = CreateDynamicObject(7040, 906.3670, -3607.2617, 5.4984, 0.0000, 0.0000, 90.0000); //vgnplcehldbox01
	g_BarcosAss[127] = CreateDynamicObject(2991, 891.0946, -3575.4326, 2.8038, 0.0000, 0.0000, 0.0000); //imy_bbox
	g_BarcosAss[128] = CreateDynamicObject(3577, 895.4251, -3576.0119, 2.9323, 0.0000, 0.0000, 90.0000); //DockCrates1_LA
	g_BarcosAss[129] = CreateDynamicObject(2934, 904.5737, -3619.6381, 3.4830, 0.0000, 0.0000, 95.0998); //kmb_container_red
	g_BarcosAss[130] = CreateDynamicObject(19893, 891.7139, -3575.8488, 3.4328, 0.0000, 0.0000, 39.9000); //LaptopSAMP1
	g_BarcosAss[131] = CreateDynamicObject(19941, 890.4697, -3575.9709, 3.4226, 0.0000, 0.0000, 14.5999); //GoldBar1
	g_BarcosAss[132] = CreateDynamicObject(19941, 890.8438, -3576.0187, 3.4226, 0.0000, 0.0000, -48.7000); //GoldBar1
	g_BarcosAss[133] = CreateDynamicObject(2934, 905.3441, -3628.8364, 3.5230, 0.0000, 0.0000, 95.0998); //kmb_container_red
	g_BarcosAss[134] = CreateDynamicObject(19941, 890.9224, -3575.7895, 3.4226, 0.0000, 0.0000, -79.6998); //GoldBar1
	g_BarcosAss[135] = CreateDynamicObject(2934, 905.0950, -3625.8161, 3.5330, 0.0000, 0.0000, 95.0998); //kmb_container_red
	g_BarcosAss[136] = CreateDynamicObject(2934, 904.8479, -3622.7128, 3.4930, 0.0000, 0.0000, 95.0998); //kmb_container_red
	g_BarcosAss[137] = CreateDynamicObject(19941, 890.2913, -3576.1191, 3.4226, 0.0000, 0.0000, -69.0998); //GoldBar1
	g_BarcosAss[138] = CreateDynamicObject(2934, 904.9490, -3625.8701, 6.3130, 0.0000, 0.0000, 95.0998); //kmb_container_red
	g_BarcosAss[139] = CreateDynamicObject(19941, 890.2979, -3575.7709, 3.4226, 0.0000, 0.0000, -123.0999); //GoldBar1
	g_BarcosAss[140] = CreateDynamicObject(2934, 904.6790, -3622.8430, 6.3130, 0.0000, 0.0000, 95.0998); //kmb_container_red
	g_BarcosAss[141] = CreateDynamicObject(3279, 854.4439, -3579.0886, 1.7861, 0.0000, 0.0000, 0.0000); //a51_spottower
	g_BarcosAss[142] = CreateDynamicObject(18257, 852.7926, -3629.7475, 2.1777, 0.0000, 0.0000, 0.0000); //crates
	g_BarcosAss[143] = CreateDynamicObject(18257, 852.7926, -3624.3371, 2.1777, 0.0000, 0.0000, 0.0000); //crates
	g_BarcosAss[144] = CreateDynamicObject(1580, 854.0142, -3621.9992, 4.1466, 0.0000, 0.0000, 0.0000); //drug_red
	g_BarcosAss[145] = CreateDynamicObject(1580, 853.5440, -3621.3686, 4.1466, 0.0000, 0.0000, 41.7000); //drug_red
	g_BarcosAss[146] = CreateDynamicObject(1580, 852.7656, -3620.4960, 2.1266, 0.0000, 0.0000, 41.7000); //drug_red
	g_BarcosAss[147] = CreateDynamicObject(1580, 854.6453, -3619.9606, 2.1266, 0.0000, 0.0000, -17.4999); //drug_red
	g_BarcosAss[148] = CreateDynamicObject(1580, 855.3212, -3621.4729, 2.1266, 0.0000, 0.0000, 30.2000); //drug_red
	g_BarcosAss[149] = CreateDynamicObject(1580, 854.1766, -3626.7421, 4.1567, 0.0000, 0.0000, 30.2000); //drug_red
	g_BarcosAss[150] = CreateDynamicObject(1580, 853.7861, -3627.5822, 4.1567, 0.0000, 0.0000, 97.0000); //drug_red
	g_BarcosAss[151] = CreateDynamicObject(1432, 885.0685, -3577.4299, 2.2577, 0.0000, 0.0000, 0.0000); //DYN_TABLE_2
	g_BarcosAss[152] = CreateDynamicObject(1712, 871.2283, -3576.9914, 2.1589, 0.0000, 0.0000, -90.0000); //kb_couch05
	g_BarcosAss[153] = CreateDynamicObject(1712, 867.8179, -3578.4829, 2.1589, 0.0000, 0.0000, 90.0000); //kb_couch05
	g_BarcosAss[154] = CreateDynamicObject(1433, 869.3792, -3577.7082, 2.3532, 0.0000, 0.0000, 0.0000); //DYN_TABLE_1
	g_BarcosAss[155] = CreateDynamicObject(1577, 869.2052, -3577.5729, 2.8225, 0.0000, 0.0000, 26.0999); //drug_yellow
	g_BarcosAss[156] = CreateDynamicObject(19941, 869.7009, -3577.4235, 2.8565, 0.0000, 0.0000, 0.0000); //GoldBar1
	g_BarcosAss[157] = CreateDynamicObject(19941, 869.7009, -3577.8840, 2.8565, 0.0000, 0.0000, -56.1999); //GoldBar1
	g_BarcosAss[158] = CreateDynamicObject(19941, 869.2493, -3578.0187, 2.8565, 0.0000, 0.0000, -112.9999); //GoldBar1
	g_BarcosAss[159] = CreateDynamicObject(1299, 876.8181, -3590.0019, 2.4372, 0.0000, 0.0000, 0.0000); //smashboxpile
	g_BarcosAss[160] = CreateDynamicObject(925, 887.7234, -3588.3881, 3.2343, 0.0000, 0.0000, -90.0000); //RACK2
	g_BarcosAss[161] = CreateDynamicObject(944, 887.8593, -3577.4003, 3.0330, 0.0000, 0.0000, 90.0000); //Packing_carates04
	g_BarcosAss[162] = CreateDynamicObject(922, 877.2492, -3575.1088, 3.0762, 0.0000, 0.0000, 0.0000); //Packing_carates1
	g_BarcosAss[163] = CreateDynamicObject(2991, 904.9135, -3570.8591, 2.8374, 0.0000, 0.0000, 0.0000); //imy_bbox
	g_BarcosAss[164] = CreateDynamicObject(1550, 866.7035, -3585.4716, 2.5511, 0.0000, 0.0000, -71.3999); //CJ_MONEY_BAG
	g_BarcosAss[165] = CreateDynamicObject(1550, 866.6732, -3584.8806, 2.5511, 0.0000, 0.0000, -126.2999); //CJ_MONEY_BAG
	g_BarcosAss[166] = CreateDynamicObject(2991, 908.9134, -3570.8591, 2.8374, 0.0000, 0.0000, 0.0000); //imy_bbox
	g_BarcosAss[167] = CreateDynamicObject(1550, 867.1819, -3585.1667, 2.5511, 0.0000, 0.0000, 166.6999); //CJ_MONEY_BAG
	g_BarcosAss[168] = CreateDynamicObject(2991, 907.0234, -3570.8591, 4.0674, 0.0000, 0.0000, 0.0000); //imy_bbox
	g_BarcosAss[169] = CreateDynamicObject(19941, 866.5274, -3586.4047, 3.1481, 0.0000, 0.0000, 21.4999); //GoldBar1
	g_BarcosAss[170] = CreateDynamicObject(19941, 866.5017, -3586.3398, 3.1481, 0.0000, 0.0000, 21.4999); //GoldBar1
	g_BarcosAss[171] = CreateDynamicObject(19941, 866.4761, -3586.2749, 3.1481, 0.0000, 0.0000, 21.4999); //GoldBar1
	g_BarcosAss[172] = CreateDynamicObject(19941, 866.5017, -3586.3398, 3.1881, 0.0000, 0.0000, 21.4999); //GoldBar1
	g_BarcosAss[173] = CreateDynamicObject(19941, 866.6274, -3586.0329, 3.1481, 0.0000, 0.0000, -21.2000); //GoldBar1
	g_BarcosAss[174] = CreateDynamicObject(19941, 866.3409, -3586.0280, 3.1481, 0.0000, 0.0000, -104.6000); //GoldBar1
	g_BarcosAss[175] = CreateDynamicObject(19941, 866.7116, -3586.5507, 3.1481, 0.0000, 0.0000, -143.4999); //GoldBar1
	g_BarcosAss[176] = CreateDynamicObject(19921, 910.1293, -3570.9223, 3.5596, 0.0000, 0.0000, -39.5999); //CutsceneToolBox1
	g_BarcosAss[177] = CreateDynamicObject(1348, 866.6782, -3588.4111, 2.7968, 0.0000, 0.0000, 90.0000); //CJ_O2Tanks
	g_BarcosAss[178] = CreateDynamicObject(3046, 866.7416, -3589.8244, 2.6405, 90.0000, 0.0000, 0.0000); //kb_barrel
	g_BarcosAss[179] = CreateDynamicObject(19921, 904.0486, -3571.0703, 3.5596, 0.0000, 0.0000, 19.5000); //CutsceneToolBox1
	g_BarcosAss[180] = CreateDynamicObject(19805, 868.9678, -3584.3789, 4.1562, 0.0000, 0.0000, 180.0000); //Whiteboard1
	g_BarcosAss[181] = CreateDynamicObject(2717, 869.1090, -3584.3659, 3.8403, 0.0000, 0.0000, 0.0000); //CJ_DON_POSTER2
	SetObjectMaterialText(g_BarcosAss[181], "û", 0, 90, "Webdings", 115, 0, 0xFF1E9948, 0x0, 0);
	g_BarcosAss[182] = CreateDynamicObject(2717, 869.2788, -3584.3659, 4.1403, 0.0000, 0.0000, 0.0000); //CJ_DON_POSTER2
	SetObjectMaterialText(g_BarcosAss[182], "Industrias", 0, 90, "Verdana", 50, 1, 0xFF1E4C99, 0x0, 0);
	g_BarcosAss[183] = CreateDynamicObject(2717, 868.7886, -3584.3659, 4.1403, 0.0000, 0.0000, 0.0000); //CJ_DON_POSTER2
	SetObjectMaterialText(g_BarcosAss[183], "PFC", 0, 90, "Verdana", 50, 1, 0xFF1E4C99, 0x0, 0);
	g_BarcosAss[184] = CreateDynamicObject(19878, 848.7465, -3627.5859, 2.5987, 0.0000, 66.7000, 0.0000); //Skateboard1
	g_BarcosAss[185] = CreateDynamicObject(10757, 809.0017, -3606.4370, 14.5224, 27.8999, -0.3999, 56.5000); //Airport_04_SFSe
	g_BarcosAss[186] = CreateDynamicObject(11713, 888.5843, -3585.5344, 4.0106, 0.0000, 0.0000, 180.0000); //FireExtPanel1
	g_BarcosAss[187] = CreateDynamicObject(898, 848.0908, -3666.2954, 0.8812, 0.0000, 0.0000, 0.0000); //searock02
	g_BarcosAss[188] = CreateDynamicObject(898, 824.5008, -3663.8845, -2.1787, 0.0000, 0.0000, 0.0000); //searock02
	g_BarcosAss[189] = CreateDynamicObject(899, 927.9313, -3672.5126, -4.3792, 0.0000, 0.0000, 0.0000); //searock03
	g_BarcosAss[190] = CreateDynamicObject(898, 809.2285, -3578.2824, -3.6782, 0.0000, 0.0000, 0.0000); //searock02
	g_BarcosAss[191] = CreateDynamicObject(899, 933.0508, -3521.0446, -4.3792, 0.0000, 0.0000, 0.0000); //searock03
	g_BarcosAss[192] = CreateDynamicObject(898, 828.0400, -3537.7282, -1.2143, 0.0000, 0.0000, 0.0000); //searock02

	return 1;
}