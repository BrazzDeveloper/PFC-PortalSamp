// NEW SYSTEM: PEDÁGIO

/* ----         Started at 18/05/2021 - 14:16                                                     */
/* ----         Author: Luiz "LuizM" Henrique                                                     */
/* ----         Credits: Morgana (map design)                                                     */
/* ----         Finished at 08/05/2021 - 23:40                                                    */
/* ----         First patch: 08/05/2021 - 23:41 - 427 lines                                       */

#include <YSI_Coding\y_hooks>

 #define Iterator@Text3D:       ITER_TAG(Text3D) 

enum CPedagio
{
    Objeto,
    Valor,
    Float:X,
    Float:Y,
    Float:Z,
    Float:CancelaX,
    Float:CancelaY,
    Float:CancelaZ,
    Float:RX,
    Float:RY,
    Float:RZ,
    Float:AbertoX,
    Float:AbertoY,
    Float:AbertoZ,
    Float:AbertoRotX,
    Float:AbertoRotY,
    Float:AbertoRotZ,
    bool:PosicionandoLabel,
    bool:PosicionandoAbertura
}
static CreatingPedagio[MAX_PLAYERS][CPedagio];



function ALLPEDAGIOS::ResetVariables(id)
{
    cPedagio[id][CancelaID] = INVALID_OBJECT_ID;
    cPedagio[id][Valor] = 0;
    cPedagio[id][X] = 0;
    cPedagio[id][Y] = 0;
    cPedagio[id][Z] = 0;
    cPedagio[id][CancelaX] = 0;
    cPedagio[id][CancelaY] = 0;
    cPedagio[id][CancelaZ] = 0;
    cPedagio[id][RotX] = 0;
    cPedagio[id][RotY] = 0;
    cPedagio[id][RotZ] = 0;
    cPedagio[id][AbertoX] = 0;
    cPedagio[id][AbertoY] = 0;
    cPedagio[id][AbertoZ] = 0;
    cPedagio[id][AbertoRotX] = 0;
    cPedagio[id][AbertoRotY] = 0;
    cPedagio[id][AbertoRotZ] = 0;
    return 1;
}

function PEDAGIO::ReloadPedagios()
{
    for(new i; i < MAX_PEDAGIOS; i++)
    {
        DestroyDynamic3DTextLabel(cPedagio[i][LabelID]);
        DestroyDynamicObject(cPedagio[i][CancelaID]);

        call::ALLPEDAGIOS->ResetVariables(i);
    }

    new Cache:result = mysql_query(getConexao(), "SELECT * FROM `pedagios`", true), rows = cache_num_rows();
    if(rows)
    {
        for(new i; i < rows; i++)
        {
            Iter_Add(Pedagio, i);

            cache_get_value_int(i, "id", cPedagio[i][ID]);
            cache_get_value_int(i, "valor", cPedagio[i][Valor]);
            cache_get_value_float(i, "labelX", cPedagio[i][X]);
            cache_get_value_float(i, "labelY", cPedagio[i][Y]);
            cache_get_value_float(i, "labelZ", cPedagio[i][Z]);
            cache_get_value_float(i, "posX", cPedagio[i][CancelaX]);
            cache_get_value_float(i, "posY", cPedagio[i][CancelaY]);
            cache_get_value_float(i, "posZ", cPedagio[i][CancelaZ]);
            cache_get_value_float(i, "rotX", cPedagio[i][RotX]);
            cache_get_value_float(i, "rotY", cPedagio[i][RotY]);
            cache_get_value_float(i, "rotZ", cPedagio[i][RotZ]);
            cache_get_value_float(i, "abertoX", cPedagio[i][AbertoX]);
            cache_get_value_float(i, "abertoY", cPedagio[i][AbertoY]);
            cache_get_value_float(i, "abertoZ", cPedagio[i][AbertoZ]);
            cache_get_value_float(i, "abertoRotX", cPedagio[i][AbertoRotX]);
            cache_get_value_float(i, "abertoRotY", cPedagio[i][AbertoRotY]);
            cache_get_value_float(i, "abertoRotZ", cPedagio[i][AbertoRotZ]);

            printf("%d: %f, %f, %f", cPedagio[i][ID], cPedagio[i][AbertoRotX], cPedagio[i][AbertoRotY], cPedagio[i][AbertoRotX]);

            new String[700];
            format(String, 700, "{ffff00}Pedágio\n{ffffff}Valor: {31b404}R$%d\n{ffffff}Aperte '{ffff00}H{ffffff}' para abrir a cancela.", cPedagio[i][Valor]);

            cPedagio[i][CancelaID] = CreateDynamicObject(968, cPedagio[i][CancelaX], cPedagio[i][CancelaY], cPedagio[i][CancelaZ], cPedagio[i][RotX], cPedagio[i][RotY], cPedagio[i][RotZ]);
            cPedagio[i][LabelID] = CreateDynamic3DTextLabel(String, -1, cPedagio[i][X], cPedagio[i][Y], cPedagio[i][Z], 20.0);
        }
    }

    cache_delete(result);
    return 1;
}

function PEDAGIOS::CreateMap()
{
    // PEDÁGIO TÚNEL BS 1
    CreateDynamicObject(9623, -2258.34106, 2677.47949, 56.71260,   -1.20000, 0.44000, -88.00000);
    CreateDynamicObject(966, -2263.72388, 2685.79199, 54.40640,   0.02000, 0.00000, 91.08010);
    CreateDynamicObject(966, -2263.14087, 2669.83130, 54.40640,   0.00000, 0.00000, -87.53983);
    CreateDynamicObject(3785, -2257.97070, 2673.40088, 58.80650,   0.00000, 89.00000, 0.00000);
    CreateDynamicObject(3785, -2257.18237, 2682.17603, 58.80650,   0.00000, 89.00000, 0.00000);
    CreateDynamicObject(970, -2256.45972, 2669.77783, 54.98890,   0.00000, 1.20000, 1.20000);
    CreateDynamicObject(970, -2264.42090, 2676.86353, 54.82566,   0.00000, 0.00000, 2.52000);
    CreateDynamicObject(970, -2264.42090, 2678.66357, 54.82570,   0.00000, 0.00000, 2.52000);
    CreateDynamicObject(970, -2261.14404, 2685.44458, 55.14433,   0.00000, 1.20000, 1.92000);
    CreateDynamicObject(970, -2257.07788, 2685.56250, 55.07979,   0.00000, 1.44000, 1.68000);
    CreateDynamicObject(970, -2252.41138, 2679.17871, 54.59870,   0.00000, 1.22000, 3.12000);
    CreateDynamicObject(970, -2252.31909, 2677.25806, 54.59870,   0.00000, 1.00000, 1.42000);
    CreateDynamicObject(970, -2260.61084, 2669.67163, 55.10760,   0.00000, 1.20000, 1.20000);
    CreateDynamicObject(1237, -2247.23804, 2678.26733, 53.86590,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2245.61084, 2678.37500, 53.74756,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2244.23877, 2678.42651, 53.66862,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(626, -2252.48877, 2678.04907, 56.07890,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(627, -2264.20898, 2677.73584, 56.06337,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19988, -2232.98926, 2686.01001, 53.58829,   0.00000, 0.00000, 92.52009);
    CreateDynamicObject(19988, -2231.69458, 2670.67383, 53.64788,   0.00000, 0.00000, 92.52009);
    CreateDynamicObject(1238, -2242.45508, 2678.34106, 54.02482,   0.00000, 0.00000, 0.24000);
    CreateDynamicObject(19291, -2253.94336, 2682.20215, 58.96325,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, -2253.61670, 2672.83081, 58.91576,   0.00000, 0.00000, 0.00000);

    // PEDÁGIO TÚNEL BS 2
    CreateDynamicObject(9623, -2054.29541, 2600.97485, 56.75290,   0.00000, 0.00000, 64.68010);
    CreateDynamicObject(966, -2053.28491, 2591.19995, 54.21560,   0.00000, 0.00000, -115.08000);
    CreateDynamicObject(966, -2046.58252, 2605.60205, 54.21560,   0.00000, 0.00000, -295.71921);
    CreateDynamicObject(970, -2049.48145, 2597.11499, 54.79193,   0.00000, 0.00000, -26.46002);
    CreateDynamicObject(970, -2048.73291, 2598.83936, 54.79190,   0.00000, 0.00000, -24.96000);
    CreateDynamicObject(970, -2060.40454, 2602.24829, 54.88834,   0.00000, 0.00000, -23.69999);
    CreateDynamicObject(970, -2059.65259, 2604.01904, 54.88834,   0.00000, 0.00000, -26.09997);
    CreateDynamicObject(970, -2048.58911, 2606.81470, 54.97446,   0.00000, 0.00000, -25.92000);
    CreateDynamicObject(970, -2052.30493, 2608.61597, 54.97446,   0.00000, 0.00000, -25.92000);
    CreateDynamicObject(970, -2055.28467, 2592.60132, 54.97746,   0.00000, 0.00000, -25.20001);
    CreateDynamicObject(970, -2059.02100, 2594.33716, 54.97746,   0.00000, 0.00000, -25.20001);
    CreateDynamicObject(3785, -2053.37134, 2604.77515, 58.92590,   1.00000, 88.00000, 146.00000);
    CreateDynamicObject(3785, -2057.65063, 2597.43237, 58.92590,   1.00000, 88.00000, 156.00000);
    CreateDynamicObject(628, -2059.69629, 2602.80469, 56.15924,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(626, -2049.12988, 2598.03491, 56.21460,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2064.83862, 2605.38086, 54.19928,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2066.58374, 2606.19580, 54.12196,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2068.12305, 2606.85278, 54.12196,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19988, -2071.80713, 2616.99219, 54.65516,   0.00000, 0.00000, -96.95995);
    CreateDynamicObject(19988, -2077.34106, 2601.55444, 54.65516,   0.00000, 0.00000, -116.81992);
    CreateDynamicObject(1238, -2070.03564, 2607.57642, 54.59171,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, -2060.37378, 2598.68042, 59.10342,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, -2056.44751, 2606.97729, 59.05951,   0.00000, 0.00000, 0.00000);

    // PEDÁGIO PONTE SF-BS
    CreateDynamicObject(966, -2691.37207, 1269.49988, 54.39056,   0.00000, 0.00000, 359.69739);
    CreateDynamicObject(966, -2689.65186, 1269.62952, 54.47926,   0.00000, 0.00000, 178.32004);
    CreateDynamicObject(966, -2671.45923, 1279.77686, 54.53575,   0.00000, 0.00000, 178.32001);
    CreateDynamicObject(966, -2673.69775, 1279.86670, 54.39098,   0.00000, 0.00000, -0.17988);
    CreateDynamicObject(970, -2664.08667, 1285.69043, 55.29066,   0.00000, 0.00000, 89.28001);
    CreateDynamicObject(970, -2664.13306, 1281.64734, 55.29066,   0.00000, 0.00000, 89.28001);
    CreateDynamicObject(970, -2664.17432, 1277.53625, 55.29066,   0.00000, 0.00000, 89.46001);
    CreateDynamicObject(970, -2664.19971, 1273.44250, 55.29066,   0.00000, 0.00000, 89.46001);
    CreateDynamicObject(970, -2664.18286, 1269.33105, 55.29066,   0.00000, 0.00000, 90.77998);
    CreateDynamicObject(970, -2698.85962, 1267.16772, 55.29842,   0.00000, 0.00000, -89.94009);
    CreateDynamicObject(970, -2698.84424, 1271.26489, 55.29842,   0.00000, 0.00000, -89.94009);
    CreateDynamicObject(970, -2698.83228, 1275.38879, 55.29842,   0.00000, 0.00000, -89.94009);
    CreateDynamicObject(970, -2698.85718, 1279.50793, 55.29842,   0.00000, 0.00000, -89.94009);
    CreateDynamicObject(970, -2698.82886, 1283.63049, 55.29842,   0.00000, 0.00000, -89.94009);
    CreateDynamicObject(970, -2673.65063, 1282.30347, 55.12373,   0.00000, 0.00000, -89.94019);
    CreateDynamicObject(970, -2671.20605, 1282.22192, 55.12373,   0.00000, 0.00000, -89.94019);
    CreateDynamicObject(970, -2680.58203, 1282.21069, 55.12373,   0.00000, 0.00000, -89.94019);
    CreateDynamicObject(970, -2683.09082, 1280.49402, 55.12373,   0.00000, 0.00000, -89.94019);
    CreateDynamicObject(970, -2689.34033, 1280.41211, 55.12373,   0.00000, 0.00000, -89.94019);
    CreateDynamicObject(970, -2691.68750, 1280.66675, 55.12373,   0.00000, 0.00000, -89.94019);
    CreateDynamicObject(970, -2691.71851, 1267.05103, 55.29842,   0.00000, 0.00000, -89.94009);
    CreateDynamicObject(970, -2689.29126, 1267.24426, 55.14872,   0.00000, 0.00000, -89.94009);
    CreateDynamicObject(970, -2683.12476, 1267.28784, 55.14872,   0.00000, 0.00000, -89.94009);
    CreateDynamicObject(970, -2680.64624, 1268.87097, 55.14872,   0.00000, 0.00000, -89.94009);
    CreateDynamicObject(970, -2673.67529, 1268.51611, 55.14872,   0.00000, 0.00000, -89.94009);
    CreateDynamicObject(970, -2671.07202, 1268.61243, 55.14872,   0.00000, 0.00000, -89.94009);
    CreateDynamicObject(1237, -2663.69458, 1266.41418, 54.80332,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2663.64819, 1288.72058, 54.80703,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2699.24414, 1286.67859, 54.80585,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2699.18774, 1264.32483, 54.80622,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, -2686.16064, 1279.12402, 59.75233,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, -2695.36206, 1279.12244, 59.77109,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, -2677.58252, 1270.10815, 59.72036,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, -2667.38721, 1270.10815, 59.73841,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -2695.56689, 1270.10645, 59.74109,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -2686.02710, 1270.10742, 59.72142,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -2676.86987, 1279.12170, 59.74426,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -2267.88647, -8732.55273, -1494.60156,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -2666.78955, 1279.12354, 59.71540,   0.00000, 0.00000, 0.00000);

    // PEDÁGIO SF-TR
    CreateDynamicObject(9623, -1653.57104, 558.40521, 40.59340,   2.00000, 0.00000, -43.04000);
    CreateDynamicObject(966, -1663.39514, 560.06091, 37.74685,   0.00000, 0.00000, -223.92001);
    CreateDynamicObject(966, -1644.04602, 556.82367, 38.15338,   0.00000, 0.00000, -43.79999);
    CreateDynamicObject(3785, -1656.86108, 561.71332, 42.78860,   1.00000, 91.00000, 44.00000);
    CreateDynamicObject(3785, -1649.66248, 555.93854, 42.78860,   1.00000, 91.00000, 44.00000);
    CreateDynamicObject(970, -1639.45117, 561.65228, 38.86964,   0.00000, -2.00000, 35.15998);
    CreateDynamicObject(970, -1635.82788, 563.50836, 39.01688,   0.00000, -2.00000, 18.95999);
    CreateDynamicObject(970, -1631.83167, 563.86096, 39.16924,   0.00000, -2.00000, -8.94002);
    CreateDynamicObject(970, -1651.38843, 572.96814, 38.91042,   0.00000, 2.00000, -122.00000);
    CreateDynamicObject(970, -1650.03577, 576.76526, 39.04351,   0.00000, 2.00000, -96.73994);
    CreateDynamicObject(970, -1649.80432, 580.91882, 39.18819,   0.00000, 2.00000, -90.38007);
    CreateDynamicObject(970, -1649.36841, 561.76550, 38.81018,   0.00000, -2.00000, 46.68002);
    CreateDynamicObject(970, -1650.94409, 563.91779, 38.81018,   0.00000, -2.00000, 48.06004);
    CreateDynamicObject(970, -1653.87781, 569.72784, 38.72562,   0.00000, 2.00000, -133.04005);
    CreateDynamicObject(970, -1656.70264, 566.68243, 38.58709,   0.00000, 2.00000, -133.04005);
    CreateDynamicObject(970, -1659.50708, 563.66516, 38.43610,   0.00000, 2.00000, -133.04005);
    CreateDynamicObject(970, -1661.34009, 561.71082, 38.33194,   0.00000, 2.00000, -133.04005);
    CreateDynamicObject(970, -1655.66357, 544.04504, 37.87597,   0.00000, -2.00000, 63.08002);
    CreateDynamicObject(970, -1657.02979, 540.20825, 37.75260,   0.00000, 0.00000, 77.46003);
    CreateDynamicObject(970, -1657.74341, 536.15594, 37.75260,   0.00000, 0.00000, 82.61983);
    CreateDynamicObject(970, -1653.34070, 547.40149, 38.03130,   0.00000, -2.00000, 47.47990);
    CreateDynamicObject(970, -1650.55151, 550.45441, 38.18080,   0.00000, -2.00000, 47.47990);
    CreateDynamicObject(970, -1647.77551, 553.49377, 38.32710,   0.00000, -2.00000, 47.47990);
    CreateDynamicObject(970, -1646.53357, 554.85431, 38.39230,   0.00000, -2.00000, 47.47990);
    CreateDynamicObject(970, -1642.51831, 558.99579, 38.78867,   0.00000, -2.00000, 45.77998);
    CreateDynamicObject(970, -1664.86829, 557.90387, 38.00870,   0.00000, 2.00000, -133.04010);
    CreateDynamicObject(970, -1667.94299, 555.24951, 37.83510,   0.00000, 2.00000, -144.79980);
    CreateDynamicObject(970, -1671.64563, 553.55829, 37.76033,   0.00000, 0.00000, -165.75940);
    CreateDynamicObject(970, -1675.72363, 553.26770, 37.76078,   0.00000, 0.00000, -185.73889);
    CreateDynamicObject(19951, -1649.20728, 580.75842, 38.46810,   0.00000, 0.00000, 132.24010);
    CreateDynamicObject(19951, -1649.33435, 578.38385, 38.18031,   0.00000, 0.00000, 132.18010);
    CreateDynamicObject(19951, -1649.79504, 575.62872, 38.11237,   0.00000, 0.00000, 132.18010);
    CreateDynamicObject(19951, -1656.92590, 542.28033, 37.07544,   0.00000, 0.00000, -46.25999);
    CreateDynamicObject(19951, -1657.43591, 539.39410, 36.97412,   0.00000, 0.00000, -46.25999);
    CreateDynamicObject(19951, -1657.92529, 536.97528, 36.97411,   0.00000, 0.00000, -46.25999);
    CreateDynamicObject(970, -1652.23596, 558.62048, 38.65855,   0.00000, -2.00000, 46.68000);
    CreateDynamicObject(970, -1655.06274, 555.62927, 38.45250,   0.00000, -2.00000, 46.68000);
    CreateDynamicObject(970, -1657.88208, 552.61218, 38.23950,   0.00000, -2.00000, 46.68000);
    CreateDynamicObject(970, -1653.69897, 560.83942, 38.62202,   0.00000, -2.00000, 48.12005);
    CreateDynamicObject(1237, -1649.77014, 583.78430, 38.95309,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, -1653.91479, 564.78790, 43.03667,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, -1653.63062, 552.19580, 42.75309,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -1660.56287, 558.66779, 42.76229,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -1647.13611, 558.45819, 43.06003,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -1629.08044, 563.49310, 38.91572,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(970, -1675.89319, 557.08405, 37.96043,   0.00000, 0.00000, -133.71913);
    CreateDynamicObject(1237, -1678.01416, 554.49426, 37.43072,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -1655.41943, 530.13599, 37.42583,   0.00000, 0.00000, -1.38000);
    CreateDynamicObject(970, -1656.56909, 532.59497, 37.92515,   0.00000, 0.00000, 137.69971);
    CreateDynamicObject(970, -1652.45874, 531.97943, 37.94935,   0.00000, 0.00000, 217.73921);
    CreateDynamicObject(970, -1680.36060, 555.52960, 37.96035,   0.00000, 0.00000, -224.37857);

    // PEDÁGIO ANGEL PINE - SF
    CreateDynamicObject(8407, -1666.64307, -1637.38953, 36.70590,   0.00000, 0.00000, 22.98000);
    CreateDynamicObject(966, -1662.37256, -1636.02197, 35.24070,   0.00000, 0.00000, -245.69971);
    CreateDynamicObject(966, -1670.43372, -1638.59131, 35.14051,   0.00000, 0.00000, 294.77896);
    CreateDynamicObject(1237, -1668.02051, -1637.95398, 35.18327,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -1668.83752, -1638.32251, 35.18327,   0.00000, 0.00000, -85.25998);
    CreateDynamicObject(1237, -1669.63135, -1638.67249, 35.18327,   0.00000, 0.00000, 22.02000);
    CreateDynamicObject(1237, -1665.25317, -1636.85278, 35.25783,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -1664.24231, -1636.50208, 35.25783,   0.00000, 0.00000, 69.29997);
    CreateDynamicObject(1237, -1663.31372, -1636.07056, 35.25783,   0.00000, 0.00000, 38.93991);
    CreateDynamicObject(19289, -1666.43274, -1637.29309, 38.19085,   0.00000, 0.00000, 0.00000);

    // PEDÁGIO ANGEL PINE - SF 2
    CreateDynamicObject(9623, -2882.88818, -1008.08533, 11.03223,   0.00000, 0.00000, -9.17999);
    CreateDynamicObject(966, -2881.55811, -1003.11310, 8.55072,   0.00000, 0.00000, 169.91998);
    CreateDynamicObject(966, -2885.12134, -1012.88965, 8.55124,   0.00000, 0.00000, -8.88000);
    CreateDynamicObject(970, -2874.23804, -1002.67242, 8.99065,   0.00000, 0.00000, 82.08005);
    CreateDynamicObject(970, -2873.69141, -998.60516, 8.99065,   0.00000, 0.00000, 82.08005);
    CreateDynamicObject(970, -2872.07544, -994.99292, 8.99065,   0.00000, 0.00000, 50.10007);
    CreateDynamicObject(970, -2869.45313, -991.83917, 8.99065,   0.00000, 0.00000, 50.10007);
    CreateDynamicObject(970, -2874.85132, -1006.74725, 8.99065,   0.00000, 0.00000, 80.52003);
    CreateDynamicObject(970, -2875.53687, -1010.80402, 8.99065,   0.00000, 0.00000, 80.52003);
    CreateDynamicObject(970, -2876.20972, -1014.86877, 8.99065,   0.00000, 0.00000, 80.52003);
    CreateDynamicObject(970, -2876.88501, -1018.95435, 8.99065,   0.00000, 0.00000, 80.52003);
    CreateDynamicObject(970, -2876.21655, -1022.77600, 8.97850,   -1.00000, -1.00000, 118.62000);
    CreateDynamicObject(970, -2874.23682, -1026.46143, 8.97850,   -1.00000, -1.00000, 120.12005);
    CreateDynamicObject(970, -2891.79321, -1014.08936, 8.99294,   0.00000, 0.00000, 80.94006);
    CreateDynamicObject(970, -2892.41626, -1018.15582, 8.99294,   0.00000, 0.00000, 80.94006);
    CreateDynamicObject(970, -2894.38721, -1021.30115, 8.99294,   0.00000, 0.00000, 36.06007);
    CreateDynamicObject(970, -2897.90991, -1023.26044, 8.99294,   0.00000, 0.00000, 21.60008);
    CreateDynamicObject(970, -2891.15234, -1009.66022, 8.99294,   0.00000, 0.00000, 80.94006);
    CreateDynamicObject(970, -2890.51440, -1005.61810, 8.99294,   0.00000, 0.00000, 80.94006);
    CreateDynamicObject(970, -2889.87476, -1001.56720, 8.99294,   0.00000, 0.00000, 80.94006);
    CreateDynamicObject(970, -2889.23340, -997.49677, 8.99294,   0.00000, 0.00000, 80.94006);
    CreateDynamicObject(970, -2889.62500, -993.52295, 8.99294,   0.00000, 0.00000, 110.33997);
    CreateDynamicObject(970, -2891.73120, -990.06512, 8.99294,   0.00000, 0.00000, 132.59990);
    CreateDynamicObject(1237, -2895.25610, -988.54010, 8.48083,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2893.90747, -988.65387, 8.48083,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2867.32983, -990.31073, 8.48332,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2900.91284, -1024.32227, 8.48639,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -2872.86377, -1028.43701, 8.48355,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, -2879.86450, -1013.13495, 13.36495,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -2888.66260, -1011.71350, 13.33388,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, -2886.88428, -1002.86981, 13.34014,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, -2878.00464, -1004.30450, 13.34611,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(3785, -2887.68896, -1006.61047, 13.18860,   0.00000, 91.00000, 78.00000);
    CreateDynamicObject(3785, -2878.47900, -1007.07422, 13.18860,   0.00000, 91.00000, 78.00000);

    // PEDÁGIO LS-DILLIMORE
    CreateDynamicObject(4638, 531.54718, 456.86450, 19.59331,   0.00000, 0.00000, 125.82010);
    CreateDynamicObject(966, 532.57581, 454.87384, 17.92626,   0.00000, 0.00000, 37.08002);
    CreateDynamicObject(966, 530.69696, 458.90167, 17.90954,   0.00000, 0.00000, 215.87990);
    CreateDynamicObject(19289, 531.57690, 456.63358, 21.28881,   0.00000, 0.00000, 0.00000);

    // PEDÁGIO BLUEBERRY-FC
    CreateDynamicObject(4638, -170.58691, 357.73950, 12.65599,   0.00000, 0.00000, 75.18007);
    CreateDynamicObject(966, -171.56602, 355.76108, 11.00677,   0.00000, 0.00000, -14.94003);
    CreateDynamicObject(966, -169.51004, 359.72672, 11.07330,   0.00000, 0.00000, -193.49986);
    CreateDynamicObject(19425, -171.06334, 347.79910, 11.07297,   0.00000, 0.00000, -16.14001);
    CreateDynamicObject(19425, -168.08936, 346.92242, 11.07297,   0.00000, 0.00000, -16.14001);
    CreateDynamicObject(19425, -169.92601, 367.35022, 11.07295,   0.00000, 0.00000, -14.22000);
    CreateDynamicObject(19425, -172.97786, 368.11633, 11.07300,   0.00000, 0.00000, -14.22000);
    CreateDynamicObject(1237, -168.27959, 366.32886, 11.07240,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -168.62926, 365.03992, 11.07240,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -168.94949, 363.80457, 11.10907,   0.00000, 0.00000, -21.66000);
    CreateDynamicObject(1237, -169.19545, 362.68951, 11.10907,   0.00000, 0.00000, -80.10000);
    CreateDynamicObject(1237, -169.56969, 361.63052, 11.10907,   0.00000, 0.00000, -152.81990);
    CreateDynamicObject(1237, -169.78358, 360.58893, 11.10907,   0.00000, 0.00000, -155.09982);
    CreateDynamicObject(1237, -167.92050, 367.50342, 11.07240,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -171.18582, 355.14932, 11.07306,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -171.42485, 354.06781, 11.07306,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -171.69470, 352.86356, 11.07306,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -172.07037, 351.67941, 11.07306,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -172.41051, 350.59976, 11.07306,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -172.68518, 349.59296, 11.07306,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -173.01883, 348.54468, 11.07306,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, -173.23662, 347.65915, 11.07306,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19289, -170.59708, 357.76355, 14.35168,   0.00000, 0.00000, 0.00000);

    // PEDÁGIO LS-LV
    CreateDynamicObject(7033, 1737.38062, 518.85992, 31.61950,   -3.00000, 0.00000, -19.16000);
    CreateDynamicObject(966, 1742.13733, 523.06250, 26.70913+0.1,   0.00000, 0.00000, 159.53983);
    CreateDynamicObject(966, 1732.13391, 513.24286, 27.43851+0.1,   0.00000, 0.00000, -22.13990);
    CreateDynamicObject(1237, 1741.55237, 523.64789, 26.72365,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, 1749.28809, 520.44806, 26.79659,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, 1732.86414, 513.11456, 27.46271,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1237, 1724.95825, 516.39960, 27.50552,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(970, 1755.56104, 518.77161, 27.34268,   0.00000, 0.00000, -16.38003);
    CreateDynamicObject(970, 1753.26709, 519.45178, 27.34268,   0.00000, 0.00000, -16.38003);
    CreateDynamicObject(970, 1723.10425, 529.92444, 27.34491,   0.00000, 0.00000, -21.18000);
    CreateDynamicObject(970, 1725.38232, 528.98962, 27.34491,   0.00000, 0.00000, -21.18000);
    CreateDynamicObject(970, 1719.06433, 518.43481, 28.09157,   0.00000, 0.00000, -18.78000);
    CreateDynamicObject(970, 1721.33386, 517.66931, 28.09157,   0.00000, 0.00000, -18.78000);
    CreateDynamicObject(970, 1751.49670, 507.12909, 28.07755,   0.00000, 0.00000, -20.82002);
    CreateDynamicObject(970, 1749.24292, 507.96460, 28.07755,   0.00000, 0.00000, -20.82002);
    CreateDynamicObject(970, 1734.35718, 514.94324, 27.97886,   0.00000, 2.00000, 71.86005);
    CreateDynamicObject(970, 1737.35706, 513.91284, 27.97886,   0.00000, 2.00000, 69.34010);
    CreateDynamicObject(970, 1740.33875, 522.44202, 27.42720,   0.00000, 3.00000, 70.20000);
    CreateDynamicObject(970, 1737.27625, 523.61542, 27.42720,   0.00000, 3.00000, 70.20000);
    CreateDynamicObject(3785, 1745.11646, 516.41339, 33.65080,   -4.00000, 88.00000, -22.00000);
    CreateDynamicObject(3785, 1732.22107, 520.26440, 33.65080,   -4.00000, 88.00000, -22.00000);
    CreateDynamicObject(19953, 1738.87048, 480.65857, 28.87155,   0.00000, 0.00000, -23.52000);
    CreateDynamicObject(19953, 1737.27344, 473.48422, 28.87155,   0.00000, 0.00000, -23.52000);
    CreateDynamicObject(19953, 1735.79297, 467.18237, 28.87155,   0.00000, 0.00000, -23.52000);
    CreateDynamicObject(19953, 1734.62439, 561.73218, 24.69217,   0.00000, 0.00000, 163.97997);
    CreateDynamicObject(19953, 1733.54175, 554.80951, 24.69217,   0.00000, 0.00000, 163.97997);
    CreateDynamicObject(19953, 1733.51575, 550.21057, 25.11431,   0.00000, 0.00000, 163.97997);
    CreateDynamicObject(19294, 1734.64502, 561.74286, 26.84201,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19294, 1735.78259, 467.16953, 30.90257,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1319, 1735.27307, 505.49045, 28.34824,   0.00000, 0.00000, -21.24000);
    CreateDynamicObject(1319, 1734.38806, 502.97867, 28.43510,   0.00000, 0.00000, -21.24000);
    CreateDynamicObject(1319, 1733.60889, 500.39017, 28.59378,   0.00000, 0.00000, -21.24000);
    CreateDynamicObject(1319, 1732.71118, 497.79663, 28.74386,   0.00000, 0.00000, -21.24000);
    CreateDynamicObject(1319, 1731.70581, 495.09912, 28.84822,   0.00000, 0.00000, -21.24000);
    CreateDynamicObject(1319, 1747.90125, 556.41901, 25.22491,   0.00000, 0.00000, -17.34000);
    CreateDynamicObject(1319, 1748.80945, 559.82233, 24.97640,   0.00000, 0.00000, -10.37999);
    CreateDynamicObject(1319, 1749.60815, 562.35693, 24.83793,   0.00000, 0.00000, -10.37999);
    CreateDynamicObject(1319, 1750.47351, 564.76605, 24.65661,   0.00000, 0.00000, -10.13999);
    CreateDynamicObject(1319, 1751.17786, 567.09674, 24.51848,   0.00000, 0.00000, -10.91998);
    CreateDynamicObject(19291, 1741.31934, 510.78186, 32.90065,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, 1728.95642, 515.08185, 32.99088,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19291, 1733.15417, 527.14301, 32.31889,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(19282, 1745.85168, 522.73212, 32.33182,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(626, 1738.98486, 523.47260, 28.85401,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(627, 1735.63989, 513.70776, 29.22456,   0.00000, 0.00000, 0.00000);
    CreateDynamicObject(1226, 1719.77246, 524.03223, 31.27108,   0.00000, 0.00000, 168.95967);
    CreateDynamicObject(1226, 1754.87097, 512.50122, 31.21050,   0.00000, 0.00000, -20.52001);


    return 1;
}

function CRIANDOPEDAGIO::ResetVariables(playerid)
{
    DestroyDynamicObject(CreatingPedagio[playerid][Objeto]);
    
    CreatingPedagio[playerid][Objeto] = INVALID_OBJECT_ID;
    CreatingPedagio[playerid][Valor] = 0;
    CreatingPedagio[playerid][X] = 0;
    CreatingPedagio[playerid][Y] = 0;
    CreatingPedagio[playerid][Z] = 0;
    CreatingPedagio[playerid][RX] = 0;
    CreatingPedagio[playerid][RY] = 0;
    CreatingPedagio[playerid][RZ] = 0;
    CreatingPedagio[playerid][AbertoX] = 0;
    CreatingPedagio[playerid][AbertoY] = 0;
    CreatingPedagio[playerid][AbertoZ] = 0;
    CreatingPedagio[playerid][AbertoRotX] = 0;
    CreatingPedagio[playerid][AbertoRotY] = 0;
    CreatingPedagio[playerid][AbertoRotZ] = 0;
    CreatingPedagio[playerid][CancelaX] = 0;
    CreatingPedagio[playerid][CancelaY] = 0;
    CreatingPedagio[playerid][CancelaZ] = 0;
    CreatingPedagio[playerid][PosicionandoLabel] = false;
    CreatingPedagio[playerid][PosicionandoAbertura] = false;
    return 1;
}

function CRIANDOPEDAGIO::ShowDialog(playerid)
{
    new String[1000], Str[1000];
    format(Str, sizeof(Str), "Valor\t{31b404}R$%s\n", RealStr(CreatingPedagio[playerid][Valor]) );
    strcat(String, Str);

    format(Str, sizeof(Str), "Posicionar Label\t{ffff00}%f, %f, %f\n", CreatingPedagio[playerid][X], CreatingPedagio[playerid][Y], CreatingPedagio[playerid][Z]);
    strcat(String, Str);

    format(Str, sizeof(Str), "Posicionar Cancela\t{ffff00}%f, %f, %f, %f, %f, %f\n", CreatingPedagio[playerid][CancelaX], CreatingPedagio[playerid][CancelaY], CreatingPedagio[playerid][CancelaZ], CreatingPedagio[playerid][RX], CreatingPedagio[playerid][RY], CreatingPedagio[playerid][RZ]);
    strcat(String, Str);

    format(Str, sizeof(Str), "Posicionar Abertura\t{ffff00}%f, %f, %f, %f, %f, %f\n", CreatingPedagio[playerid][AbertoX], CreatingPedagio[playerid][AbertoY], CreatingPedagio[playerid][AbertoZ], \
    CreatingPedagio[playerid][AbertoRotX], CreatingPedagio[playerid][AbertoRotY], CreatingPedagio[playerid][AbertoRotZ]);
    strcat(String, Str);

    format(Str, sizeof(Str), "{ff0000}Criar Pedágio\n");
    strcat(String, Str);

    ShowPlayerDialog(playerid, DIALOG_CREATE_PEDAGIO, DIALOG_STYLE_TABLIST, "{ffffff}Menu de Criação do Pedágio", String, "Selecionar", "Cancelar");
    return 1;
}

hook OnPlayerConnect(playerid)
{
    call::CRIANDOPEDAGIO->ResetVariables(playerid);
    return 1;
}

hook OnGameModeInit()
{
    call::PEDAGIOS->CreateMap();
    call::PEDAGIO->ReloadPedagios();
    return 1;
}

hook OP_EditDynamicObject(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
    if(objectid == CreatingPedagio[playerid][Objeto])
    {
        if(CreatingPedagio[playerid][PosicionandoAbertura] == false)
        {
            switch(response)
            {
                case EDIT_RESPONSE_CANCEL:
                {
                    DestroyDynamicObject(CreatingPedagio[playerid][Objeto]);
                    CreatingPedagio[playerid][Objeto] = INVALID_OBJECT_ID;

                    SendClientMessage(playerid, COR_ERRO, "| PEDÁGIO | Você cancelou a criação do pedágio.");
                    call::CRIANDOPEDAGIO->ResetVariables(playerid);
                    return 1;
                }

                case EDIT_RESPONSE_FINAL:
                {
                    DestroyDynamicObject(CreatingPedagio[playerid][Objeto]);
                    CreatingPedagio[playerid][Objeto] = INVALID_OBJECT_ID;

                    SendClientMessage(playerid, -1, "| PEDÁGIO | Você posicionou a cancela com sucesso.");
                    CreatingPedagio[playerid][CancelaX] = x;
                    CreatingPedagio[playerid][CancelaY] = y;
                    CreatingPedagio[playerid][CancelaZ] = z;
                    CreatingPedagio[playerid][RX] = rx;
                    CreatingPedagio[playerid][RY] = ry;
                    CreatingPedagio[playerid][RZ] = rz;

                    call::CRIANDOPEDAGIO->ShowDialog(playerid);
                }
            }
        }

        else if(CreatingPedagio[playerid][PosicionandoAbertura] == true)
        {
            switch(response)
            {
                case EDIT_RESPONSE_CANCEL:
                {
                    DestroyDynamicObject(CreatingPedagio[playerid][Objeto]);
                    CreatingPedagio[playerid][Objeto] = INVALID_OBJECT_ID;

                    SendClientMessage(playerid, COR_ERRO, "| PEDÁGIO | Você cancelou a criação do pedágio.");
                    call::CRIANDOPEDAGIO->ResetVariables(playerid);
                    return 1;
                }



                case EDIT_RESPONSE_FINAL:
                {
                    DestroyDynamicObject(CreatingPedagio[playerid][Objeto]);
                    CreatingPedagio[playerid][Objeto] = INVALID_OBJECT_ID;

                    SendClientMessage(playerid, -1, "| PEDÁGIO | Você posicionou a abertura da cancela com sucesso.");
                    CreatingPedagio[playerid][AbertoX] = x;
                    CreatingPedagio[playerid][AbertoY] = y;
                    CreatingPedagio[playerid][AbertoZ] = z;
                    CreatingPedagio[playerid][AbertoRotX] = rx;
                    CreatingPedagio[playerid][AbertoRotY] = ry;
                    CreatingPedagio[playerid][AbertoRotZ] = rz;

                    call::CRIANDOPEDAGIO->ShowDialog(playerid);
                }
            }
        }
    }
    return 1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    if(newkeys == KEY_CROUCH)
    {
        if(CreatingPedagio[playerid][PosicionandoLabel] == true)
        {
            SendClientMessage(playerid, -1, "| PEDÁGIO | Você posicionou a {"COR_LARANJA_INC"}Label {ffffff}com sucesso.");
            GetPlayerPos(playerid, CreatingPedagio[playerid][X], CreatingPedagio[playerid][Y], CreatingPedagio[playerid][Z]);

            CreatingPedagio[playerid][PosicionandoLabel] = false;

            call::CRIANDOPEDAGIO->ShowDialog(playerid);
        }
    }

    if(newkeys == KEY_CROUCH)
    {
        if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            foreach(new id: Pedagio)
            {
                if(IsPlayerInRangeOfPoint(playerid, 5.0, cPedagio[id][X], cPedagio[id][Y], cPedagio[id][Z]))
                {
                    if(GetPlayerMoney(playerid) < cPedagio[id][Valor])
                        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não possui dinheiro suficiente.");
                    
                    GivePlayerMoney(playerid, -cPedagio[id][Valor]);

                    SendClientMessage(playerid, COR_AMARELO, "| PEDÁGIO | A cancela será aberta. Boa viagem!");

                    new Float:Posicao[4];
                    Posicao[0] = cPedagio[id][AbertoX];
                    Posicao[1] = cPedagio[id][AbertoY];
                    Posicao[2] = cPedagio[id][AbertoZ];

                    new Float:PosicaoEx[4];
                    PosicaoEx[0] = cPedagio[id][AbertoRotX];
                    PosicaoEx[1] = cPedagio[id][AbertoRotY];
                    PosicaoEx[2] = cPedagio[id][AbertoRotZ];

                    MoveDynamicObject(cPedagio[id][CancelaID], Posicao[0], Posicao[1], Posicao[2]-0.001, 0.0001, PosicaoEx[0], PosicaoEx[1], PosicaoEx[2]);

                    SetTimerEx("BackPedagio", 5000, 0, "ii", cPedagio[id][ID], cPedagio[id][CancelaID]);
                }
            }
        }
    }
    return 1;
}

forward BackPedagio(id, idcancela);

public BackPedagio(id, idcancela)
{
    new query[350];
    format(query, 350, "SELECT * FROM `pedagios` WHERE `id`='%d'", id);

    new Cache:result = mysql_query(getConexao(), query, true), rows = cache_num_rows();

    if(rows)
    {
        new Float:Posicao[4], Float:PosicaoEx[4];
        cache_get_value_float(0, "posX", Posicao[0]);
        cache_get_value_float(0, "posY", Posicao[1]);
        cache_get_value_float(0, "posZ", Posicao[2]);
        cache_get_value_float(0, "rotX", PosicaoEx[0]);
        cache_get_value_float(0, "rotY", PosicaoEx[1]);
        cache_get_value_float(0, "rotZ", PosicaoEx[2]);

        MoveDynamicObject(idcancela, Posicao[0], Posicao[1], Posicao[2], 0.001, PosicaoEx[0], PosicaoEx[1], PosicaoEx[2]);

        
    }

    cache_delete(result);
    return 1;
}

forward AdicionarID(playerid);
public AdicionarID(playerid)
{
    new id = cache_insert_id();

    SendClientMessage(playerid, -1, "| PEDÁGIO | Pedágio {1c88f0}%d {ffffff}criado com sucesso.", id);

    call::PEDAGIO->ReloadPedagios();
    return 1;
}


flags:criarpedagio(DEV);
CMD:criarpedagio(playerid, params[])
{
    call::CRIANDOPEDAGIO->ShowDialog(playerid);
    return 1;
}

Dialog:DIALOG_CREATE_PEDAGIO(playerid, response, listitem, inputtext[])
{
    if(!response)
        return call::CRIANDOPEDAGIO->ResetVariables(playerid);
    
    if(response)
    {
        switch(listitem)
        {
            case 0: // Valor
            {   
                ShowPlayerDialog(playerid, DIALOG_PEDAGIO_VALOR, DIALOG_STYLE_INPUT, "{ffffff}Menu de Criação do Pedágio", "{ffffff}Digite abaixo o valor do pedágio", "Inserir", "Voltar");
            }   

            case 1: // Posicionar Label
            {
                SendClientMessage(playerid, -1, "| PEDÁGIO | Se posicione aonde deve ficar a label do pedágio e aperte {1c88f0}C{ffffff}.");
                CreatingPedagio[playerid][PosicionandoLabel] = true;
            }

            case 2: // Posicionar Cancela
            {
                new Float:Posicao[4];
                GetPlayerPos(playerid, Posicao[0], Posicao[1], Posicao[2]);

                CreatingPedagio[playerid][Objeto] = CreateDynamicObject(968, Posicao[0], Posicao[1], Posicao[2], 0.0, -90.0, 0.0);

                SendClientMessage(playerid, -1, "| PEDÁGIO | Posicione a cancela e clique em {1c88f0}salvar {ffffff}para salvar a posição.");

                SetTimerEx("EditObjectEx", 300, 0, "i", playerid);
            }

            case 3: // Posicionar Abertura
            {

                CreatingPedagio[playerid][Objeto] = CreateDynamicObject(968, CreatingPedagio[playerid][CancelaX], CreatingPedagio[playerid][CancelaY], CreatingPedagio[playerid][CancelaZ], \
                CreatingPedagio[playerid][RX], CreatingPedagio[playerid][RY], CreatingPedagio[playerid][RZ]);

                SendClientMessage(playerid, -1, "| PEDÁGIO | Posicione a abertura da cancela e clique em {1c88f0}salvar {ffffff}para salvar a posição.");

                SetTimerEx("EditObjectEx", 300, 0, "i", playerid);

                CreatingPedagio[playerid][PosicionandoAbertura] = true;
            }

            case 4: // Criar o Pedágio
            {   
                new query[1000];

                mysql_format(getConexao(), query, 1000, "INSERT INTO `pedagios`(valor, labelX, labelY, labelZ, posX, posY, posZ, rotX, rotY, rotZ, abertoX, abertoY, abertoZ, \
                abertoRotX, abertoRotY, abertoRotZ) VALUES \
                ('%d', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f', '%f')", CreatingPedagio[playerid][Valor], CreatingPedagio[playerid][X], CreatingPedagio[playerid][Y], CreatingPedagio[playerid][Z], \
                CreatingPedagio[playerid][CancelaX], CreatingPedagio[playerid][CancelaY], CreatingPedagio[playerid][CancelaZ], CreatingPedagio[playerid][RX], CreatingPedagio[playerid][RY], CreatingPedagio[playerid][RZ], \
                CreatingPedagio[playerid][AbertoX], CreatingPedagio[playerid][AbertoY], CreatingPedagio[playerid][AbertoZ], CreatingPedagio[playerid][AbertoRotX], CreatingPedagio[playerid][AbertoRotY], \
                CreatingPedagio[playerid][AbertoRotZ]);

                mysql_tquery(getConexao(), query, "AdicionarID", "i", playerid);

                call::CRIANDOPEDAGIO->ResetVariables(playerid);
            }
        }
    }
    return 1;
}

forward EditObjectEx(playerid);
public EditObjectEx(playerid)
{
    EditDynamicObject(playerid, CreatingPedagio[playerid][Objeto]);
    return 1;   
}

Dialog:DIALOG_PEDAGIO_VALOR(playerid, response, listitem, inputtext[])
{
    if(!response) return call::CRIANDOPEDAGIO->ShowDialog(playerid);

    if(response)
    {
        if(!IsNumeric(inputtext))
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você deve inserir um número."), ShowPlayerDialog(playerid, DIALOG_PEDAGIO_VALOR, DIALOG_STYLE_INPUT, "{ffffff}Menu de Criação do Pedágio", "{ffffff}Digite abaixo o valor do pedágio", "Inserir", "Voltar");
    
        CreatingPedagio[playerid][Valor] = strval(inputtext);

        SendClientMessage(playerid, -1, "| PEDÁGIO | Você definiu o valor do pedágio para {31b404}R$%s{ffffff}.", RealStr(CreatingPedagio[playerid][Valor]));

        call::CRIANDOPEDAGIO->ShowDialog(playerid);
    }
    return 1;
}