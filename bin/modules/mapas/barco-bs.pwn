#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	CreateDynamicObject(10230, -2195.73706, 2457.47998, 7.04280,   0.00000, 0.00000, 139.69603, .worldid=0, .interiorid=0, .streamdistance=100.0);
	CreateDynamicObject(10231, -2194.02539, 2457.95508, 8.34390,   0.00000, 0.00000, 139.74190, .worldid=0, .interiorid=0, .streamdistance=100.0);
	CreateDynamicObject(10229, -2194.66650, 2458.38647, 5.77210,   0.02000, 0.10000, 139.58875, .worldid=0, .interiorid=0, .streamdistance=100.0);
	return 1;
}