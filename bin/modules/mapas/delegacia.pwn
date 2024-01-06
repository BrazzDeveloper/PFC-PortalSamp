#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	new g_Delegacia;
	g_Delegacia = CreateDynamicObject(3976, 1571.605590, -1675.758300, 35.666999, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(g_Delegacia, 4, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
	SetDynamicObjectMaterial(g_Delegacia, 5, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
	SetDynamicObjectMaterial(g_Delegacia, 6, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
	SetDynamicObjectMaterial(g_Delegacia, 7, 6873, "vgnshambild1", "glasswindow3b_256", 0x00000000);
	SetDynamicObjectMaterial(g_Delegacia, 8, 5766, "capitol_lawn", "vgs_whitewall_128", 0x00000000);
	SetDynamicObjectMaterial(g_Delegacia, 9, 14846, "genintintpoliceb", "p_floor3", 0x00000000);
	SetDynamicObjectMaterial(g_Delegacia, 10, 14876, "gf4", "mp_tank_floor", 0x00000000);
	SetDynamicObjectMaterial(g_Delegacia, 11, 12855, "cunte_cop", "sw_copgrass01", 0x00000000);
	SetDynamicObjectMaterial(g_Delegacia, 12, 6873, "vgnshambild1", "glasswindow3b_256", 0x00000000);
	SetDynamicObjectMaterial(g_Delegacia, 13, 3314, "ce_burbhouse", "sw_wallbrick_06", 0x00000000);
	g_Delegacia = CreateDynamicObject(19371, 1555.139404, -1675.610717, 22.021181, 180.000000, 180.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(g_Delegacia, 0, 7009, "vgndwntwn1", "newpolice_sa", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	g_Delegacia = CreateDynamicObject(1361, 1545.539550, -1672.442749, 13.274788, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(1361, 1545.539550, -1678.793579, 13.274788, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(1361, 1554.430786, -1677.772827, 15.904779, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(1361, 1554.430786, -1673.482177, 15.904779, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(3517, 1546.236206, -1661.464843, 22.672653, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(3517, 1546.236206, -1690.005493, 22.672653, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(1364, 1542.900756, -1658.575195, 13.316873, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(1364, 1542.900756, -1664.206176, 13.316873, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(1364, 1542.900756, -1686.787231, 13.316873, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(1364, 1542.900756, -1693.027832, 13.316873, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(3517, 1541.356201, -1643.727172, 22.672653, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(3517, 1541.356201, -1707.467285, 22.672653, 0.000000, 0.000000, 495.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(1360, 1538.618652, -1703.800659, 13.282101, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(1360, 1538.618652, -1711.662475, 13.282101, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(1360, 1538.618652, -1647.701171, 13.282101, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	g_Delegacia = CreateDynamicObject(1360, 1538.618652, -1640.250366, 13.282101, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 

	// Interior
	new g_DelegaciaInt[413];
	g_DelegaciaInt[0] = CreateObject(19454, 347.4367, 4551.6010, 133.9633, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[0], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[1] = CreateObject(2603, 387.5046, 4531.3471, 133.5706, 0.0000, 0.1000, -90.2000); //Police_Cell_Bed
	g_DelegaciaInt[2] = CreateObject(19454, 347.4367, 4536.9013, 133.9633, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[2], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[3] = CreateObject(19454, 352.2266, 4532.0161, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[3], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[4] = CreateObject(19454, 361.8165, 4532.0161, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[4], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[5] = CreateObject(19454, 352.2466, 4556.4902, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[5], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[6] = CreateObject(19454, 371.2959, 4532.0161, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[6], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[7] = CreateObject(19454, 376.0260, 4527.2695, 133.9633, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[7], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[8] = CreateObject(19454, 361.8665, 4556.4902, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[8], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[9] = CreateObject(19454, 371.4761, 4556.4902, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[9], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[10] = CreateObject(19454, 376.0260, 4517.6914, 133.9633, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[10], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[11] = CreateObject(1491, 379.0886, 4532.0395, 132.1913, 0.0000, 0.0000, 180.0000); //Gen_doorINT01
	SetObjectMaterial(g_DelegaciaInt[11], 0, 9919, "grnwht_sfe", "sl_dtdoor1", 0xFFFFFFFF);
	g_DelegaciaInt[12] = CreateObject(19454, 377.2359, 4532.0161, 136.4236, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[12], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[13] = CreateObject(19454, 383.8958, 4532.0161, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[13], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[14] = CreateObject(19454, 388.7857, 4527.2695, 133.9633, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[14], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[15] = CreateObject(19454, 381.0161, 4556.4902, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[15], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[16] = CreateObject(19454, 388.7755, 4517.7753, 133.9633, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[16], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[17] = CreateObject(19454, 388.7062, 4542.1376, 133.9833, 0.0000, 0.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[17], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[18] = CreateObject(19454, 383.6959, 4556.4799, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[18], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[19] = CreateObject(19454, 388.6290, 4551.7153, 133.9833, 0.0000, 0.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[19], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[20] = CreateObject(1491, 376.0986, 4532.0200, 132.1913, 0.0000, 0.0000, 0.0000); //Gen_doorINT01
	SetObjectMaterial(g_DelegaciaInt[20], 0, 9919, "grnwht_sfe", "sl_dtdoor1", 0xFFFFFFFF);
	g_DelegaciaInt[21] = CreateObject(19454, 388.7620, 4532.6821, 133.9533, 0.0000, 0.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[21], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[22] = CreateObject(19357, 382.5119, 4525.5200, 133.9424, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(g_DelegaciaInt[22], 0, 14842, "genintintpolicea", "copcell_bars", 0xFFFFFFFF);
	g_DelegaciaInt[23] = CreateObject(19427, 382.5102, 4527.9130, 133.9371, 0.0000, 0.0000, 0.0000); //wall067
	SetObjectMaterial(g_DelegaciaInt[23], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[24] = CreateObject(2603, 387.5046, 4531.3471, 132.6607, 0.0000, 0.1000, -90.2000); //Police_Cell_Bed
	g_DelegaciaInt[25] = CreateObject(19357, 382.5119, 4530.3144, 133.9424, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(g_DelegaciaInt[25], 0, 14842, "genintintpolicea", "copcell_bars", 0xFFFFFFFF);
	g_DelegaciaInt[26] = CreateObject(19427, 382.5102, 4518.3193, 133.9371, 0.0000, 0.0000, 0.0000); //wall067
	SetObjectMaterial(g_DelegaciaInt[26], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[27] = CreateObject(19427, 382.5102, 4523.0878, 133.9371, 0.0000, 0.0000, 0.0000); //wall067
	SetObjectMaterial(g_DelegaciaInt[27], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[28] = CreateObject(19357, 382.5119, 4520.7270, 133.9424, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(g_DelegaciaInt[28], 0, 14842, "genintintpolicea", "copcell_bars", 0xFFFFFFFF);
	g_DelegaciaInt[29] = CreateObject(19427, 382.5102, 4513.5468, 133.9371, 0.0000, 0.0000, 0.0000); //wall067
	SetObjectMaterial(g_DelegaciaInt[29], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[30] = CreateObject(19454, 387.4154, 4527.9956, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[30], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[31] = CreateObject(19357, 382.5119, 4515.9453, 133.9424, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(g_DelegaciaInt[31], 0, 14842, "genintintpolicea", "copcell_bars", 0xFFFFFFFF);
	g_DelegaciaInt[32] = CreateObject(2162, 385.5969, 4556.3872, 132.2058, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_1
	g_DelegaciaInt[33] = CreateObject(19786, 388.6181, 4551.9301, 134.1542, 0.0000, 0.0000, -90.0000); //LCDTVBig1
	g_DelegaciaInt[34] = CreateObject(2524, 388.1788, 4520.3632, 132.2039, 0.0000, 0.0000, -89.8999); //CJ_B_SINK4
	g_DelegaciaInt[35] = CreateObject(19454, 387.4154, 4523.1469, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[35], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[36] = CreateObject(19454, 387.3554, 4518.3906, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[36], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[37] = CreateObject(1437, 388.2801, 4526.7036, 128.7865, 9.3000, -0.2999, 0.5999); //DYN_LADDER_2
	g_DelegaciaInt[38] = CreateObject(19454, 384.0056, 4512.9121, 133.9234, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[38], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[39] = CreateObject(19454, 374.4260, 4512.9121, 133.9234, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[39], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[40] = CreateObject(19176, 347.5473, 4544.3344, 133.6652, 0.0000, 0.0000, 90.0000); //LSOffice1Door1
	g_DelegaciaInt[41] = CreateObject(19454, 347.3866, 4544.2700, 133.9633, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[41], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[42] = CreateObject(19454, 363.5561, 4551.5766, 133.9633, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[42], 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	g_DelegaciaInt[43] = CreateObject(19454, 368.2866, 4546.8403, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[43], 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	g_DelegaciaInt[44] = CreateObject(19529, 409.9858, 4551.8037, 132.2308, 0.0000, 0.0000, 0.0000); //Plane125x125Grass1
	SetObjectMaterial(g_DelegaciaInt[44], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[45] = CreateObject(2603, 387.4902, 4527.3281, 133.5934, 0.0000, 0.1000, -90.2000); //Police_Cell_Bed
	g_DelegaciaInt[46] = CreateObject(2603, 387.4907, 4527.3286, 132.6939, 0.0000, 0.1000, -90.2000); //Police_Cell_Bed
	g_DelegaciaInt[47] = CreateObject(19454, 377.8459, 4546.8403, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[47], 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	g_DelegaciaInt[48] = CreateObject(19454, 387.4159, 4546.8403, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[48], 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	g_DelegaciaInt[49] = CreateObject(19454, 391.9960, 4546.8339, 133.9833, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[49], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[50] = CreateObject(2603, 387.4734, 4522.5361, 133.5850, 0.0000, 0.1000, -90.2000); //Police_Cell_Bed
	g_DelegaciaInt[51] = CreateObject(1569, 383.5139, 4546.8037, 132.1772, 0.0000, 0.0000, 0.0000); //ADAM_V_DOOR
	g_DelegaciaInt[52] = CreateObject(2603, 387.4734, 4522.5361, 132.6950, 0.0000, 0.1000, -90.2000); //Police_Cell_Bed
	g_DelegaciaInt[53] = CreateObject(2603, 387.4566, 4517.7578, 132.6767, 0.0000, 0.1000, -90.2000); //Police_Cell_Bed
	g_DelegaciaInt[54] = CreateObject(2603, 387.4566, 4517.7578, 133.5867, 0.0000, 0.1000, -90.2000); //Police_Cell_Bed
	g_DelegaciaInt[55] = CreateObject(2208, 380.3014, 4551.8115, 132.2116, 0.0000, 0.0000, 0.0000); //MED_OFFICE7_UNIT_1
	SetObjectMaterial(g_DelegaciaInt[55], 0, 18065, "ab_sfammumain", "plywood_gym", 0xFFFFFFFF);
	g_DelegaciaInt[56] = CreateObject(2524, 390.9877, 4524.1425, 129.9636, 0.0000, 0.0000, 0.0000); //CJ_B_SINK4
	g_DelegaciaInt[57] = CreateObject(2524, 388.1852, 4525.0668, 132.2737, 0.0000, 0.0000, -89.7999); //CJ_B_SINK4
	g_DelegaciaInt[58] = CreateObject(2208, 377.5817, 4551.8115, 132.2116, 0.0000, 0.0000, 0.0000); //MED_OFFICE7_UNIT_1
	SetObjectMaterial(g_DelegaciaInt[58], 0, 18065, "ab_sfammumain", "plywood_gym", 0xFFFFFFFF);
	g_DelegaciaInt[59] = CreateObject(2208, 374.8022, 4551.8115, 132.2116, 0.0000, 0.0000, 0.0000); //MED_OFFICE7_UNIT_1
	SetObjectMaterial(g_DelegaciaInt[59], 0, 18065, "ab_sfammumain", "plywood_gym", 0xFFFFFFFF);
	g_DelegaciaInt[60] = CreateObject(19999, 384.1091, 4551.8901, 132.1929, 0.0000, 0.0000, -75.5999); //CutsceneChair2
	g_DelegaciaInt[61] = CreateObject(19999, 381.4331, 4550.6088, 132.1929, 0.0000, 0.0000, 178.4000); //CutsceneChair2
	g_DelegaciaInt[62] = CreateObject(2524, 388.1689, 4529.7172, 132.2737, 0.0000, 0.0000, -89.7999); //CJ_B_SINK4
	g_DelegaciaInt[63] = CreateObject(19999, 378.8241, 4550.6816, 132.1929, 0.0000, 0.0000, -155.7999); //CutsceneChair2
	g_DelegaciaInt[64] = CreateObject(19999, 376.2052, 4550.7558, 132.1929, 0.0000, 0.0000, 167.1999); //CutsceneChair2
	g_DelegaciaInt[65] = CreateObject(2524, 388.1887, 4515.1127, 132.2039, 0.0000, 0.0000, -89.8999); //CJ_B_SINK4
	g_DelegaciaInt[66] = CreateObject(19999, 373.6068, 4551.7216, 132.1929, 0.0000, 0.0000, 97.1000); //CutsceneChair2
	g_DelegaciaInt[67] = CreateObject(2261, 388.0663, 4548.6704, 133.9248, 0.0000, 0.0000, -90.0000); //Frame_SLIM_2
	g_DelegaciaInt[68] = CreateObject(19999, 376.4315, 4552.9746, 132.1929, 0.0000, 0.0000, 0.6999); //CutsceneChair2
	g_DelegaciaInt[69] = CreateObject(19999, 378.8361, 4553.0439, 132.1929, 0.0000, 0.0000, 38.4001); //CutsceneChair2
	g_DelegaciaInt[70] = CreateObject(19999, 381.5002, 4553.0117, 132.1929, 0.0000, 0.0000, -8.6000); //CutsceneChair2
	g_DelegaciaInt[71] = CreateObject(11706, 387.8524, 4555.9028, 132.2254, 0.0000, 0.0000, -36.2000); //SmallWasteBin1
	g_DelegaciaInt[72] = CreateObject(2204, 382.6466, 4556.3251, 132.1815, 0.0000, 0.0000, 0.0000); //MED_OFFICE8_CABINET
	g_DelegaciaInt[73] = CreateObject(2167, 388.5256, 4549.4990, 132.2120, 0.0000, 0.0000, -90.0000); //MED_OFFICE_UNIT_7
	g_DelegaciaInt[74] = CreateObject(2167, 388.5256, 4548.6069, 132.2120, 0.0000, 0.0000, -90.0000); //MED_OFFICE_UNIT_7
	g_DelegaciaInt[75] = CreateObject(2167, 388.5256, 4547.6992, 132.2120, 0.0000, 0.0000, -90.0000); //MED_OFFICE_UNIT_7
	g_DelegaciaInt[76] = CreateObject(2167, 378.9519, 4556.3823, 132.1998, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_7
	g_DelegaciaInt[77] = CreateObject(2167, 378.0417, 4556.3823, 132.1998, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_7
	g_DelegaciaInt[78] = CreateObject(2163, 376.2824, 4556.3837, 132.2057, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_2
	g_DelegaciaInt[79] = CreateObject(2002, 375.0180, 4555.8969, 132.2150, 0.0000, 0.0000, 0.0000); //water_coolnu
	g_DelegaciaInt[80] = CreateObject(2007, 373.6939, 4555.9062, 132.2172, 0.0000, 0.0000, 0.0000); //filing_cab_nu01
	g_DelegaciaInt[81] = CreateObject(2007, 372.7035, 4555.9062, 132.2172, 0.0000, 0.0000, 0.0000); //filing_cab_nu01
	g_DelegaciaInt[82] = CreateObject(2007, 371.7235, 4555.9062, 132.2172, 0.0000, 0.0000, 0.0000); //filing_cab_nu01
	g_DelegaciaInt[83] = CreateObject(2007, 370.7436, 4555.9062, 132.2172, 0.0000, 0.0000, 0.0000); //filing_cab_nu01
	g_DelegaciaInt[84] = CreateObject(2164, 368.1654, 4556.3720, 132.1941, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_5
	g_DelegaciaInt[85] = CreateObject(2163, 366.3923, 4556.3837, 132.2057, 0.0000, 0.0000, 0.0000); //MED_OFFICE_UNIT_2
	g_DelegaciaInt[86] = CreateObject(19893, 376.0140, 4551.6796, 133.0845, 0.0000, 0.0000, -27.5000); //LaptopSAMP1
	g_DelegaciaInt[87] = CreateObject(19893, 380.7807, 4551.6567, 133.0754, 2.1000, 0.0000, 32.4999); //LaptopSAMP1
	g_DelegaciaInt[88] = CreateObject(2614, 372.1686, 4556.3647, 134.6172, 0.0000, 0.0000, 0.0000); //CJ_US_FLAG
	g_DelegaciaInt[89] = CreateObject(1776, 380.7302, 4556.0024, 133.2168, 0.0000, 0.0000, 0.0000); //CJ_CANDYVENDOR
	g_DelegaciaInt[90] = CreateObject(3850, 375.5075, 4546.8125, 136.3086, 0.0000, 0.0000, 90.0000); //carshowbann_SFSX
	g_DelegaciaInt[91] = CreateObject(19454, 389.3626, 4536.8569, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[91], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[92] = CreateObject(19454, 389.2555, 4546.4331, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[92], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[93] = CreateObject(19454, 385.8154, 4546.4150, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[93], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[94] = CreateObject(19454, 385.8828, 4536.8061, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[94], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[95] = CreateObject(19454, 385.7488, 4555.9897, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[95], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[96] = CreateObject(19454, 389.2287, 4556.0146, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[96], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[97] = CreateObject(19454, 382.2996, 4551.5869, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[97], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[98] = CreateObject(19454, 378.8196, 4551.5654, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[98], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[99] = CreateObject(19454, 375.3401, 4551.5390, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[99], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[100] = CreateObject(19454, 371.8904, 4551.5102, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[100], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[101] = CreateObject(3850, 384.1272, 4541.6196, 136.3086, 0.0000, 0.0000, 0.0000); //carshowbann_SFSX
	g_DelegaciaInt[102] = CreateObject(3850, 384.1272, 4545.0834, 136.3086, 0.0000, 0.0000, 0.0000); //carshowbann_SFSX
	g_DelegaciaInt[103] = CreateObject(19454, 368.4107, 4551.4863, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[103], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[104] = CreateObject(19454, 366.6304, 4551.4770, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[104], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[105] = CreateObject(3850, 384.1272, 4534.9404, 136.3086, 0.0000, 0.0000, 0.0000); //carshowbann_SFSX
	g_DelegaciaInt[106] = CreateObject(19454, 366.5635, 4561.0395, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[106], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[107] = CreateObject(19454, 370.0329, 4561.0625, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[107], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[108] = CreateObject(3850, 384.1272, 4531.5175, 136.3086, 0.0000, 0.0000, 0.0000); //carshowbann_SFSX
	g_DelegaciaInt[109] = CreateObject(19454, 373.5228, 4561.0888, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[109], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[110] = CreateObject(19454, 376.9827, 4561.1103, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[110], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[111] = CreateObject(19454, 380.4425, 4561.1333, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[111], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[112] = CreateObject(19454, 383.8524, 4561.1577, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[112], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[113] = CreateObject(3850, 382.3973, 4546.8125, 136.3086, 0.0000, 0.0000, 90.0000); //carshowbann_SFSX
	g_DelegaciaInt[114] = CreateObject(19454, 386.0859, 4532.0161, 137.5535, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[114], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[115] = CreateObject(3850, 378.9673, 4546.8125, 136.3086, 0.0000, 0.0000, 90.0000); //carshowbann_SFSX
	g_DelegaciaInt[116] = CreateObject(3850, 372.0575, 4546.8125, 136.3086, 0.0000, 0.0000, 90.0000); //carshowbann_SFSX
	g_DelegaciaInt[117] = CreateObject(19454, 383.8958, 4532.0161, 133.9633, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[117], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[118] = CreateObject(14416, 382.1539, 4538.2709, 132.6148, 0.0000, 0.0000, -90.0000); //carter-stairs07
	SetObjectMaterial(g_DelegaciaInt[118], 0, 14668, "711c", "cj_white_wall2", 0xFFFFFFFF);
	g_DelegaciaInt[119] = CreateObject(3850, 368.6377, 4546.8125, 136.3086, 0.0000, 0.0000, 90.0000); //carshowbann_SFSX
	g_DelegaciaInt[120] = CreateObject(3850, 365.2278, 4546.8125, 136.3086, 0.0000, 0.0000, 90.0000); //carshowbann_SFSX
	g_DelegaciaInt[121] = CreateObject(3533, 387.1327, 4534.3720, 135.2174, 0.0000, 0.0000, 0.0000); //trdpillar01
	SetObjectMaterial(g_DelegaciaInt[121], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[122] = CreateObject(19454, 358.6663, 4548.4350, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[122], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[123] = CreateObject(19454, 363.3959, 4560.9951, 137.5728, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[123], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[124] = CreateObject(19454, 365.1904, 4551.4677, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[124], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[125] = CreateObject(19454, 365.1234, 4561.0473, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[125], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[126] = CreateObject(19454, 363.3959, 4551.4233, 137.5728, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[126], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[127] = CreateObject(19454, 358.6559, 4546.7075, 137.5728, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[127], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[128] = CreateObject(19454, 349.1860, 4546.7075, 137.5728, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[128], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[129] = CreateObject(19454, 349.2167, 4548.4350, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[129], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[130] = CreateObject(19454, 349.2167, 4551.8647, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[130], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[131] = CreateObject(19454, 349.2167, 4555.1411, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[131], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[132] = CreateObject(19454, 358.6672, 4555.1411, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[132], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[133] = CreateObject(19454, 358.6672, 4551.8398, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[133], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[134] = CreateObject(19454, 384.0358, 4536.3784, 130.7634, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[134], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[135] = CreateObject(19454, 384.3459, 4536.3784, 130.9833, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[135], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[136] = CreateObject(19454, 384.6660, 4536.3784, 131.2031, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[136], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[137] = CreateObject(19454, 384.9861, 4536.3784, 131.4231, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[137], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[138] = CreateObject(19454, 385.3063, 4536.3784, 131.6429, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[138], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[139] = CreateObject(19454, 385.6264, 4536.3784, 131.8628, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[139], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[140] = CreateObject(19454, 385.9465, 4536.3784, 132.0827, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[140], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[141] = CreateObject(19454, 386.2567, 4536.3784, 132.3027, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[141], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[142] = CreateObject(19454, 386.5769, 4536.3784, 132.5126, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[142], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[143] = CreateObject(19454, 386.8972, 4536.3784, 132.7325, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[143], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[144] = CreateObject(19454, 387.2174, 4536.3784, 132.9524, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[144], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[145] = CreateObject(19454, 387.5375, 4536.3784, 133.1723, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[145], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[146] = CreateObject(19454, 388.1778, 4536.3784, 133.6118, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[146], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[147] = CreateObject(19454, 388.4880, 4536.3784, 133.8317, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[147], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[148] = CreateObject(19454, 388.8081, 4536.3784, 134.0516, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[148], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[149] = CreateObject(19454, 383.7157, 4536.3784, 130.5333, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[149], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[150] = CreateObject(19364, 365.0570, 4552.3276, 137.5015, 0.0000, 0.0000, 90.0000); //wall012
	SetObjectMaterial(g_DelegaciaInt[150], 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	g_DelegaciaInt[151] = CreateObject(19398, 368.2535, 4552.3447, 137.5062, 0.0000, 0.0000, 90.0000); //wall046
	SetObjectMaterial(g_DelegaciaInt[151], 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	g_DelegaciaInt[152] = CreateObject(1491, 367.4768, 4552.3071, 135.7695, 0.0000, 0.0000, 0.0000); //Gen_doorINT01
	SetObjectMaterial(g_DelegaciaInt[152], 0, 10056, "bigoldbuild_sfe", "clubdoor1_256", 0xFFFFFFFF);
	g_DelegaciaInt[153] = CreateObject(19454, 371.3560, 4557.2167, 137.5128, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[153], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[154] = CreateObject(19434, 370.6427, 4552.3530, 137.4981, 0.0000, 0.0000, 90.0000); //wall074
	SetObjectMaterial(g_DelegaciaInt[154], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[155] = CreateObject(19454, 371.3658, 4566.6791, 137.5228, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[155], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[156] = CreateObject(19454, 368.1109, 4565.7954, 137.5728, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[156], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[157] = CreateObject(638, 356.3008, 4549.2656, 132.7989, 0.0000, 0.0000, 180.0000); //kb_planter+bush
	g_DelegaciaInt[158] = CreateObject(3657, 352.5894, 4553.4545, 132.7277, 0.0000, 0.0000, 0.0000); //airseata_LAS
	g_DelegaciaInt[159] = CreateObject(638, 356.3008, 4552.3779, 132.7989, 0.0000, 0.0000, 0.0000); //kb_planter+bush
	g_DelegaciaInt[160] = CreateObject(3657, 359.8796, 4553.4545, 132.7277, 0.0000, 0.0000, 0.0000); //airseata_LAS
	g_DelegaciaInt[161] = CreateObject(3657, 352.5894, 4550.8784, 132.7277, 0.0000, 0.0000, 0.0000); //airseata_LAS
	g_DelegaciaInt[162] = CreateObject(3657, 352.5894, 4548.3417, 132.7277, 0.0000, 0.0000, 0.0000); //airseata_LAS
	g_DelegaciaInt[163] = CreateObject(19454, 377.6270, 4565.6865, 137.5428, 0.0000, 0.0000, -91.0999); //wall094
	SetObjectMaterial(g_DelegaciaInt[163], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[164] = CreateObject(3657, 359.8993, 4550.8784, 132.7277, 0.0000, 0.0000, 0.0000); //airseata_LAS
	g_DelegaciaInt[165] = CreateObject(3657, 359.8894, 4548.3417, 132.7277, 0.0000, 0.0000, 0.0000); //airseata_LAS
	g_DelegaciaInt[166] = CreateObject(19859, 355.4305, 4556.3569, 133.4043, 0.0000, 0.0000, 0.0000); //MIHouse1Door3
	g_DelegaciaInt[167] = CreateObject(19454, 384.0267, 4540.2197, 130.7527, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[167], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[168] = CreateObject(19454, 385.3076, 4540.2197, 131.6424, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[168], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[169] = CreateObject(19454, 390.8057, 4560.6660, 137.5228, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[169], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[170] = CreateObject(19454, 387.2148, 4565.4970, 137.5428, 0.0000, 0.0000, -91.0999); //wall094
	SetObjectMaterial(g_DelegaciaInt[170], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[171] = CreateObject(19454, 384.3470, 4540.2197, 130.9826, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[171], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[172] = CreateObject(19454, 384.6671, 4540.2197, 131.2025, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[172], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[173] = CreateObject(19454, 384.9873, 4540.2197, 131.4224, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[173], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[174] = CreateObject(19454, 385.3076, 4540.2197, 131.6424, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[174], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[175] = CreateObject(19454, 385.6277, 4540.2197, 131.8623, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[175], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[176] = CreateObject(19454, 389.1618, 4565.5180, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[176], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[177] = CreateObject(19454, 385.7225, 4565.4926, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[177], 0, 14846, "genintintpoliceb", "p_floor3", 0xFFFFFFFF);
	g_DelegaciaInt[178] = CreateObject(19454, 385.9379, 4540.2197, 132.0823, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[178], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[179] = CreateObject(19454, 386.2581, 4540.2197, 132.3022, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[179], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[180] = CreateObject(19454, 386.9286, 4540.2197, 132.7319, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[180], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[181] = CreateObject(19454, 386.5784, 4540.2197, 132.5221, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[181], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[182] = CreateObject(19454, 390.8057, 4551.1567, 137.5328, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[182], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[183] = CreateObject(19454, 390.8057, 4541.6538, 137.5328, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[183], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[184] = CreateObject(19454, 387.2188, 4540.2197, 132.9518, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[184], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[185] = CreateObject(19454, 390.8057, 4532.0830, 137.5328, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[185], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[186] = CreateObject(19454, 387.5390, 4540.2197, 133.1716, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[186], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[187] = CreateObject(19454, 387.8593, 4540.2197, 133.3916, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[187], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[188] = CreateObject(19454, 388.1695, 4540.2197, 133.6115, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[188], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[189] = CreateObject(19454, 388.4897, 4540.2197, 133.8314, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[189], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[190] = CreateObject(19454, 388.8099, 4540.2197, 134.0513, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[190], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[191] = CreateObject(19454, 383.7071, 4540.2197, 130.5426, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[191], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[192] = CreateObject(19454, 383.8958, 4532.0161, 134.1131, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[192], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[193] = CreateObject(19454, 377.8118, 4518.3862, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[193], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[194] = CreateObject(19454, 377.7851, 4527.8945, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[194], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[195] = CreateObject(19454, 377.8684, 4508.8569, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[195], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[196] = CreateObject(2190, 367.9060, 4559.1293, 136.5907, 0.0000, 0.0000, 27.6999); //PC_1
	SetObjectMaterial(g_DelegaciaInt[196], 2, 10226, "sfeship1", "sf_shipcomp", 0xFFFFFFFF);
	g_DelegaciaInt[197] = CreateObject(19454, 381.2352, 4527.9160, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[197], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[198] = CreateObject(19454, 381.3019, 4518.4052, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[198], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[199] = CreateObject(19454, 381.3683, 4508.9013, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[199], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[200] = CreateObject(19454, 384.6199, 4527.1723, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[200], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[201] = CreateObject(19454, 387.8887, 4527.2377, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[201], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[202] = CreateObject(19454, 387.9494, 4518.5488, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[202], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[203] = CreateObject(19454, 388.0142, 4509.2924, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[203], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[204] = CreateObject(19454, 384.6814, 4518.4257, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[204], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[205] = CreateObject(19454, 384.7459, 4509.1982, 135.7434, 0.0000, 90.0000, 0.4000); //wall094
	SetObjectMaterial(g_DelegaciaInt[205], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[206] = CreateObject(19398, 376.1533, 4552.3447, 137.5062, 0.0000, 0.0000, 90.0000); //wall046
	SetObjectMaterial(g_DelegaciaInt[206], 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	g_DelegaciaInt[207] = CreateObject(19364, 379.2766, 4552.3276, 137.5015, 0.0000, 0.0000, 90.0000); //wall012
	SetObjectMaterial(g_DelegaciaInt[207], 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	g_DelegaciaInt[208] = CreateObject(19434, 381.6426, 4552.3530, 137.4981, 0.0000, 0.0000, 90.0000); //wall074
	SetObjectMaterial(g_DelegaciaInt[208], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[209] = CreateObject(19454, 382.3562, 4557.1015, 137.5128, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[209], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[210] = CreateObject(19364, 383.9962, 4552.3276, 137.5015, 0.0000, 0.0000, 90.0000); //wall012
	SetObjectMaterial(g_DelegaciaInt[210], 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	g_DelegaciaInt[211] = CreateObject(19398, 387.1433, 4552.3447, 137.5062, 0.0000, 0.0000, 90.0000); //wall046
	SetObjectMaterial(g_DelegaciaInt[211], 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	g_DelegaciaInt[212] = CreateObject(19454, 393.5455, 4552.3579, 137.5128, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[212], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[213] = CreateObject(19454, 382.3562, 4566.6665, 137.5128, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[213], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[214] = CreateObject(1491, 375.3668, 4552.3071, 135.7695, 0.0000, 0.0000, 0.0000); //Gen_doorINT01
	SetObjectMaterial(g_DelegaciaInt[214], 0, 10056, "bigoldbuild_sfe", "clubdoor1_256", 0xFFFFFFFF);
	g_DelegaciaInt[215] = CreateObject(1491, 386.3568, 4552.3071, 135.7695, 0.0000, 0.0000, 0.0000); //Gen_doorINT01
	SetObjectMaterial(g_DelegaciaInt[215], 0, 10056, "bigoldbuild_sfe", "clubdoor1_256", 0xFFFFFFFF);
	g_DelegaciaInt[216] = CreateObject(2174, 364.8431, 4565.2255, 135.7997, 0.0000, 0.0000, 0.0000); //MED_OFFICE4_DESK_2
	g_DelegaciaInt[217] = CreateObject(1671, 365.6956, 4564.2705, 136.2484, 0.0000, 0.0000, -170.2000); //swivelchair_A
	g_DelegaciaInt[218] = CreateObject(19893, 365.3416, 4565.2397, 136.5697, 0.0000, 0.0000, 17.8000); //LaptopSAMP1
	g_DelegaciaInt[219] = CreateObject(19805, 368.6812, 4565.6655, 137.6656, 0.0000, 0.0000, 180.0000); //Whiteboard1
	g_DelegaciaInt[220] = CreateObject(11706, 370.7724, 4565.1420, 135.8103, 0.0000, 0.0000, -32.1000); //SmallWasteBin1
	g_DelegaciaInt[221] = CreateObject(2183, 368.1005, 4557.6752, 135.8058, 0.0000, 0.0000, 90.0000); //MED_OFFICE3_DESK_09
	g_DelegaciaInt[222] = CreateObject(11729, 371.8071, 4565.4335, 135.6277, 0.0000, 0.0000, -2.3999); //GymLockerClosed1
	g_DelegaciaInt[223] = CreateObject(19454, 358.6663, 4533.6806, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[223], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[224] = CreateObject(14855, 353.3211, 4535.2001, 136.6588, 0.0000, 0.0000, 90.0000); //counterb
	g_DelegaciaInt[225] = CreateObject(19454, 358.6663, 4536.8623, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[225], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[226] = CreateObject(19454, 349.2169, 4536.8623, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[226], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[227] = CreateObject(19454, 347.3866, 4544.2700, 137.3831, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[227], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[228] = CreateObject(19454, 358.6365, 4538.5483, 137.5728, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[228], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[229] = CreateObject(19454, 349.1366, 4538.5483, 137.5728, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[229], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[230] = CreateObject(19454, 363.4270, 4533.7626, 137.5728, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[230], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[231] = CreateObject(2357, 381.6379, 4561.2099, 136.2174, 0.0000, 0.0000, 88.5999); //DUNC_DINNING
	SetObjectMaterial(g_DelegaciaInt[231], 0, 14584, "ab_abbatoir01", "cj_sheetmetal", 0xFFFFFFFF);
	g_DelegaciaInt[232] = CreateObject(19454, 349.2169, 4533.5517, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[232], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[233] = CreateObject(2357, 381.5046, 4555.7504, 136.2174, 0.0000, 0.0000, 88.5999); //DUNC_DINNING
	SetObjectMaterial(g_DelegaciaInt[233], 0, 14584, "ab_abbatoir01", "cj_sheetmetal", 0xFFFFFFFF);
	g_DelegaciaInt[234] = CreateObject(3533, 361.1528, 4536.8618, 134.0375, 0.0000, 0.0000, 0.0000); //trdpillar01
	SetObjectMaterial(g_DelegaciaInt[234], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[235] = CreateObject(11711, 347.4583, 4544.3276, 135.4165, 0.0000, 0.0000, 90.0000); //ExitSign1
	g_DelegaciaInt[236] = CreateObject(19454, 347.3866, 4535.0727, 137.3831, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[236], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[237] = CreateObject(19454, 367.8862, 4532.0161, 136.4236, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[237], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[238] = CreateObject(19454, 347.3866, 4544.2700, 137.6631, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[238], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[239] = CreateObject(19454, 351.9960, 4545.0600, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[239], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[240] = CreateObject(19454, 351.9960, 4541.6655, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[240], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[241] = CreateObject(19454, 351.9960, 4538.4926, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[241], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[242] = CreateObject(19454, 370.8958, 4562.0502, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[242], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[243] = CreateObject(19454, 347.3866, 4534.9472, 137.6631, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[243], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[244] = CreateObject(19454, 361.4861, 4541.6655, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[244], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[245] = CreateObject(19454, 361.4861, 4545.0014, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[245], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[246] = CreateObject(19454, 361.4861, 4538.3403, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[246], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[247] = CreateObject(19454, 361.4861, 4535.0131, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[247], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[248] = CreateObject(19454, 361.4861, 4531.8354, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[248], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[249] = CreateObject(19454, 361.4861, 4548.4404, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[249], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[250] = CreateObject(19454, 361.4861, 4551.8422, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[250], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[251] = CreateObject(19454, 361.4861, 4555.2685, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[251], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[252] = CreateObject(19454, 361.4861, 4558.6816, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[252], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[253] = CreateObject(19454, 370.8958, 4551.7963, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[253], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[254] = CreateObject(19454, 361.4861, 4562.0678, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[254], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[255] = CreateObject(19454, 361.4861, 4565.3671, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[255], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[256] = CreateObject(19454, 370.8958, 4545.0014, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[256], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[257] = CreateObject(19454, 370.8958, 4548.3916, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[257], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[258] = CreateObject(19454, 370.8958, 4555.2314, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[258], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[259] = CreateObject(19454, 370.8958, 4558.6352, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[259], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[260] = CreateObject(19454, 370.8958, 4565.3588, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[260], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[261] = CreateObject(19200, 381.8211, 4557.3344, 136.7291, -2.0000, -86.4999, 121.5000); //PoliceHelmet1
	g_DelegaciaInt[262] = CreateObject(19454, 380.1454, 4565.3588, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[262], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[263] = CreateObject(19454, 380.1454, 4562.0458, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[263], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[264] = CreateObject(18637, 381.7175, 4562.2524, 136.6334, 1.3999, -0.7000, -53.6998); //PoliceShield1
	g_DelegaciaInt[265] = CreateObject(19454, 380.1454, 4558.7875, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[265], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[266] = CreateObject(19454, 380.1454, 4555.3613, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[266], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[267] = CreateObject(19454, 380.1454, 4552.0122, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[267], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[268] = CreateObject(19454, 380.1454, 4548.6323, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[268], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[269] = CreateObject(19454, 380.1454, 4545.1972, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[269], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[270] = CreateObject(19454, 380.1454, 4541.8139, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[270], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[271] = CreateObject(19454, 380.1454, 4538.4492, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[271], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[272] = CreateObject(19454, 380.1454, 4535.0253, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[272], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[273] = CreateObject(19454, 380.1454, 4531.8076, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[273], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[274] = CreateObject(19454, 389.6251, 4531.8076, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[274], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[275] = CreateObject(19454, 389.6251, 4535.1962, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[275], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[276] = CreateObject(19454, 389.6251, 4538.5161, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[276], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[277] = CreateObject(19454, 389.6251, 4541.9169, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[277], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[278] = CreateObject(19454, 389.6251, 4545.2822, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[278], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[279] = CreateObject(19454, 389.6251, 4548.5698, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[279], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[280] = CreateObject(19515, 382.0772, 4562.8149, 136.9244, 7.6998, -87.6000, 88.8999); //SWATAgrey
	g_DelegaciaInt[281] = CreateObject(19454, 389.6251, 4551.8432, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[281], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[282] = CreateObject(19454, 389.6251, 4555.1918, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[282], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[283] = CreateObject(19454, 389.6251, 4558.5019, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[283], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[284] = CreateObject(19454, 389.6251, 4561.8666, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[284], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[285] = CreateObject(19454, 389.6251, 4565.1816, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[285], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[286] = CreateObject(18637, 382.2283, 4556.8212, 137.1849, 73.9000, -1.4999, -88.6999); //PoliceShield1
	g_DelegaciaInt[287] = CreateObject(19454, 370.6654, 4541.8139, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[287], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[288] = CreateObject(19454, 370.6654, 4538.5405, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[288], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[289] = CreateObject(19454, 370.6654, 4535.1948, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[289], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[290] = CreateObject(19454, 370.6654, 4530.9697, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[290], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[291] = CreateObject(19454, 377.2359, 4532.0161, 139.6036, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[291], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[292] = CreateObject(19454, 367.8862, 4532.0161, 139.6838, 0.0000, 0.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[292], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[293] = CreateObject(346, 381.7800, 4557.1855, 136.6520, 21.3000, 0.0000, 122.6999); //colt45
	g_DelegaciaInt[294] = CreateObject(19100, 381.6132, 4555.0478, 136.6996, -3.5999, -86.5000, 123.6999); //PoliceCap3
	g_DelegaciaInt[295] = CreateObject(356, 382.2387, 4562.3276, 137.9756, 178.1997, -145.6999, -87.6998); //m4
	g_DelegaciaInt[296] = CreateObject(2272, 350.7439, 4537.3032, 133.1212, 0.0000, -0.1999, 0.0000); //Frame_Fab_5
	SetObjectMaterial(g_DelegaciaInt[296], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	SetObjectMaterial(g_DelegaciaInt[296], 1, 10226, "sfeship1", "sf_shipcomp", 0xFFFFFFFF);
	g_DelegaciaInt[297] = CreateObject(2272, 350.7617, 4538.2949, 133.1088, 0.0000, -0.1999, 180.0000); //Frame_Fab_5
	SetObjectMaterial(g_DelegaciaInt[297], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	SetObjectMaterial(g_DelegaciaInt[297], 1, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	g_DelegaciaInt[298] = CreateObject(19808, 350.7640, 4537.4848, 133.1683, 0.0000, 0.0000, 7.8999); //Keyboard1
	g_DelegaciaInt[299] = CreateObject(19942, 381.7594, 4557.4677, 136.7127, -12.4000, -0.1000, -135.7001); //PoliceRadio1
	g_DelegaciaInt[300] = CreateObject(353, 382.2938, 4561.9233, 137.5408, 3.6999, 31.1999, 98.4999); //mp5lng
	g_DelegaciaInt[301] = CreateObject(349, 382.3148, 4561.0917, 137.4934, 0.0000, 31.8000, 97.3000); //chromegun
	g_DelegaciaInt[302] = CreateObject(352, 381.7043, 4561.3623, 136.6392, 85.1999, -0.7999, 135.2999); //micro_uzi
	g_DelegaciaInt[303] = CreateObject(352, 381.9561, 4561.1025, 136.6486, 85.1999, -0.7999, 135.2999); //micro_uzi
	g_DelegaciaInt[304] = CreateObject(351, 382.2337, 4560.8251, 138.1545, 3.1000, 37.2000, 95.0999); //shotgspa
	g_DelegaciaInt[305] = CreateObject(2161, 349.4723, 4532.1079, 132.1827, 0.0000, 0.0000, 180.0000); //MED_OFFICE_UNIT_4
	g_DelegaciaInt[306] = CreateObject(348, 381.4888, 4560.6879, 136.6226, 76.7999, 0.0000, 135.6999); //desert_eagle
	g_DelegaciaInt[307] = CreateObject(2163, 351.2348, 4532.1127, 132.1873, 0.0000, 0.0000, 180.0000); //MED_OFFICE_UNIT_2
	g_DelegaciaInt[308] = CreateObject(356, 381.7875, 4556.8217, 136.7073, -80.7000, 64.0999, -73.0999); //m4
	g_DelegaciaInt[309] = CreateObject(2163, 352.9851, 4532.1127, 132.1873, 0.0000, 0.0000, 180.0000); //MED_OFFICE_UNIT_2
	g_DelegaciaInt[310] = CreateObject(347, 382.1466, 4560.5996, 136.6227, 86.8000, 2.0999, 166.3999); //silenced
	g_DelegaciaInt[311] = CreateObject(2164, 354.7592, 4532.1093, 132.1880, 0.0000, 0.0000, 180.0000); //MED_OFFICE_UNIT_5
	g_DelegaciaInt[312] = CreateObject(2167, 347.5487, 4533.8315, 132.1960, 0.0000, 0.0000, 90.0000); //MED_OFFICE_UNIT_7
	g_DelegaciaInt[313] = CreateObject(2167, 347.5487, 4534.7363, 132.1960, 0.0000, 0.0000, 90.0000); //MED_OFFICE_UNIT_7
	g_DelegaciaInt[314] = CreateObject(11706, 348.0549, 4532.6552, 132.2200, 0.0000, 0.0000, -50.6000); //SmallWasteBin1
	g_DelegaciaInt[315] = CreateObject(2612, 356.6223, 4532.1420, 134.0341, 0.0000, 0.0000, 180.0000); //POLICE_NB2
	g_DelegaciaInt[316] = CreateObject(2615, 347.5734, 4536.1669, 134.1669, 0.0000, 0.0000, 90.0000); //POLICE_NB3
	g_DelegaciaInt[317] = CreateObject(346, 381.8736, 4560.0449, 136.6154, 85.7998, 33.1000, 103.7999); //colt45
	g_DelegaciaInt[318] = CreateObject(2007, 348.0327, 4536.1435, 132.2029, 0.0000, 0.0000, 90.0000); //filing_cab_nu01
	g_DelegaciaInt[319] = CreateObject(2043, 381.4452, 4559.4804, 136.7106, 0.0000, 0.0000, -127.3999); //AMMO_BOX_M4
	g_DelegaciaInt[320] = CreateObject(2894, 356.7919, 4537.0449, 133.1585, 0.0000, 0.0000, -43.6999); //kmb_rhymesbook
	g_DelegaciaInt[321] = CreateObject(346, 381.5346, 4560.2290, 136.6206, 85.7998, 33.1000, 113.4999); //colt45
	g_DelegaciaInt[322] = CreateObject(19893, 355.9442, 4537.3852, 133.1453, 0.0000, 0.0000, -26.1000); //LaptopSAMP1
	g_DelegaciaInt[323] = CreateObject(343, 382.1316, 4559.1254, 136.6777, 0.0000, 0.0000, 0.0000); //teargas
	g_DelegaciaInt[324] = CreateObject(343, 382.1316, 4559.3735, 136.6777, 0.0000, 0.0000, 0.0000); //teargas
	g_DelegaciaInt[325] = CreateObject(2717, 352.3391, 4532.1381, 134.0521, 0.0000, 0.0000, 180.0000); //CJ_DON_POSTER2
	SetObjectMaterialText(g_DelegaciaInt[325], "PERFECT", 0, 90, "Arial", 65, 1, 0xFFFFFFFF, 0x0, 0);
	g_DelegaciaInt[326] = CreateObject(358, 382.2787, 4559.9482, 138.2773, 11.6999, 42.2000, 88.1999); //sniper
	g_DelegaciaInt[327] = CreateObject(2717, 351.1188, 4532.1381, 134.0521, 0.0000, 0.0000, 180.0000); //CJ_DON_POSTER2
	SetObjectMaterialText(g_DelegaciaInt[327], "CITY", 0, 90, "Arial", 65, 1, 0xFF0E316D, 0x0, 0);
	g_DelegaciaInt[328] = CreateObject(2717, 351.3288, 4532.1381, 133.4022, 0.0000, 0.0000, 180.0000); //CJ_DON_POSTER2
	SetObjectMaterialText(g_DelegaciaInt[328], "DEPARTAMENTO", 0, 90, "Arial", 30, 1, 0xFFFFFFFF, 0x0, 0);
	g_DelegaciaInt[329] = CreateObject(2717, 350.3789, 4532.1381, 133.4022, 0.0000, 0.0000, 180.0000); //CJ_DON_POSTER2
	SetObjectMaterialText(g_DelegaciaInt[329], "POLICIAL", 0, 90, "Arial", 30, 1, 0xFFFFFFFF, 0x0, 0);
	g_DelegaciaInt[330] = CreateObject(19434, 359.8427, 4556.4848, 133.9682, 90.0000, 0.0000, 90.0000); //wall074
	SetObjectMaterial(g_DelegaciaInt[330], 0, 7978, "vgssairport", "airportwindow02_128", 0xFFFFFFFF);
	g_DelegaciaInt[331] = CreateObject(19434, 352.5227, 4556.4848, 133.9682, 90.0000, 0.0000, 90.0000); //wall074
	SetObjectMaterial(g_DelegaciaInt[331], 0, 7978, "vgssairport", "airportwindow02_128", 0xFFFFFFFF);
	g_DelegaciaInt[332] = CreateObject(334, 381.9979, 4560.1083, 136.8361, -1.0999, 28.3000, 30.4000); //nitestick
	g_DelegaciaInt[333] = CreateObject(19434, 390.8031, 4542.5278, 137.4683, 90.0000, 0.0000, 0.0000); //wall074
	SetObjectMaterial(g_DelegaciaInt[333], 0, 7978, "vgssairport", "airportwindow02_128", 0xFFFFFFFF);
	g_DelegaciaInt[334] = CreateObject(1536, 390.7850, 4537.5991, 135.7507, 0.0000, 0.0000, 90.0000); //Gen_doorEXT15
	g_DelegaciaInt[335] = CreateObject(342, 382.1635, 4559.7275, 136.7026, 0.0000, 0.0000, 0.0000); //grenade
	g_DelegaciaInt[336] = CreateObject(342, 382.1635, 4559.5488, 136.7026, 0.0000, 0.0000, 0.0000); //grenade
	g_DelegaciaInt[337] = CreateObject(335, 381.5344, 4562.7075, 136.6152, 87.7999, -12.9000, 142.2000); //knifecur
	g_DelegaciaInt[338] = CreateObject(19454, 358.6663, 4544.9062, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[338], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[339] = CreateObject(19454, 358.6663, 4541.4594, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[339], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[340] = CreateObject(11729, 374.4247, 4565.3188, 135.6277, 0.0000, 0.0000, -2.3999); //GymLockerClosed1
	g_DelegaciaInt[341] = CreateObject(19454, 358.6663, 4538.0371, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[341], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[342] = CreateObject(19454, 349.3068, 4538.0371, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[342], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[343] = CreateObject(19454, 349.3068, 4541.4204, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[343], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[344] = CreateObject(11729, 372.4666, 4565.4067, 135.6277, 0.0000, 0.0000, -2.3999); //GymLockerClosed1
	g_DelegaciaInt[345] = CreateObject(19454, 349.3068, 4544.7246, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[345], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[346] = CreateObject(11729, 373.1258, 4565.3769, 135.6277, 0.0000, 0.0000, -2.3999); //GymLockerClosed1
	g_DelegaciaInt[347] = CreateObject(19454, 349.3068, 4548.1098, 135.7331, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[347], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[348] = CreateObject(11729, 373.7454, 4565.3505, 135.6277, 0.0000, 0.0000, -2.3999); //GymLockerClosed1
	g_DelegaciaInt[349] = CreateObject(19454, 363.3959, 4542.0566, 137.5728, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[349], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[350] = CreateObject(19454, 363.3959, 4536.0908, 137.5728, 0.0000, 0.0000, 0.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[350], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[351] = CreateObject(19805, 377.4912, 4565.5175, 137.8455, 0.0000, 0.0000, 180.0000); //Whiteboard1
	g_DelegaciaInt[352] = CreateObject(11729, 375.0840, 4565.2885, 135.6277, 0.0000, 0.0000, -2.3999); //GymLockerClosed1
	g_DelegaciaInt[353] = CreateObject(2165, 371.9591, 4557.2382, 135.8191, 0.0000, 0.0000, 89.5999); //MED_OFFICE_DESK_1
	g_DelegaciaInt[354] = CreateObject(18014, 369.3279, 4532.4677, 132.5949, 0.0000, 0.0000, 90.0000); //int_rest_veg03
	g_DelegaciaInt[355] = CreateObject(19786, 369.4712, 4532.0332, 134.2242, 0.0000, 0.0000, 180.0000); //LCDTVBig1
	SetObjectMaterial(g_DelegaciaInt[355], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	SetObjectMaterial(g_DelegaciaInt[355], 1, 14802, "lee_bdupsflat", "USAflag", 0xFFFFFFFF);
	g_DelegaciaInt[356] = CreateObject(19141, 381.2302, 4557.2172, 136.6994, -8.9999, -91.5999, 146.2999); //SWATHelmet1
	g_DelegaciaInt[357] = CreateObject(1811, 372.8708, 4557.6977, 136.2991, 0.0000, 0.0000, 21.3999); //MED_DIN_CHAIR_5
	g_DelegaciaInt[358] = CreateObject(18608, 376.0866, 4563.1137, 140.4978, 0.0000, 0.0000, 0.0000); //countS_lights01
	g_DelegaciaInt[359] = CreateObject(19454, 370.6654, 4532.3051, 139.3626, 0.0000, 90.0000, 90.0000); //wall094
	SetObjectMaterial(g_DelegaciaInt[359], 0, 6284, "bev_law2", "studwalltop_law", 0xFFFFFFFF);
	g_DelegaciaInt[360] = CreateObject(2612, 371.5711, 4555.0512, 137.6751, 0.0000, 0.0000, 90.8999); //POLICE_NB2
	g_DelegaciaInt[361] = CreateObject(2164, 382.4564, 4564.0273, 135.7655, 0.0000, 0.0000, 90.0000); //MED_OFFICE_UNIT_5
	g_DelegaciaInt[362] = CreateObject(2174, 386.2568, 4564.9101, 135.9046, 0.0000, 0.0000, 0.0000); //MED_OFFICE4_DESK_2
	g_DelegaciaInt[363] = CreateObject(2183, 387.4703, 4557.3486, 135.8058, 0.0000, 0.0000, 90.0000); //MED_OFFICE3_DESK_09
	g_DelegaciaInt[364] = CreateObject(19893, 386.7416, 4564.7353, 136.7182, 0.0000, 0.0000, -17.5999); //LaptopSAMP1
	g_DelegaciaInt[365] = CreateObject(1811, 386.9435, 4564.2153, 136.3987, 0.0000, 0.0000, -95.0000); //MED_DIN_CHAIR_5
	g_DelegaciaInt[366] = CreateObject(1811, 385.3535, 4557.9907, 136.3987, 0.0000, 0.0000, -179.2999); //MED_DIN_CHAIR_5
	g_DelegaciaInt[367] = CreateObject(1811, 385.3336, 4559.6191, 136.3987, 0.0000, 0.0000, -179.2999); //MED_DIN_CHAIR_5
	g_DelegaciaInt[368] = CreateObject(1811, 388.3034, 4558.0278, 136.3987, 0.0000, 0.0000, 13.0000); //MED_DIN_CHAIR_5
	g_DelegaciaInt[369] = CreateObject(1811, 388.3103, 4559.4926, 136.3987, 0.0000, 0.0000, -11.6999); //MED_DIN_CHAIR_5
	g_DelegaciaInt[370] = CreateObject(18608, 356.3771, 4553.6630, 136.8583, 0.0000, 0.0000, 0.0000); //countS_lights01
	g_DelegaciaInt[371] = CreateObject(18608, 356.3771, 4533.9257, 136.8583, 0.0000, 0.0000, 0.0000); //countS_lights01
	g_DelegaciaInt[372] = CreateObject(11706, 382.8871, 4552.8237, 135.8509, -0.3000, -0.8999, 132.7999); //SmallWasteBin1
	g_DelegaciaInt[373] = CreateObject(18608, 386.8467, 4563.1137, 140.4978, 0.0000, 0.0000, 0.0000); //countS_lights01
	g_DelegaciaInt[374] = CreateObject(18608, 367.5968, 4563.1137, 140.4978, 0.0000, 0.0000, 0.0000); //countS_lights01
	g_DelegaciaInt[375] = CreateObject(18608, 376.2966, 4541.7558, 140.4978, 0.0000, 0.0000, 0.0000); //countS_lights01
	g_DelegaciaInt[376] = CreateObject(19786, 371.3587, 4563.1484, 137.7848, 0.0000, 0.0000, 90.0000); //LCDTVBig1
	SetObjectMaterial(g_DelegaciaInt[376], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	SetObjectMaterial(g_DelegaciaInt[376], 1, 18062, "ab_sfammuitems01", "ammu_gunboard2", 0xFFFFFFFF);
	g_DelegaciaInt[377] = CreateObject(19786, 371.3587, 4560.2011, 137.7848, 0.0000, 0.0000, 90.0000); //LCDTVBig1
	SetObjectMaterial(g_DelegaciaInt[377], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	SetObjectMaterial(g_DelegaciaInt[377], 1, 18062, "ab_sfammuitems01", "gun_guns3a", 0xFFFFFFFF);
	g_DelegaciaInt[378] = CreateObject(19893, 381.6081, 4554.2207, 136.6044, 0.0000, 0.0000, -81.2999); //LaptopSAMP1
	SetObjectMaterial(g_DelegaciaInt[378], 1, 10028, "copshop_sfe", "dt_cops_US_flag", 0xFFFFFFFF);
	g_DelegaciaInt[379] = CreateObject(19364, 372.9968, 4552.3276, 137.5015, 0.0000, 0.0000, 90.0000); //wall012
	SetObjectMaterial(g_DelegaciaInt[379], 0, 1649, "wglass", "carshowwin2", 0xFFFFFFFF);
	g_DelegaciaInt[380] = CreateObject(2190, 367.4071, 4558.7348, 136.5907, 0.0000, 0.0000, -61.0000); //PC_1
	SetObjectMaterial(g_DelegaciaInt[380], 2, 2047, "cj_ammo_posters", "cj_flag1", 0xFFFFFFFF);
	g_DelegaciaInt[381] = CreateObject(1811, 369.0782, 4559.7749, 136.3987, 0.0000, 0.0000, 19.3000); //MED_DIN_CHAIR_5
	g_DelegaciaInt[382] = CreateObject(1811, 368.9581, 4558.0869, 136.3987, 0.0000, 0.0000, -25.8999); //MED_DIN_CHAIR_5
	g_DelegaciaInt[383] = CreateObject(1811, 366.0534, 4558.2944, 136.3987, 0.0000, 0.0000, -174.4000); //MED_DIN_CHAIR_5
	g_DelegaciaInt[384] = CreateObject(1811, 365.9928, 4560.1513, 136.3987, 0.0000, 0.0000, 177.1999); //MED_DIN_CHAIR_5
	g_DelegaciaInt[385] = CreateObject(19808, 368.0297, 4558.1562, 136.6277, 0.0000, 0.0000, 72.2000); //Keyboard1
	g_DelegaciaInt[386] = CreateObject(19893, 367.0877, 4559.7568, 136.6088, 0.0000, 0.0000, -111.5999); //LaptopSAMP1
	SetObjectMaterial(g_DelegaciaInt[386], 1, 10226, "sfeship1", "sf_ship_generic28", 0xFFFFFFFF);
	g_DelegaciaInt[387] = CreateObject(19893, 367.7997, 4560.5507, 136.6088, 0.0000, 0.0000, 58.9999); //LaptopSAMP1
	SetObjectMaterial(g_DelegaciaInt[387], 1, 1444, "break_s_sf", "CJ_FERRY_MAP", 0xFFFFFFFF);
	g_DelegaciaInt[388] = CreateObject(19808, 366.7841, 4558.4516, 136.6277, 0.0000, 0.0000, -61.0999); //Keyboard1
	g_DelegaciaInt[389] = CreateObject(2007, 363.9652, 4554.2065, 135.8143, 0.0000, 0.0000, 90.0000); //filing_cab_nu01
	g_DelegaciaInt[390] = CreateObject(19786, 363.4018, 4559.1020, 137.9894, 0.0000, 0.0000, 90.0000); //LCDTVBig1
	SetObjectMaterial(g_DelegaciaInt[390], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	SetObjectMaterial(g_DelegaciaInt[390], 1, 16644, "a51_detailstuff", "a51_map", 0xFFFFFFFF);
	g_DelegaciaInt[391] = CreateObject(2007, 363.9652, 4555.1909, 135.8143, 0.0000, 0.0000, 90.0000); //filing_cab_nu01
	g_DelegaciaInt[392] = CreateObject(2007, 363.9652, 4556.1777, 135.8143, 0.0000, 0.0000, 90.0000); //filing_cab_nu01
	g_DelegaciaInt[393] = CreateObject(19786, 390.7922, 4558.8437, 137.9043, 0.0000, 0.0000, -90.0000); //LCDTVBig1
	SetObjectMaterial(g_DelegaciaInt[393], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	SetObjectMaterial(g_DelegaciaInt[393], 1, 10838, "airwelcomesign_sfse", "ws_airwelcome1", 0xFFFFFFFF);
	g_DelegaciaInt[394] = CreateObject(19165, 371.2594, 4562.6821, 137.8080, 0.0000, 90.0000, 180.0000); //GTASAMap2
	SetObjectMaterial(g_DelegaciaInt[394], 1, 14530, "estate2", "ab_SFmap", 0xFFFFFFFF);
	g_DelegaciaInt[395] = CreateObject(19786, 371.3515, 4555.1708, 137.9494, 0.0000, 0.0000, -90.0000); //LCDTVBig1
	SetObjectMaterial(g_DelegaciaInt[395], 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
	SetObjectMaterial(g_DelegaciaInt[395], 1, 7009, "vgndwntwn1", "newpolice_sa", 0xFFFFFFFF);
	g_DelegaciaInt[396] = CreateObject(2717, 382.4761, 4555.1015, 137.7733, 0.0000, 0.0000, 90.0000); //CJ_DON_POSTER2
	SetObjectMaterial(g_DelegaciaInt[396], 0, 2047, "cj_ammo_posters", "CJ_Coltposter", 0xFFFFFFFF);
	g_DelegaciaInt[397] = CreateObject(19894, 386.4183, 4557.9799, 136.6135, 0.0000, 0.0000, -60.7000); //LaptopSAMP2
	g_DelegaciaInt[398] = CreateObject(2717, 382.4761, 4562.0083, 137.7733, 0.0000, 0.0000, 90.0000); //CJ_DON_POSTER2
	SetObjectMaterial(g_DelegaciaInt[398], 0, 14842, "genintintpolicea", "cop_notice", 0xFFFFFFFF);
	g_DelegaciaInt[399] = CreateObject(19894, 387.3513, 4558.5024, 136.6135, 0.0000, 0.0000, 47.4999); //LaptopSAMP2
	g_DelegaciaInt[400] = CreateObject(19893, 387.2632, 4559.9257, 136.6044, 0.0000, 0.0000, 76.5000); //LaptopSAMP1
	SetObjectMaterial(g_DelegaciaInt[400], 1, 18063, "ab_sfammuitems02", "gun_xtra1", 0xFFFFFFFF);
	g_DelegaciaInt[401] = CreateObject(19894, 386.2706, 4560.3925, 136.6135, 0.0000, 0.0000, -47.0000); //LaptopSAMP2
	g_DelegaciaInt[402] = CreateObject(18014, 384.5480, 4540.6489, 132.5949, 0.0000, 0.0000, 90.0000); //int_rest_veg03
	g_DelegaciaInt[403] = CreateObject(18014, 384.5480, 4535.9140, 132.5949, 0.0000, 0.0000, 90.0000); //int_rest_veg03
	g_DelegaciaInt[404] = CreateObject(2615, 384.6071, 4540.3505, 134.0562, 0.0000, 0.0000, 180.0000); //POLICE_NB3
	g_DelegaciaInt[405] = CreateObject(1569, 388.6427, 4542.9321, 132.1935, 0.0000, 0.0000, 90.0000); //ADAM_V_DOOR
	g_DelegaciaInt[406] = CreateObject(2002, 388.0794, 4545.5419, 132.2286, 0.0000, 0.0000, -90.0000); //water_coolnu
	g_DelegaciaInt[407] = CreateObject(11713, 388.6044, 4541.5654, 133.6564, 0.0000, 0.0000, 180.0000); //FireExtPanel1
	g_DelegaciaInt[408] = CreateObject(2008, 377.7195, 4514.4931, 132.2067, 0.0000, 0.0000, -90.0000); //officedesk1
	g_DelegaciaInt[409] = CreateObject(1671, 376.7434, 4513.8896, 132.6773, 0.0000, 0.0000, 106.0000); //swivelchair_A
	g_DelegaciaInt[410] = CreateObject(1886, 376.7625, 4513.6474, 135.7722, 21.9999, 0.0000, 136.6999); //shop_sec_cam
	g_DelegaciaInt[411] = CreateObject(1886, 390.0035, 4551.7055, 139.4935, 10.8000, 0.0000, -49.1000); //shop_sec_cam
	g_DelegaciaInt[412] = CreateObject(1886, 348.1534, 4532.6372, 135.7769, 25.5000, 0.0000, 144.1999); //shop_sec_cam

	return 1;
}