#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	new g_Sedex[30];
	g_Sedex[0] = CreateDynamicObject(970, 1772.2811, -1907.1529, 13.1084, 0.0000, 0.0000, 0.0000); //fencesmallb
	g_Sedex[1] = CreateDynamicObject(970, 1770.1905, -1907.1529, 13.1084, 0.0000, 0.0000, 0.0000); //fencesmallb
	g_Sedex[2] = CreateDynamicObject(970, 1774.3415, -1905.0820, 13.1084, 0.0000, 0.0000, 90.0000); //fencesmallb
	g_Sedex[3] = CreateDynamicObject(970, 1774.3415, -1900.9604, 13.1084, 0.0000, 0.0000, 90.0000); //fencesmallb
	g_Sedex[4] = CreateDynamicObject(970, 1774.3415, -1885.7585, 13.1084, 0.0000, 0.0000, 90.0000); //fencesmallb
	g_Sedex[5] = CreateDynamicObject(970, 1774.3415, -1889.8791, 13.1084, 0.0000, 0.0000, 90.0000); //fencesmallb
	g_Sedex[6] = CreateDynamicObject(970, 1774.3415, -1891.9720, 13.1084, 0.0000, 0.0000, 90.0000); //fencesmallb
	g_Sedex[7] = CreateDynamicObject(970, 1774.3415, -1898.8725, 13.1084, 0.0000, 0.0000, 90.0000); //fencesmallb
	g_Sedex[8] = CreateDynamicObject(970, 1779.3011, -1942.3458, 13.0784, 0.0000, 0.0000, 0.0000); //fencesmallb
	g_Sedex[9] = CreateDynamicObject(970, 1775.1800, -1942.3458, 13.0784, 0.0000, 0.0000, 0.0000); //fencesmallb
	g_Sedex[10] = CreateDynamicObject(970, 1771.0417, -1942.3458, 13.0784, 0.0000, 0.0000, 0.0000); //fencesmallb
	g_Sedex[11] = CreateDynamicObject(970, 1766.9023, -1942.3458, 13.0784, 0.0000, 0.0000, 0.0000); //fencesmallb
	g_Sedex[12] = CreateDynamicObject(970, 1762.7624, -1942.3458, 13.0784, 0.0000, 0.0000, 0.0000); //fencesmallb
	g_Sedex[13] = CreateDynamicObject(970, 1758.6422, -1942.3458, 13.0784, 0.0000, 0.0000, 0.0000); //fencesmallb
	g_Sedex[14] = CreateDynamicObject(11714, 1759.6080, -1938.9696, 13.7312, 0.0000, 0.0000, 0.0000); //MaintenanceDoors1
	g_Sedex[15] = CreateDynamicObject(11711, 1759.7010, -1938.9792, 15.2635, 0.0000, 0.0000, 90.0000); //ExitSign1
	g_Sedex[16] = CreateDynamicObject(4642, 1809.2021, -1898.9455, 14.2801, 0.0000, 0.0000, 179.3000); //paypark_lan
	g_Sedex[17] = CreateDynamicObject(2668, 1764.6512, -1902.3416, 13.8360, 0.0000, 0.0000, -58.9000); //CJ_PIZ_POSTER3
	SetObjectMaterialText(g_Sedex[17], "SEDEX", 0, 90, "Arial", 90, 1, 0xFFD78E10, 0x0, 0);
	g_Sedex[18] = CreateDynamicObject(19355, 1764.6026, -1902.3785, 14.0693, 0.0000, 0.0000, 31.1000); //wall003
	SetObjectMaterial(g_Sedex[18], 0, 3850, "carshowglass_sfsx", "ws_glass_balustrade_better", 0xFFFFFFFF);
	g_Sedex[19] = CreateDynamicObject(2668, 1764.5329, -1902.1450, 14.4560, 0.0000, 0.0000, -58.9000); //CJ_PIZ_POSTER3
	SetObjectMaterialText(g_Sedex[19], "PFC", 0, 90, "Arial", 90, 1, 0xFF1E4C99, 0x0, 0);
	g_Sedex[20] = CreateDynamicObject(948, 1763.6679, -1900.7673, 12.6551, 0.0000, 0.0000, 31.1000); //Plant_Pot_10
	g_Sedex[21] = CreateDynamicObject(948, 1765.6005, -1903.9687, 12.6551, 0.0000, 0.0000, 31.1000); //Plant_Pot_10
	g_Sedex[22] = CreateDynamicObject(638, 1764.9874, -1902.1599, 13.1455, 0.0000, 0.0000, 31.1000); //kb_planter+bush
	g_Sedex[23] = CreateDynamicObject(966, 1810.3829, -1886.0361, 12.3560, 0.0000, 0.0000, 90.0000); //bar_gatebar01
	g_Sedex[24] = CreateDynamicObject(970, 1810.2136, -1883.7216, 13.0826, 0.0000, 0.0000, 90.0000); //fencesmallb
	g_Sedex[25] = CreateDynamicObject(968, 1810.3756, -1885.9212, 13.2066, -0.0000, -90.1001, 89.8000); //barrierturn
	g_Sedex[26] = CreateDynamicObject(970, 1810.2136, -1883.7216, 12.2026, 180.0000, 0.0000, 90.0000); //fencesmallb
	g_Sedex[27] = CreateDynamicObject(970, 1810.2136, -1895.2324, 13.0826, 0.0000, 0.0000, 90.0000); //fencesmallb
	g_Sedex[28] = CreateDynamicObject(970, 1810.2136, -1895.2324, 12.1926, 180.0000, 0.0000, 90.0000); //fencesmallb
	g_Sedex[29] = CreateDynamicObject(970, 1810.2136, -1897.3239, 13.0826, 0.0000, 0.0000, 90.0000); //fencesmallb

	return 1;
}