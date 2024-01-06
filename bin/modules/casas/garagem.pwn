#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	CreateObject(19447, -1079.19092, 1018.63757, 1484.42041,   0.00000, 0.00000, 179.00000);
	CreateObject(19447, -1079.02783, 1028.23584, 1484.42041,   0.00000, 0.00000, 179.00000);
	CreateObject(19447, -1074.54114, 1013.71179, 1484.42041,   0.00000, 0.00000, 89.82000);
	CreateObject(19447, -1069.71985, 1018.58020, 1484.42041,   0.00000, 0.00000, 179.00000);
	CreateObject(19447, -1069.55261, 1028.18787, 1484.42041,   0.00000, 0.00000, 179.00000);
	CreateObject(19447, -1074.21326, 1030.04761, 1484.42041,   0.00000, 0.00000, 269.76001);
	CreateObject(19377, -1074.41504, 1019.03699, 1486.15771,   0.00000, 90.00000, 90.00000);
	CreateObject(19377, -1074.25964, 1029.48474, 1486.15771,   0.00000, 89.90000, 90.18000);
	CreateObject(19861, -1073.86108, 1029.97375, 1485.20483,   0.00000, 0.00000, -0.24000);
	CreateObject(3633, -1077.14539, 1014.69446, 1483.17627,   0.00000, 0.00000, 0.00000);
	CreateObject(2002, -1070.16235, 1026.61743, 1482.69336,   0.00000, 0.00000, -89.64011);
	CreateObject(1728, -1078.71362, 1018.31909, 1482.68750,   0.00000, 0.00000, 88.38013);
	CreateObject(1778, -1070.33008, 1016.68195, 1482.81189,   0.00000, 0.00000, 75.84001);
	CreateObject(10282, -1073.62354, 1019.03552, 1483.64307,   0.00000, 0.00000, -180.25980);
	CreateObject(3633, -1077.80847, 1015.91736, 1483.17627,   0.00000, 0.00000, 0.00000);
	CreateObject(19377, -1074.41504, 1019.09698, 1482.61194,   0.00000, 90.00000, 90.00000);
	CreateObject(19377, -1074.25964, 1029.58484, 1482.61194,   0.00000, 89.90000, 90.18000);
	CreateObject(1893, -1075.37024, 1023.34241, 1486.04663,   0.00000, 0.00000, 0.00000);
	CreateObject(1893, -1075.37024, 1017.56879, 1486.04663,   0.00000, 0.00000, 0.00000);
	CreateObject(3633, -1078.11743, 1022.35321, 1483.17627,   0.00000, 0.00000, 0.00000);
	
	return Y_HOOKS_CONTINUE_RETURN_1;
}

stock RenderGaragem(casaid)
{
	new str_[255];
	format(str_, sizeof(str_), "Garagem\nUse '{"COR_VERDE_CLARO_INC"}/Entrar{ffffff}'", casaid, Casa[casaid][Owner][Name]);

	Casa[casaid][Garagem][Pickup] = CreateDynamicPickup(19627, 23, Casa[casaid][Garagem][pEntrada][X], Casa[casaid][Garagem][pEntrada][Y], Casa[casaid][Garagem][pEntrada][Z], 0, 0, -1, HOUSE_RENDER_STREAMER);
	
	if ( IsValidDynamic3DTextLabel(Casa[casaid][Garagem][Label]) )
		DestroyDynamic3DTextLabel(Casa[casaid][Garagem][Label]);

	Casa[casaid][Garagem][Label] = CreateDynamic3DTextLabel(str_, COR_BRANCO, Casa[casaid][Garagem][pEntrada][X], Casa[casaid][Garagem][pEntrada][Y], Casa[casaid][Garagem][pEntrada][Z], 20.0, .streamdistance=20.0, .interiorid=0, .worldid=0, .testlos=1);
	return 1;
}

stock DestroyGaragem(casaid)
{
	DestroyDynamic3DTextLabel(Casa[casaid][Garagem][Label]);
	DestroyPickup(Casa[casaid][Garagem][Pickup]);
	new reset[e_GARAGEM];
	Casa[casaid][Garagem] = reset;
}