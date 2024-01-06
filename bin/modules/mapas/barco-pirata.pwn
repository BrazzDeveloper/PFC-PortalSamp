#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	new g_BarcoPirata[6];
	g_BarcoPirata[0] = CreateDynamicObject(8493, -1854.2762, -3515.3596, 17.8566, 10.7999, 0.0000, 43.2999); //pirtshp01_lvs
	g_BarcoPirata[1] = CreateDynamicObject(18228, -1859.4527, -3533.8706, -17.2924, 10.7999, 0.0000, 0.0000); //cunt_rockgp2_21
	g_BarcoPirata[2] = CreateDynamicObject(18228, -1864.6728, -3503.6997, -13.0916, 0.0000, 0.0000, 0.0000); //cunt_rockgp2_21
	g_BarcoPirata[3] = CreateDynamicObject(9159, -1854.3624, -3515.3242, 17.6482, 10.7999, 0.0000, 43.2999); //pirtshp02_lvs
	g_BarcoPirata[4] = CreateDynamicObject(2332, -1844.2257, -3526.6398, 2.6783, -10.4999, 0.0000, -139.2000); //KEV_SAFE
	g_BarcoPirata[5] = CreateDynamicObject(18228, -1862.9730, -3517.6179, -11.9516, 10.7999, 0.0000, 0.0000); //cunt_rockgp2_21

	return 1;
}