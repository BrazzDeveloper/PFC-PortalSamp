
// Rotas
enum TLocationStatic
{
	LocationName[50],
	Float:LocX,
	Float:LocY,
	Float:LocZ
};
/*new const ALocationsStatic[][TLocationStatic] =
{
    {"Ponto", 1067.00, 1357.75, 10.7}, // Location 0
	{"Ponto", 1324.75, 1190.75, 10.7}, // Location 1
	{"Ponto", 1544.00, 1135.50, 10.7}, // Location 2
	{"Ponto", 1603.50, 1130.50, 10.7}, // Location 3
	{"Ponto", 1722.50, 1373.25, 10.5}, // Location 4
	{"Ponto", 1714.25, 1421.75, 10.5}, // Location 5
	{"Ponto", 1010.00, 1411.25, 10.7}, // Location 6
	{"Ponto", 1726.50, 1481.75, 10.7}, // Location 7
	{"Ponto", 1729.50, 1529.50, 10.7}, // Location 8
	{"Ponto", 1705.00, 1965.00, 10.7}, // Location 9
	{"Ponto", 1385.00, 1920.00, 10.7}, // Location 10
	{"Ponto", 1335.25, 2055.50, 10.7}, // Location 11
	{"Ponto", 1073.00, 2055.50, 10.7}, // Location 12
	{"Ponto", 1502.25, 2055.50, 10.7}, // Location 13
	{"Ponto", 1565.00, 2200.25, 10.7}, // Location 14
	{"Ponto", 1636.25, 2175.50, 10.7}, // Location 15
	{"Ponto", 1503.50, 2311.00, 10.7}, // Location 16
	{"Ponto", 1564.75, 2345.75, 10.7}, // Location 17
	{"Ponto", 1725.00, 2247.75, 10.7}, // Location 18
	{"Ponto", 1894.50, 2175.50, 10.7}, // Location 19
	{"Ponto", 1925.25, 2314.75, 10.7}, // Location 20
	{"Ponto", 1925.25, 2115.75, 10.8}, // Location 21
	{"Ponto", 2083.50, 2455.50, 10.7}, // Location 22
	{"Ponto", 2285.00, 2315.00, 10.7}, // Location 23
	{"Ponto", 2305.00, 2515.50, 10.7}, // Location 24
	{"Ponto", 2392.00, 2415.50, 10.7}, // Location 25
	{"Ponto", 2425.00, 2285.00, 10.7}, // Location 26
	{"Ponto", 2449.75, 2235.50, 10.7}, // Location 27
	{"Ponto", 2580.25, 2115.50, 10.7}, // Location 28
	{"Ponto", 2447.50, 2055.50, 10.7}, // Location 29
	{"Ponto", 2115.00, 755.50, 10.7}, // Location 30
	{"Ponto", 2019.75, 750.50, 10.7}, // Location 31
	{"Ponto", 1975.00, 775.50, 10.7}, // Location 32
	{"Ponto", 1885.00, 770.75, 10.7}, // Location 33
	{"Ponto", 1894.00, 635.75, 10.7}, // Location 34
	{"Ponto", 1974.25, 631.00, 10.7}, // Location 35
	{"Ponto", 2020.50, 670.50, 10.7}, // Location 36
	{"Ponto", 2114.75, 675.75, 10.7}, // Location 37
	{"Ponto", 1084.75, 1196.00, 10.7}, // Location 38

    {"Ponto 1 Bayside", -2565.75, 2315.25,    4.83}, // Location 39
	{"Ponto 2 Bayside", -2337.00, 2375.00,    5.59}, // Location 40
	{"Ponto 1 El Quebrados", -1467.00, 2674.00,   55.68}, // Location 41
    {"Ponto 2 El Quebrados", -1528.50, 2548.00,   55.68}, // Location 42
	{"Ponto 1 Las Barrancas", -805.64, 1562.30,   26.96}, // Location 43
    {"Ponto 2 Las Barrancas", -847.00, 1529.50,   21.66}, // Location 44
    {"Ponto Las Payasdas", -269.00, 2625.75,   62.64}, // Location 45
	{"Ponto 1 Fort Carson",  -45.37, 1200.68,   19.21}, // Location 46
	{"Ponto 2 Fort Carson", -100.50, 1195.75,   19.58}, // Location 47
	{"Ponto 3 Fort Carson", -249.50, 1016.00,   19.59}, // Location 48
	{"Ponto 1 Angel Pine", -2169.75, -2305.75,   30.46}, // Location 49
	{"Ponto 2 Angel Pine", -2098.25, -2499.50,   30.46}, // Location 50
	{"Ponto 1 Palomino Creek", 2263.75,  -30.75,   26.33}, // Location 51
	{"Ponto 2 Palomino Creek", 2461.75,    1.00,   26.33}, // Location 52
	{"Ponto 1 Montgomery", 1288.50,  329.00,   19.40}, // Location 53
	{"Ponto 2 Montgomery", 1286.75,  323.75,   19.40}, // Location 54
	{"Ponto 1 Dillimore",  736.00, -527.50,   16.18}, // Location 55
	{"Ponto 2 Dillimore",  736.00, -532.50,   16.18}, // Location 56

    {"Hospital SF", -2661.8450, 593.0781, 14.2329}, // Hospital SF = 57
    {"Prefeitura SF", -2395.40, 498.65, 29.60}, // Prefeitura SF = 58
    {"Zero SF", -2255.1653, 129.8200, 34.9522},  // ZeroSF = 59
	{"Auto-Escola SF", -2043.5298, -74.2513, 34.9454},  // Auto-EscolaSF = 60
	{"Corpo de Bombeiros (SF)",-2013.4888,67.0350,28.8519}, // Corpo de Bombeiros SF = 61
	{"Wang Cars", -1988.3884,286.2275,34.0579}, // Wang Cars = 62
	{"Policia(SF)",-1608.6486,724.7753,12.1714}, // Policia SF = 63
	{"Bairro Chines(SF)" ,-2239.0447,728.9248,49.0444}, // Bairro Chines = 64
	{"Casino Dizzy(SF)",-2642.0281,1361.3981,6.9296}, // Baixo da ponte em SF. = 65
	{"Otto Autos(SF)" ,-1646.5657,1221.0721,6.8182}, // Otto Autos = 66
	{"Four Dragons",2039.7419,1006.8972,10.4502}, // Four Dragons = 67
	{"Royal Casino",2075.6418,1448.6735,10.4506}, // Royal Casino = 68
	{"Casino Caligulas",2176.8547,1674.9038,10.5994}, // Casino Caligulas = 69
	{"Pirates Mens(LV)",2038.6433,1570.1740,10.4512}, // Pirates Mens [LV] = 70
	{"Shopping (LV)",2038.5256,1344.0573,10.4518}, // Shopping LV = 71
	{"Estacionamento (LV)" ,2317.5181,1530.1643,10.4853}, // Estacionamento LV = 72
	{"Hotel (LV)",2489.0300,1658.9271,10.6005}, // Hotel 1 LV = 73
	{"Ponto Chines (LV)", 2598.1082,1694.0354,10.5998}, // Ponto Chines LV = 74
	{"Estacionamento (LV)" ,2323.3167,1910.8423,8.6665}, // Estacionamento 2 LV = 75
	{"Casino (LV)",2339.3735,2169.0237,10.5068}, // Casino LV [Sem Nome] 1 = 76
	{"Ponto de Lojas(LV)",2105.0215,2219.2051,10.5988}, // Varias Lojas. = 77
	{"Prefeitura (LV)",2435.3440,2379.4890,10.5990}, // Embaixada Americana LV = 78
	{"Policia (LV)",2298.0393,2421.3723,10.5990}, // Policia LV = 79
	{"Ammu Nation (LV)",2611.2432,2086.2603,10.5985}, // Ammu Nation LV = 80
	{"Hotel (LV)",2823.6494,2209.5229,10.5953}, // Hotel 2 LV = 81
	{"Mercadão (LV)",2910.4453,2321.8987,10.4504}, // Mercadão LV = 82
	{"Rock Hotel (LV)",2634.9211,2347.8994,10.4502}, // Rock Hotel = 83
	{"Estadio Base-Ball",1309.9188,2055.0850,10.4506}, // Estadio de Base-bal = 84
	{"Hospital (LV)",1624.2302,1850.1892,10.5985}, // Hospital LV = 85
	{"Aeroporto (LV)",1715.2297,1465.4004,10.4646}, // Aeroporto LV = 86
	{"Aeroporto (SF)",-1417.3231,-303.2910,13.8316}, // Aeroporto SF = 87
	{"Estacionamento Aeroporto (SF)",-1414.9719,-325.1689,5.8205}, // Aeroporto SF Estacionamento = 88
	{"Estadio SF",-2123.2290,-362.1259,34.9984}, // Estadio SF = 89
	{"Corpo de Bombeiros(LS)",1752.2161,-1446.1757,13.0842}, // Corpo de Bombeiros LS = 90
	{"Hospital (LS)",2003.3811,-1444.7998,13.2889}, // Hospital LS 1 = 91
	{"Hotel (LS)",2223.2427,-1151.2579,25.5205}, // Hotel Jefferson = 92
	{"Ammu-Nation (LS)",1361.1602,-1283.6879,13.0968}, // Ammu-Nation LS = 93
	{"Saints Generals (LS)",1191.7095,-1324.0533,13.1255}, // Hospital 2 [Saints Generals] = 94
	{"Shopping (LS)",1135.2720,-1568.8386,13.0338}, // Shopping LS = 95
	{"Cinema (LS)",1316.1414,-1709.2622,13.1099}, // Cinema LS = 96
	{"Prefeitura (LS)",1480.9764,-1739.5758,13.2740}, // Prefeitura LS = 97
	{"Policia (LS)",1535.2622,-1674.3986,13.1099}, // Policia LS = 98
	{"Grove Street",2486.4651,-1682.7950,13.0617}, // Grove Street = 99
	{"Shop XXX",1947.4886,-2123.7644,13.2734}, // Shop XXX = 100
	{"Aeroporto (LS)",1684.1071,-2251.1858,13.1183}, // Aeroporto LS = 101
	{"Praia Santa Maria (LS)",324.5158,-1810.0468,4.1938}, // Praia de Santa Maria. = 102
 	{"Casino", 2154.72, 2079.20,   10.39}, // 103
	{"Sex Shop", 2119.75, 2077.04,   10.39} // 104
};*/
/*enum TLocation
{
	LocationName[50],
	Float:LocX,
	Float:LocY,
	Float:LocZ
}
new const ALocations[][TLocation] =
{
	{"Dummy location", 0.0, 0.0, 0.0}, // Location 0 = (Sem uso)

	{"Construcao (LS)", 1859.0, -1314.0, 14.0}, // Location 1
	{"Construcao (SF)", -2083.0, 209.0, 35.5}, // Location 2
	{"Construcao (LV)", 2708.0, 878.0, 10.0}, // Location 3
	{"Construcao (Avery)", 312.25, -233.75, 1.6}, // Location 4
	{"Construcao (Clown's Pocket)", 2467.0, 1923.0, 9.8}, // Location 5
	{"Industrias Solarin", -1822.5, 41.25, 15.25}, // Location 6
	{"Terminal Caminhoneiro", 52.75, -278.0, 1.7}, // Location 7
	{"Petrobras", 2708.5, 2641.25, 11.0}, // Location 8
	{"Federal Mint", -2441.0, 521.5, 30.0}, // Location 9
	{"Serralheria", -1965.75, -2436.0, 30.7}, // Location 10
	{"Pedreira",  598.27,  840.75,  -43.38}, // Substituição - id 11
	{"Pedreira Top", 370.0, 874.0, 20.5}, // Location 12
	{"Deposito de Madeira", -763.5, -136.0, 65.7}, // Location 13
	{"Papeis Mill", 2331.5, -2071.5, 13.6}, // Location 14
	{"Fabrica Sprunk", 1334.75, 287.0, 19.6}, // Location 15
	{"Centro Medico (SF)", -2607.0, 684.0, 27.9}, // Location 16
	{"Ferro Velho", -1873.0, -1685.0, 21.8}, // Location 17
	{"Deposito de Cargas (LV)", 599.5, 1224.75, 11.8}, // Location 18
	{"Deposito de Lixo (LS)", 2181.0, -1980.5, 13.6}, // Location 19
	{"Industrias Estate (LV)", 1635.75, 750.5, 11.0}, // Location 20
	{"Fazenda EasterBoard", -69.5, -35.75, 3.2}, // Location 21
	{"Fazenda HillFarm", -1423.5, -1469.0, 101.7}, // Location 22
	{"Leste sementes & racoes", -310.5, 2669.5, 62.7}, // Location 23
	{"Porto (SF)", -1691.0, 31.5, 3.6}, // Location 24
	{"Refinaria (LV)", 262.5, 1453.75, 10.6}, // Location 25
	{"Refinaria (LS)", 2484.0, -2085.0, 13.6}, // Location 26
	{"Posto Countryside", -86.0, -1192.75, 2.0}, // Location 27
	{"Posto Xoomer (SF)", -1712.43, 391.65, 6.90}, // Location 28
	{"Posto (SF)", -2421.5, 953.25, 45.3}, // Location 29
	{"Posto (LS)", 1926.0, -1791.5, 13.5}, // Location 30
	{"Posto Xoomer", -1488.75, 1875.25, 32.7}, // Location 31
	{"Posto Whetstone", -1629.0, -2700.0, 48.6}, // Location 32
	{"Posto Deserto", -1309.5, 2703.75, 50.1}, // Location 33
	{"Posto Dilimore", 664.5, -583.75, 16.4}, // Location 34
	{"Posto Aeroporto", 387.9, 2590.25, 16.5}, // Location 35
	{"International SF", -1152.25, -146.5, 14.2}, // Location 36
	{"Laboratorio Easter Bay", -1033.75, -625.25, 32.1}, // Location 37
	{"Docas Ocean", 2466.0, -2219.25, 13.6}, // Location 38
	{"Corp. BioCombustivel", 1347.5, 349.5, 20.0}, // Location 39
	{"Faculdade Vidro Verde", 999.0, 1086.75, 11.0}, // Location 40
	{"Cervejaria Fleischberg", -149.75, -220.25, 1.5}, // Location 41
	{"Estaleiro Naval", -2430.75, 2310.5, 5.0}, // Location 42
	{"Deposito (LV)", 977.5, 2096.75, 11.0}, // Location 43
	{"Catering LTDA (SF)", -1945.75, -1073.5, 31.0}, // Location 44
	{"Padaria (LS)", 1025.75, -1355.0, 13.8}, // Location 45
	{"Casas Porter's", 2439.75, 114.5, 26.5}, // Location 46
	{"Chuckup LTDA", 1470.5, 1017.5, 10.9}, // Location 47
	{"Armazem (LS)", 2178.5, -2279.75, 13.6}, // Location 48
	{"Supa Save (SF)", -2463.5, 782.0, 35.2}, // Location 49
	{"Shopping Verona", 1044.75, -1548.75, 13.6}, // Location 50
	{"Shopping Las Venturas", 2867.25, 2586.0, 10.7}, // Location 51
	{"Vank Hoff Hotel", -2490.75, 337.5, 33.4}, // Location 52
	{"Shopping Esmeralda", 2056.75, 2251.25, 10.7}, // Location 53
	{"Docas Ocean", 2574.25, -2223.75, 13.4}, // Location 54
	{"Armazem BaySide", -2285.0, 2281.5, 5.0}, // Location 55
	{"Fabrica SKOL", -18.5, -282.0, 5.5}, // Location 56
	{"Estadio Las Venturas", 1377.5, 2245.75, 10.9}, // Location 57
	{"P. Creek Comercio Geral", 2318.0, -92.5, 26.5}, // Location 58
	{"Estadio Dirty Ring (LV)", 1112.0, 1451.75, 5.9}, // Location 59
	{"Cupula do Prazer", -2697.0, 1402.5, 7.2}, // Location 60
	{"Casino 4 Dragons", 1903.75, 960.5, 10.9}, // Location 61
	{"Centro Financeiro (SF)", -2039.5, 467.5, 35.2}, // Location 62
	{"Area 69", 134.54, 1945.79, 19.00}, // Location 63
    {"Usina DISA", -170.3889, 94.7059, 3.7083}, //Location 64

	{"Ponto", 1067.00, 1357.75, 10.7}, // Location 64
	{"Ponto", 1324.75, 1190.75, 10.7}, // Location 65
	{"Ponto", 1544.00, 1135.50, 10.7}, // Location 66
	{"Ponto", 1603.50, 1130.50, 10.7}, // Location 67
	{"Ponto", 1722.50, 1373.25, 10.5}, // Location 68
	{"Ponto", 1714.25, 1421.75, 10.5}, // Location 69
	{"Ponto", 1010.00, 1411.25, 10.7}, // Location 70
	{"Ponto", 1726.50, 1481.75, 10.7}, // Location 71
	{"Ponto", 1729.50, 1529.50, 10.7}, // Location 72
	{"Ponto", 1705.00, 1965.00, 10.7}, // Location 73
	{"Ponto", 1385.00, 1920.00, 10.7}, // Location 74
	{"Ponto", 1335.25, 2055.50, 10.7}, // Location 75
	{"Ponto", 1073.00, 2055.50, 10.7}, // Location 76
	{"Ponto", 1502.25, 2055.50, 10.7}, // Location 77
	{"Ponto", 1565.00, 2200.25, 10.7}, // Location 78
	{"Ponto", 1636.25, 2175.50, 10.7}, // Location 79
	{"Ponto", 1503.50, 2311.00, 10.7}, // Location 80
	{"Ponto", 1564.75, 2345.75, 10.7}, // Location 81
	{"Ponto", 1725.00, 2247.75, 10.7}, // Location 82
	{"Ponto", 1894.50, 2175.50, 10.7}, // Location 83
	{"Ponto", 1925.25, 2314.75, 10.7}, // Location 84
	{"Ponto", 1925.25, 2115.75, 10.8}, // Location 85
	{"Ponto", 2083.50, 2455.50, 10.7}, // Location 86
	{"Ponto", 2285.00, 2315.00, 10.7}, // Location 87
	{"Ponto", 2305.00, 2515.50, 10.7}, // Location 88
	{"Ponto", 2392.00, 2415.50, 10.7}, // Location 89
	{"Ponto", 2425.00, 2285.00, 10.7}, // Location 90
	{"Ponto", 2449.75, 2235.50, 10.7}, // Location 91
	{"Ponto", 2580.25, 2115.50, 10.7}, // Location 92
	{"Ponto", 2447.50, 2055.50, 10.7}, // Location 93
	{"Ponto", 2115.00, 755.50, 10.7}, // Location 94
	{"Ponto", 2019.75, 750.50, 10.7}, // Location 95
	{"Ponto", 1975.00, 775.50, 10.7}, // Location 96
	{"Ponto", 1885.00, 770.75, 10.7}, // Location 97
	{"Ponto", 1894.00, 635.75, 10.7}, // Location 98
	{"Ponto", 1974.25, 631.00, 10.7}, // Location 99
	{"Ponto", 2020.50, 670.50, 10.7}, // Location 100
	{"Ponto", 2114.75, 675.75, 10.7}, // Location 101
	{"Ponto", 1084.75, 1196.00, 10.7}, // Location 102

	{"Ponto 1 Bayside", -2565.75, 2315.25,    4.83}, // Location 103
	{"Ponto 2 Bayside", -2337.00, 2375.00,    5.59}, // Location 104
	{"Ponto 1 El Quebrados", -1467.00, 2674.00,   55.68}, // Location 105
    {"Ponto 2 El Quebrados", -1528.50, 2548.00,   55.68}, // Location 106
	{"Ponto 1 Las Barrancas", -805.64, 1562.30,   26.96}, // Location 107
	{"Ponto 2 Las Barrancas", -847.00, 1529.50,   21.66}, // Location 108
	{"Ponto Las Payasdas", -269.00, 2625.75,   62.64}, // Location 109
	{"Ponto 1 Fort Carson",  -45.37, 1200.68,   19.21}, // Location 110
	{"Ponto 2 Fort Carson", -100.50, 1195.75,   19.58}, // Location 111
	{"Ponto 3 Fort Carson", -249.50, 1016.00,   19.59}, // Location 112
	{"Ponto 1 Angel Pine", -2169.75, -2305.75,   30.46}, // Location 113
	{"Ponto 2 Angel Pine", -2098.25, -2499.50,   30.46}, // Location 114
	{"Ponto 1 Palomino Creek", 2263.75,  -30.75,   26.33}, // Location 115
	{"Ponto 2 Palomino Creek", 2461.75,    1.00,   26.33}, // Location 116
	{"Ponto 1 Montgomery", 1288.50,  329.00,   19.40}, // Location 117
	{"Ponto 2 Montgomery", 1286.75,  323.75,   19.40}, // Location 118
	{"Ponto 1 Dillimore",  736.00, -527.50,   16.18}, // Location 119
	{"Ponto 2 Dillimore",  736.00, -532.50,   16.18}, // Location 120

	{"Portao 1 SF", -1216.12, -281.13,  14.14}, // ID = 121
	{"Portao 2 SF", -1395.26, -104.20,   14.14}, // ID = 122
	{"Compartimento 1 SF", -1337.16, -542.29,   14.14}, // ID = 123
	{"Compartimento 2 SF", -1412.96, -579.85,   14.14}, // ID = 124

	{"Portao 1 LS", 1747.04, -2441.04,   13.55}, // ID = 125
	{"Portao 2 LS", 1902.16, -2350.11,   13.54}, // ID = 126
	{"Compartimento 1 LS", 1889.10, -2625.49,   13.54}, // ID = 127
	{"Compartimento 2 LS", 1754.74, -2622.69,   13.54}, // ID = 128
	{"Compartimento 3 LS", 1617.61, -2622.30,   13.54}, // ID = 129

	{"Portao 1 LV", 1564.77, 1536.77,   10.82}, // ID = 130
	{"Portao 2 LV", 1569.85, 1358.58,   10.86}, // ID = 131
	{"Compartimento 1 LV", 1307.41, 1324.01,   10.82}, // ID = 132
	{"Compartimento 2 LV", 1308.47, 1361.32,   10.82}, // ID = 133

	{"Portao Verdant Meadows", 392.13, 2531.27, 16.54}, // ID = 134
	{"Compartimento Verdant Meadows", 291.08, 2525.75, 16.79}, // ID = 135

	{"TestRock", 351.5, 1008.75, 28.4}, // ID = 136
	{"TestCP", 344.75, 1020.5, 28.3}, // ID = 137

	// Rotas para heli by nick
	{"Predio LS", 1545.0536,-1353.3171,329.6541}, // mega suite liu = 138
	{"Depósito Mini City (LV)", 5442.29, 2737.56,   10.50}, // Substituir "Condominio LS" 139
	{"Heli-Ponto Petrobras", 2619.7114,2721.0710,36.7302}, // heliporto petrobras = 140
	{"Policia LV", 2093.4063,2414.5972,74.5786}, // HeliPorto LV ( DP ) = 141
	{"Casino Caligulas" ,2200.6331,1628.2590,55.6922}, // HeliPorto Casino Caligulas = 142
	{"Hospital LV", 1605.0317, 1803.5020, 30.4688}, // HeliPorto ( LV ) Hospital = 143
	{"Area 51(Descarga)",305.0212,1991.6593,17.6406}, // Area 51 ( Descarga de Helis ) = 144
	{"Navio de Cargas(SF)", -2319.0361, 1542.7733, 18.7734}, // Barco com Cargas ( SF ) = 145
	{"Hotel de Luxo(SF)",-2463.9163,117.8880,64.9320}, // Hotel de Luxo em SF = 146
	{"Estacao de trem(SF)" ,-1975.7802,179.2927,27.6875}, // Estacao de trem ( SF ) = 147
	{"Predio SF",-2066.2075,486.0596,139.7422}, // Prédio em SF = 148
	{"Predio Condominio(SF)",-1842.8040,1064.5386,145.1297}, // predio condominio sf = 149
	{"Policia (LS)",1565.25, -1654.83, 28.43}, // dp de ls = 150
	{"Estadio LS" ,2764.1621,-1866.3320,9.7304}, // Estadio LS = 151
	{"Hospital Rota",1161.6819,-1363.4818,26.6502}, // Hospital rota = 152
	{"Armazem Bayside",-2227.1868,2326.6248,7.5469}, // Armazem bayside = 153
	{"Hospital (SF)",-2656.3857,624.9601,66.0938}, // Hospital SF = 154
   	{"Base dos Militares",-1607.7032,288.1910,7.1818}, // Base dos militares = 155

	{"Hospital SF", -2661.8450, 593.0781, 14.2329}, // Hospital SF = 156
    {"Prefeitura SF", -2395.40, 498.65, 29.60}, // Prefeitura SF = 157
    {"Zero SF", -2255.1653, 129.8200, 34.9522},  // ZeroSF = 158
	{"Auto-Escola SF", -2043.5298, -74.2513, 34.9454},  // Auto-EscolaSF = 159
	{"Corpo de Bombeiros (SF)",-2013.4888,67.0350,28.8519}, // Corpo de Bombeiros SF = 160
	{"Wang Cars", -1988.3884,286.2275,34.0579}, // Wang Cars = 161
	{"Policia(SF)",-1608.6486,724.7753,12.1714}, // Policia SF = 162
	{"Bairro Chines(SF)" ,-2239.0447,728.9248,49.0444}, // Bairro Chines = 163
	{"Casino Dizzy(SF)",-2642.0281,1361.3981,6.9296}, // Baixo da ponte em SF. = 164
	{"Otto Autos(SF)" ,-1646.5657,1221.0721,6.8182}, // Otto Autos = 165
	{"Four Dragons",2039.7419,1006.8972,10.4502}, // Four Dragons = 166
	{"Royal Casino",2075.6418,1448.6735,10.4506}, // Royal Casino = 167
	{"Casino Caligulas",2176.8547,1674.9038,10.5994}, // Casino Caligulas = 168
	{"Pirates Mens(LV)",2038.6433,1570.1740,10.4512}, // Pirates Mens [LV] = 169
	{"Shopping (LV)",2038.5256,1344.0573,10.4518}, // Shopping LV = 170
	{"Estacionamento (LV)" ,2317.5181,1530.1643,10.4853}, // Estacionamento LV = 171
	{"Hotel (LV)",2489.0300,1658.9271,10.6005}, // Hotel 1 LV = 172
	{"Ponto Chines (LV)", 2598.1082,1694.0354,10.5998}, // Ponto Chines LV = 173
	{"Estacionamento (LV)" ,2323.3167,1910.8423,8.6665}, // Estacionamento 2 LV = 174
	{"Casino (LV)",2339.3735,2169.0237,10.5068}, // Casino LV [Sem Nome] 1 = 175
	{"Ponto de Lojas(LV)",2105.0215,2219.2051,10.5988}, // Varias Lojas. = 176
	{"Prefeitura (LV)",2435.3440,2379.4890,10.5990}, // Embaixada Americana LV = 177
	{"Policia (LV)",2298.0393,2421.3723,10.5990}, // Policia LV = 178
	{"Ammu Nation (LV)",2611.2432,2086.2603,10.5985}, // Ammu Nation LV = 179
	{"Hotel (LV)",2823.6494,2209.5229,10.5953}, // Hotel 2 LV = 180
	{"Mercadão (LV)",2910.4453,2321.8987,10.4504}, // Mercadão LV = 181
	{"Rock Hotel (LV)",2634.9211,2347.8994,10.4502}, // Rock Hotel = 182
	{"Estadio Base-Ball",1309.9188,2055.0850,10.4506}, // Estadio de Base-bal = 183
	{"Hospital (LV)",1624.2302,1850.1892,10.5985}, // Hospital LV = 184
	{"Aeroporto (LV)",1715.2297,1465.4004,10.4646}, // Aeroporto LV = 185
	{"Aeroporto (SF)",-1417.3231,-303.2910,13.8316}, // Aeroporto SF = 186
	{"Estacionamento Aeroporto (SF)",-1414.9719,-325.1689,5.8205}, // Aeroporto SF Estacionamento = 187
	{"Estadio SF",-2123.2290,-362.1259,34.9984}, // Estadio SF = 188
	{"Corpo de Bombeiros(LS)",1752.2161,-1446.1757,13.0842}, // Corpo de Bombeiros LS = 189
	{"Hospital (LS)",2003.3811,-1444.7998,13.2889}, // Hospital LS 1 = 190
	{"Hotel (LS)",2223.2427,-1151.2579,25.5205}, // Hotel Jefferson = 191
	{"Ammu-Nation (LS)",1361.1602,-1283.6879,13.0968}, // Ammu-Nation LS = 192
	{"Saints Generals (LS)",1191.7095,-1324.0533,13.1255}, // Hospital 2 [Saints Generals] = 193
	{"Shopping (LS)",1135.2720,-1568.8386,13.0338}, // Shopping LS = 194
	{"Cinema (LS)",1316.1414,-1709.2622,13.1099}, // Cinema LS = 195
	{"Prefeitura (LS)",1480.9764,-1739.5758,13.2740}, // Prefeitura LS = 196
	{"Policia (LS)",1535.2622,-1674.3986,13.1099}, // Policia LS = 197
	{"Grove Street",2486.4651,-1682.7950,13.0617}, // Grove Street = 198
	{"Shop XXX",1947.4886,-2123.7644,13.2734}, // Shop XXX = 199
	{"Aeroporto (LS)",1684.1071,-2251.1858,13.1183}, // Aeroporto LS = 200
	{"Praia Santa Maria (LS)",324.5158,-1810.0468,4.1938}, // Praia de Santa Maria. = 201
	// ----------------------- Outros locais ---------------------------
    {"Petrolifera (LS)", 5264.78, -1736.41, 9.32}, // Petrolifera = 202
    {"Petrolifera (SF)", -5559.91, -1228.43, 14.22}, // Petrolifera = 203
    {"Porto Mini City (LV)", 7582.12, 1753.16,    0.59}, // ID = 204 - BARCOS
	{"Posto Palomino", 3530.20, -277.33,    6.25}, //id 205
    {"Posto Texaco BR 153 (SF)", -5792.35, 9440.38, 12.26}, // ID 206                      ** NOVO
    {"Ferro Velho (LV)", 5005.10, 4622.63, 11.10}, // ID = 207
    {"Porto (LV)", 7579.11, 1876.70, 10.27}, // ID = 208
    {"Posto Shell BR 153 (SF)", -5303.54,11765.93,15.12}, // ID = 209                       **  NOVO
	{"Petrobras Deposito (SF)",  -3574.72, -771.73, 14.80}, // ID = 210
	{"Posto Petrobras BR 153 (SF)",  -6839.79, 3481.46, 10.42}, // ID = 211               ** NOVO
	{"Posto Decas", 3404.07, -756.25, 7.62}, // ID = 212
 	{"Posto BR 163 (SF)", -8212.81,14399.34, 13.05}, // ID = 213                          ** NOVO
	{"Porto Mini City (LV)", 7505.67, 1820.18,   10.27}, //ID 214 = NOVO (FLUIDOS)
	{"Aeroporto Santos Dumont", -4339.74, 12874.83, 13.09}, // ID = 215 // HELI PONTO
	{"Aeroporto Santos Dumont", -4365.09, 12771.81, 11.58}, // ID = 216
	{"Posto BR 153", -6794.12, 7006.37, 16.19}, // ID = 217
    {"Deposito Aeroporto (LS)", 1999.31, -2238.04, 13.27}, // bau 218
    {"Deposito Aeroporto (LS)", 2101.32, -2415.85, 13.27}, // bau 219
    {"Posto Condominio Pedreira (LS)", 1107.05, -5700.18, 9.97}, // fluidos 220
    {"Heliponto Mini City (LV)", 6288.27, 2406.64,   13.02}, // HELIPONTO - 221
    {"Deposito Aeroporto (LV)", 1667.19, 1640.22, 10.54}, // bau ID 222
    {"Deposito Aeroporto (LV)", 1349.96, 1763.50, 10.54}, // bau = 223
    {"Deposito Brasal (LV)", 2897.74, 2176.43, 10.72}, // bau = 224
    {"SLR Logistica (LV)", 2296.6433, 2792.3967, 10.8203}, // ID = 225  bau
    {"Borracharia (LV)", 1639.05, 2190.21, 10.54}, // ID = 226 bau
    {"Estadio Baseball (LV)", 1490.29, 2149.36, 10.54}, // ID 227
    {"Deposito Aeroporto (SF)", -1284.50, -631.08, 13.87}, // ID = 228
    {"Deposito Aeroporto (SF)", -1474.58, -631.83, 13.87}, // ID 229
    {"Brasal Combustiveis",  2873.29, 2136.75, 10.50},//id 230
    {"Serralheria (LS)", 1204.11, 512.66, 19.53}, // id 231
    {"Ceasa Deserto (LV)", -1547.18, 2178.74, 52.46}, // id 232
    {"Monte Chiliad",   -2312.06, -1617.97, 483.77}, // id 233
    {"Petrobras (LS)", 5572.91, -7025.16, 7.56}, // id 234         NOVO
    {"Extracao de Petroleo (LS)", 4001.86, -4760.43, 7.96}, // id 235  (PETROBRAS LS)
    {"Petroquimica (SF)", -8596.70, 13805.95, 13.17}, // id 236    NOVA
   	{"Posto Porto City (LV)", 5391.80, 2429.99,   12.60}, // id 237
    {"Texaco (LS)", 2970.78, -1524.09,   12.86}, // Substituir Fallen Tree - 238
    {"Ceasa (LS)", -268.78, -1386.46, 14.41}, // id 239
    {"Petroquimica Whesttone", -674.44, -5495.82, 2.82}, // id 240
    {"Petroquimica Cargas Whesttone", 786.87, -5307.65, 2.82}, // id 241
    {"Posto Petroquimica Whesttone", -1343.27, -3292.98, 18.28}, // id 242
    {"Posto MAV", -50.37, 4187.95, 7.81}, // id 243
    {"Deposito MAV", -13.73, 4346.32, 7.44}, // id 244
    {"Posto City MAV", -562.64, 6707.32, 7.50}, // id 245
    {"Industria MAV", -214.79, 5708.60, 7.84}, // id 246
    {"Deposito Industria MAV", -247.25, 5895.80, 7.84}, // id 247
    {"Deposito Porto City LV 1", 7688.15, 3275.39, 10.36}, // id 248         * NOVO *
    {"Deposito Porto City LV 2", 7584.23, 3276.77, 10.36}, // id 249                 * NOVO *
    {"Hidreletrica (SF)", -9473.07, -285.21, 29.27}, // id 250                 * NOVO *
    {"Usina Nuclear (LV)", 1053.53, 2598.28, 14.02}, // id 251         * NOVO *
    {"Aeroporto MAV Importados", 511.50, 2905.20, 7.20}, // id 252      * REMOVIDO *
    {"Aeroporto MAV Compartimento de Malas", 452.96, 2964.92, 7.22}, // id 253    * REMOVIDO *
    {"Transportadora Verdilog", -1083.66, -969.96, 128.98}, // id 254
    {"Transportadora Verdilog", -1143.05, -971.35, 128.98},  // id 255
    {"Usina Whestone", -3554.64, -1449.18, 6.90}, // id 256 [FLUIDOS]
    {"Usina Whestone", -3515.45, -1386.01, 6.90}, // id 257
    {"Heliponto Usina Whestone", -3508.30, -1400.71, 20.29}, //id 258 [HELIPONTO]
    {"Grove Street", 2737.34, -2002.89, 13.54}, // id 259
    {"Pedreira (SF)", -2945.76, 11441.36, 7.96}, // id 260
    {"Porto Serra Caminhoneiros", -772.90, 3440.38, 6.03},// id 261
    {"Petrobras (SF)", -7150.99, 12206.31, 13.17}, // id 262       NOVA
    {"Fabrica Brahma", -4506.14, 10408.00, 6.63}, // id 263       NOVO
    {"Pedreira (SF)", -2828.19, 11143.06, 6.67}, //id 264         NOVO
    {"Serra dos Caminhoneiros", -632.21, 3087.72,    7.68}, // ID = 265
	{"Armazem (SF)", -1742.59, 1419.04,    6.91}, // ID = 266
	{"Armazem (LV)", 1050.58, 2088.13,   10.82}, // ID = 267
    {"Armazem Angel Pine", -2124.10, -2296.51,   30.35}, // ID = 268
    {"CLMF (LS)", 4020.35,   65.47,   20.89}, // ID = 269
	{"Usina SF", -6700.20, 5144.53,    5.40}, //270
	{"Usina SF", -6735.48, 5134.90,    5.12}, //271
	{"Decas LS Porto ", 3906.82, -692.73,   19.54}, // ID = 272
	{"Terminal Decas", 3342.05, -831.47,    7.65}, // ID = 273
	{"Construcao Decas", 3339.18, -745.45,    7.63}, // ID = 274
	{"Armazem Bluegclry",  111.23, -201.98,    1.15}, // ID = 275
	{"Deposito Bluegclry",  168.10,  -47.05,    1.16}, // ID = 276
	{"Pecas Automotivas",  217.63,   -8.00,    1.79}, // ID = 277
	{"Empresa de Construcao",  320.99,  -52.54,    1.16}, // ID = 278
	{"Posto Montgomery", 1397.94,  455.03,   19.69}, // ID = 279
	{"Armazem Montgomery", 1208.28,  186.20,   20.09}, // ID = 280
	{"Discos Palominiocreek", 2308.09,   85.30,   26.06}, // ID = 281
	{"Oficina Dillimore",  710.17, -448.73,   15.93}, // ID = 282
	{"Correios Dillimore",  799.40, -603.77,   15.93}, // ID = 283
	{"Transportadora Flint County",  -83.93, -1130.87,    0.88}, // ID = 284
	{"Bar Santa Maria Beach",  425.96, -1785.67,    5.34}, // ID = 285
	{"Bar Centro LS", 1585.76, -1414.59, 13.62}, // ID = 286
	{"Balada Idlewood", 1870.19, -1741.98,   13.32}, // ID = 287
	{"Fazenda das Antas (SF)", -4282.41,10153.80,6.87}, // ID = 288            ** NOVO **
	{"Burguer Shot Marina",  786.21, -1603.76,   13.19}, // ID = 289
	{"Posto Mulholland",  994.79, -909.07,   41.98}, // ID = 290
	{"Bar Mulholland", 1023.92, -905.33,   41.98}, // ID = 291
	{"Correios (LV)", 1103.30, 1919.12,   10.62}, // ID = 292
	{"Posto Redsands West", 1610.20, 2225.72,   10.62}, // ID = 293
	{"Auto Pecas", 2400.53, 1040.37, 10.54}, // ID = 294
	{"Consessionaria SF", -1922.16, 304.29, 41.04}, // ID = 295
	{"Auto Parts", 1961.56, 2151.95,   10.62}, // ID = 296
	{"Porto Mini City (LV)", 7526.70, 1988.22,   10.27}, // ID = 297 - NOVO - BAÚ
	{"Oficina Fort Carson",  -87.81, 1112.51,   19.55}, // ID = 298
	{"Terminal Falen Tree", -516.40, -554.49,   25.25}, // ID = 299
	{"Correios (SF)", -1880.34, -142.68,   11.62}, // ID = 300
	{"Loja ZIP (SF)", -1878.06,  859.82,   34.89}, // ID = 301
	{"Contrucao SF", -2333.56,  -77.58,   35.04}, // ID = 302
	{"Deposito Aeroporto SF", -1725.53, -119.55,    3.27}, // ID = 303
    {"Monte Chilliad", -2320.76, -1659.13,  483.54}, // ID = 304
    {"Aeroporto LV", 1646.03, 1608.53,   10.54}, // ID = 305
	{"Petroquimica LV", 2615.29, 6173.48,   11.06}, // ID = 306 - Gasolina
	{"Petroquimica LV", 2888.54, 6192.33,   11.10}, // ID = 307  - Gás
	{"Petroquimica LV", 2800.39, 6277.89,   11.07}, // ID = 308  - Petróleo
	{"Usina LV", 4213.83, 7112.87,   10.95}, // ID = 309  - Diesel
	{"Usina LV", 4369.94, 7127.71,   10.95}, // ID = 310  - Gás
	{"Usina LV", 4313.09, 7011.48,   10.95}, // ID = 311  - Petróleo
	{"Usina LV", 4381.99, 6924.46,   10.96}, // ID = 312    - Gasolina Adtivada
	{"Porto Mini City (LV)", 5987.83, 2371.01,   10.12}, // ID 313 - AVIOES
	{"Pedreira Palomino City", 4935.68,  102.08,    3.72}, //id 314
	{"Construção Palomino", 5440.79, -131.91,    3.89}, //id 315
	{"Frigorifico Friboi", 5511.96, -190.39,    3.99}, //id 316
	{"Petróleo Palomino", 5535.77,   93.19,    3.92}, //id 317
	{"Fábrica Itaipava", 5271.62, -139.15,    3.89}, //id 318
	{"Porto Palomino", 5644.25,  -75.38,    3.84}, //id 319
	{"Bay Side", -2251.86, 2427.25,   -0.75}, // id 320 BARCO
	{"Docas SF", -1760.74, -193.38,   -0.58}, // 321  BARCO
	{"Deposito Usina SF", -6434.56, 4761.02,    5.12}, // 322
	{"Area Militar SF", -1448.50,  495.65,   -0.44}, //323 - Barcos
	{"Ponto Barcos Bone County", -433.77, 1187.25,   -0.15}, //324  BARCOS
	{"Ponto de Taxi", 1166.25, 1415.32,    6.80}, // LV - 325
	{"Ponto de Taxi", 1651.22, -1158.10,   23.84}, // LS - 326
	{"Casino", 2154.72, 2079.20,   10.39}, // Rota Rapida - 327
	{"Sex Shop", 2119.75, 2077.04,   10.39}, // Rota Rapida - 328
	{"Petrolifera Palomino", 8016.31, -215.74,   49.73}, // 329
	{"Pedreira City (LV)", 7887.12, 2718.33,   10.70}, // 330
	{"Posto Pedreira City (LV)", 6497.79, 2589.93,   10.86}, // 331
	{"Industria Palomino", 5868.86,  -48.40,    4.26}, // 332
	{"LVA Deposito Petroquimico", 1271.39, 1030.48, 10.45}, //333
	{"Pedreira (LS)", 420.31, -7601.32, 9.84}, //334
	{"Deposito Petroquimico (LS)", 994.24, 362.19, 30.79}, // 335
    {"Deposito Petroquimico Area 69 (LV)", -71.89, 1723.17, 22.24}, // 336
    {"Ceasa (LV)", 278.37, 441.17, 5.15}, //337
    {"Deposito Toxico (LS)", 1335.63, -6270.43, 9.95}, //338
    {"Ceasa 2 (SF)", -3134.84, -612.90, 9.42},// 339
    {"Armazem Whesttone (SF)", -3469.67,-6908.19, 20.24} // 340
};
// DefLoads - Produtos - Rotas
enum TLoad
{
	LoadName[50],
	bool:Mafia,
	Float:PayPerUnit,
	PCV_Required,
	FromLocations[30],
	ToLocations[30]
}

new const ALoads[][TLoad] =
{
	{"Dummy", false, 0.00, 0, {0}, {0}}, // LoadID 0

	//ROTAS TRAILER CAÇAMBA
	{"Cascalho", false, 2.00, PCV_TruckerOreTrailer, {11, 330, 314, 334, 264}, {1, 2, 3, 4}}, // LoadID 1
	{"Areia", false, 1.90, PCV_TruckerOreTrailer, {12, 260}, {1, 2, 3, 4, 233}}, // LoadID 2
	{"Carvao", false, 2.20, PCV_TruckerOreTrailer, {12, 233, 330, 334, 260}, {6, 7, 8, 203, 214}}, // LoadID 4
	{"Minerio", false, 2.30, PCV_TruckerOreTrailer, {12,330, 314, 264}, {6, 9, 214, 233}}, // LoadID 5
	{"Tora", false, 2.00, PCV_TruckerOreTrailer, {13}, {7, 10}}, // LoadID 6
	{"Madeira serrada", false, 2.00, PCV_TruckerOreTrailer, {10}, {14}}, // LoadID 7
	{"Residuos secos", false, 2.00, PCV_TruckerOreTrailer, {6, 15, 16}, {17, 18, 19}}, // LoadID 8
	{"Detritos", false, 2.00, PCV_TruckerOreTrailer, {17, 19}, {6, 18, 20}}, // LoadID 9
	{"Barro", false, 2.10, PCV_TruckerOreTrailer, {21, 22, 233}, {18, 23, 24, 302}}, // LoadID 10
    {"Entulhos", false, 2.10, PCV_TruckerOreTrailer, {11, 233}, {1, 2, 3, 4, 302, 274}}, //LoadID 11
    {"Pedras", true, 2.10, PCV_TruckerOreTrailer, {11, 12,334, 260}, {233, 302}},
    {"Uranio", true, 1.90, PCV_TruckerOreTrailer, {304, 314,12, 330,334,264}, {269, 257, 240, 329, 271, 338, 251}},
    {"Diamante", true, 2.00, PCV_TruckerOreTrailer, {304, 11, 330,334,264}, {305, 43, 247}},
    {"Rubi", true, 2.40, PCV_TruckerOreTrailer, {12, 314,330,334,264}, {218, 247, 244, 43}},
    {"Ouro", true, 2.20, PCV_TruckerOreTrailer, {12, 233, 314,330,334,260}, {267,268,272,208,244,55,43,47,48,42,54,50,51,53}},
    {"Tijolos", true, 1.60, PCV_TruckerOreTrailer, {332}, {302, 1, 2, 3, 4, 5, 274}},

	//ROTA BARCOS
	{"Peixes", false, 3.0, PCV_Barcos, {204,324}, {320}},
	{"Venenos", false, 3.0, PCV_Barcos, {320}, {321}},
	{"Perolas", false, 3.5, PCV_Barcos, {204}, {321}},
	{"Pedras Preciosas", false, 3.7, PCV_Barcos, {321}, {320,204,324}},
	{"Materiais de Pesca", false, 3.0, PCV_Barcos, {321}, {320}},
	{"Armas", false, 3.2, PCV_Barcos, {321,323}, {204, 324}},
	{"Drogas", false, 3.3, PCV_Barcos, {320,324}, {204}},
	{"Tesouros", false, 3.8, PCV_Barcos, {320,321}, {204,324}},
	{"Materiais Importados", false, 3.2, PCV_Barcos, {204}, {320}},

	//ROTA TRAILER FLUÍDOS
    {"Gasolina Aditivada", true, 2.00, PCV_TruckerFluidsTrailer, {8, 25, 26, 37, 39, 202, 203, 207, 230, 234, 240, 246, 306, 312, 329, 336, 262, 236}, {7, 27, 28, 29, 30, 31, 32, 33, 34, 35, 47, 63, 205, 211,206,209,213,212, 237, 238, 242, 243, 290, 279, 331, 217}},
    {"Tanque Vazio", false, 1.40, PCV_TruckerFluidsTrailer, {8, 25, 26, 230, 234, 235, 240, 329, 317, 262, 236}, {27, 28, 29, 30, 31, 32, 33, 34, 211,206,209,212, 238, 333}}, // LoadID 12
	{"Diesel", true, 2.10, PCV_TruckerFluidsTrailer, {8, 25, 26, 202, 203, 207, 230, 234, 309, 329, 335, 336, 262, 236}, {27, 28, 29, 30, 31, 32, 33, 34, 205, 211,206,209,213,212, 237, 238, 242, 243, 331, 333, 220, 217}}, // LoadID 13
	{"Querosene", true, 2.60, PCV_TruckerFluidsTrailer, {8, 25, 26, 207, 230, 234, 235, 329, 262, 236}, {35, 36, 237, 333}}, // LoadID 14
	{"Oleo cru", false, 1.00, PCV_TruckerFluidsTrailer, {8, 25, 26, 202, 240, 246}, {6, 234}}, // LoadID 14
	{"Nitrogenio Liquido", false, 1.60, PCV_TruckerFluidsTrailer, {37, 38, 202, 306}, {39, 40, 207, 231, 234, 237, 270, 329, 336}}, // LoadID 15
	{"Produtos Quimicos", false, 1.60, PCV_TruckerFluidsTrailer, {37, 202, 203, 234, 256, 271, 317, 329}, {6, 15, 39, 40, 207, 310, 336}}, // LoadID 16
    {"Produtos Toxicos", false, 1.40, PCV_TruckerFluidsTrailer, {6, 26, 37, 234, 240, 246, 257, 271, 329}, {25, 40, 63, 203, 214, 244, 269}},
	{"Agua potavel", false, 2.00, PCV_TruckerFluidsTrailer, {37}, {15, 40, 41}}, // LoadID 17
	{"Graxa", false, 1.80, PCV_TruckerFluidsTrailer, {8, 25, 207, 309}, {333, 6, 10, 14, 42, 202, 203, 234, 244, 270, 329, 336}}, // LoadID 18
	{"Fertilizante", false, 1.30, PCV_TruckerFluidsTrailer, {37, 38}, {21, 22}}, // LoadID 19
	{"Leite", false, 1.50, PCV_TruckerFluidsTrailer, {21, 22}, {43, 44, 45}}, // LoadID 20
	{"Cerveja", true, 1.20, PCV_TruckerFluidsTrailer, {41, 263, 318}, {44, 46}}, // LoadID 21
	{"Etanol", true, 1.80, PCV_TruckerFluidsTrailer, {37, 41}, {26, 39, 40, 237, 331, 220}}, // LoadID 22
    {"Alcool", true, 2.00, PCV_TruckerFluidsTrailer, {37, 41, 202, 203}, {26, 39, 40, 207}}, //LoadID 23
    {"Gas", true, 1.40, PCV_TruckerFluidsTrailer, {265, 256, 246, 240, 203, 25, 26, 271, 307, 310, 332}, {231, 6, 8, 37, 39, 40, 63, 269, 220}},
    {"Petroleo", true, 3.50, PCV_TruckerFluidsTrailer, {202, 203, 207, 230, 235, 240, 256, 265, 308, 311, 262, 236}, {269, 246, 25, 26, 37, 63, 329, 333, 335, 336}},
    {"Gas Natural", true, 2.20, PCV_TruckerFluidsTrailer, {202}, {203}},

	//ROTAS TRAILER BAÚ
	{"Comida", false, 1.60, PCV_TruckerCargoTrailer, {7, 47, 48}, {49, 50, 51, 52, 53, 232, 239, 339, 337, 319, 330, 332}}, // LoadID 24
	{"Bebidas", false, 1.00, PCV_TruckerCargoTrailer, {15, 54, 55}, {49, 50, 51, 52, 53, 232, 330, 332, 340}}, // LoadID 25
	{"Cerveja engarrafada", true, 2.50, PCV_TruckerCargoTrailer, {56, 263}, {57, 58, 59, 60, 61, 332}}, // LoadID 26
	{"Artigos de Luxo", false, 1.00, PCV_TruckerCargoTrailer, {24, 55, 255}, {47, 48, 50, 248}}, // LoadID 27
	{"Eletronicos", true, 1.40, PCV_TruckerCargoTrailer, {7, 24, 48, 219, 272, 297, 255}, {50, 51, 62, 63, 242, 261,139, 319, 249, 250}}, // LoadID 28
	{"Equipamentos esportivos", false, 1.00, PCV_TruckerCargoTrailer, {47, 48, 255}, {50, 53, 57, 261, 249}}, // LoadID 29
	{"Placas", false, 1.00, PCV_TruckerCargoTrailer, {10, 261, 319, 255}, {4, 7, 18, 22, 332, 330, 250, 251}}, // LoadID30
	{"Material de Construcao", false, 1.00, PCV_TruckerCargoTrailer, {4}, {1, 2, 3, 5, 274, 330}}, // LoadID 31
	{"Carga Viva", false, 2.30, PCV_TruckerCargoTrailer, {21, 22, 288}, {23, 43, 47}}, // LoadID 32
	{"Carne", false, 2.10, PCV_TruckerCargoTrailer, {43, 316}, {44, 49, 50, 51, 52, 53, 232, 297}}, // LoadID 33
	{"Papel", false, 1.40, PCV_TruckerCargoTrailer, {14}, {9, 62}}, // LoadID 34
    {"Milho", false, 1.90, PCV_TruckerCargoTrailer, {21, 22, 288}, {44, 45, 47, 38, 23, 232, 239, 337, 339}},//LoadID 35
    {"Importados", false, 2.90, PCV_TruckerCargoTrailer, {218, 222, 223, 244, 255, 247, 261, 272, 303, 319, 292, 248}, {18, 43, 47, 48, 53, 55, 59, 63, 225, 224, 227, 232, 239, 300}},
    {"Armamentos", true, 2.80, PCV_TruckerCargoTrailer, {24, 36, 38, 42, 272}, {63}},
    {"Veneno", false, 1.80, PCV_TruckerCargoTrailer, {48, 38, 267, 268, 266, 47,139, 332}, {244, 18, 19, 21, 22, 37, 42, 55, 64}},
    {"Congelados", false, 1.50, PCV_TruckerCargoTrailer, {43, 47, 48, 55, 244, 139, 316}, {266, 261, 247, 49, 7, 297}},
    {"Pecas Automotivas", true, 1.80, PCV_TruckerCargoTrailer, {303, 284, 276, 272, 265, 261, 244, 218, 222, 7, 38, 47}, {297, 296, 295, 294, 282, 249}},
    {"Transformador", true, 2.60, PCV_TruckerCargoTrailer, {250}, {261, 24, 319, 251}},
    {"Fios de Cobre", true, 2.70, PCV_TruckerCargoTrailer, {250}, {261, 297, 319, 24, 265, 251, 254}},
   // {"Fogos de Artificio", true, 3.10, PCV_TruckerCargoTrailer, {322, 297, 18, 47, 6}, {233, 225, 265}},
   // {"Enfeites Natalinos", false, 3.60, PCV_TruckerCargoTrailer, {319, 297, 284, 261, 249, 208}, {60, 53, 50, 51, 46, 225, 299}},

	//rotas caminhão cimento
	{"Cimento", false, 1.50, PCV_TruckerCementTruck, {12, 330, 314}, {1, 2, 3, 4, 233}}, // LoadID 36
    {"Cal", false, 1.50, PCV_TruckerCementTruck, {12, 330, 314}, {1, 2, 3, 4}},  //LoadID 37

	//rotas caminhões comuns
    {"Legumes", false, 1.80, PCV_TruckerNoTrailer, {21, 22, 43, 45, 49}, {232, 337, 339}},
    {"Verduras", false, 1.50, PCV_TruckerNoTrailer, {21, 22, 40, 44, 45}, {232, 239, 337, 339}},
    {"Frutas", false, 1.90, PCV_TruckerNoTrailer, {21, 22, 40,  43, 47, 48, 49, 55}, {232, 239, 337, 339}},
	{"Comida", false, 1.40, PCV_TruckerNoTrailer, {7, 47, 48}, {49, 50, 51, 52, 53, 232, 233, 239}}, // LoadID 38
	{"Bebidas", false, 1.40, PCV_TruckerNoTrailer, {15, 54, 55, 318}, {49, 50, 51, 52, 53}}, // LoadID 39
	{"Cerveja engarrafada", true, 2.20, PCV_TruckerNoTrailer, {56, 318, 263}, {57, 58, 59, 60, 61}}, // LoadID 40
	{"Artigos de Luxo", false, 1.60, PCV_TruckerNoTrailer, {24, 55, 340, 266, 267}, {47, 48, 50, 248}}, // LoadID 41
	{"Eletronicos", true, 1.60, PCV_TruckerNoTrailer, {7, 24, 48, 139}, {50, 51, 62, 63, 233, 249, 254}}, // LoadID 42
	{"Equipamentos esportivos", false, 1.30, PCV_TruckerNoTrailer, {47, 48, 261, 255}, {50, 53, 57}}, // LoadID 43
	{"Placas", false, 1.20, PCV_TruckerNoTrailer, {10}, {4, 7, 18, 22,  233, 139, 251}}, // LoadID 44
	{"Material de Construcao", false, 1.30, PCV_TruckerNoTrailer, {4}, {1, 2, 3, 5}}, // LoadID 45
	{"Carga Viva", false, 1.40, PCV_TruckerNoTrailer, {21, 22, 288}, {23, 43, 47}}, // LoadID 46
	{"Carne", false, 1.80, PCV_TruckerNoTrailer, {43, 316}, {44, 49, 50, 51, 52, 53}}, // LoadID 47
	{"Papel", false, 1.10, PCV_TruckerNoTrailer, {14}, {9, 62}}, // LoadID 48
    {"Milho", false, 1.30, PCV_TruckerNoTrailer, {21, 22, 288}, {44, 45, 47, 38, 23, 232, 239}}, //LoadID 49
    {"Congelados", false, 1.50, PCV_TruckerNoTrailer, {43, 47, 48, 55, 244, 139, 316}, {266, 261, 247, 49, 7, 297}},
    {"Importados", true, 2.60, PCV_TruckerNoTrailer, {218, 222, 223, 244, 247, 261, 255, 272, 303, 319, 292, 340, 248},{18, 43, 47, 48, 53, 55, 59, 63, 225, 224, 227, 232, 239, 300}},
    {"Tijolos", false, 1.50, PCV_TruckerNoTrailer, {332}, {302, 1, 2, 3, 4, 5, 274}},
    {"Trilhos", false, 1.50, PCV_TruckerNoTrailer, {332}, {18}},
    {"Ferramentas", false, 1.60, PCV_TruckerNoTrailer, {297, 47, 255}, {302, 334, 2, 5, 10}},
    {"Moveis e Eletrodomesticos", false, 1.80, PCV_TruckerNoTrailer, {297, 225, 7, 47, 255}, {18, 50, 51}},

	//rotas aviões
    {"Estrangeiros", false, 1.00, PCV_PilotPlane, {121, 122, 130, 216}, {126, 125, 134}}, // LoadID 50
    {"Idosos", false, 1.00, PCV_PilotPlane, {126, 125, 134}, {121, 122, 130}}, // LoadID 51
    {"Politicos", false, 1.00, PCV_PilotPlane, {130, 131, 134}, {125, 126, 121, 122}}, // LoadID 52
    {"Passageiros", false, 1.00, PCV_PilotPlane, {122, 126, 131}, {134, 216}}, // LoadID 64
    {"Malas", false, 1.00, PCV_PilotPlane, {124, 132, 133, 216}, {127, 128, 129, 135, 313}}, // LoadID 65
    {"Importados", false, 1.10, PCV_PilotPlane, {127, 128, 135, 129, 313}, {123, 124, 132, 133}}, // LoadID 66

	//rotas helicopteros
	{"Doentes", false, 1.00, PCV_PilotHelicopter, {149, 155}, {154, 152, 143}}, // LoadID 67
	{"Policiais", false, 1.00, PCV_PilotHelicopter, {155}, {150, 141}}, // LoadID 68
    {"Trabalhadores", false, 1.00, PCV_PilotHelicopter, {145, 153}, {144, 155, 215}}, // LoadID 69
    {"Medicos", false, 1.00, PCV_PilotHelicopter, {152, 121, 125}, {154, 143, 144, 258}}, // LoadID 70
    {"Turistas", false, 1.00, PCV_PilotHelicopter, {122, 126, 131}, {215, 146, 148, 147, 142, 138}}, // LoadID 71

	//Rotas MAFIA
	{"Maconha", true, 1.30, PCV_MafiaVan, {47, 299, 244, 246, 332, 272, 261}, {49, 50, 51, 52, 53, 259, 280, 276, 263}}, // LoadID 53
	{"Cocaina", true, 1.30, PCV_MafiaVan, {15, 54, 55, 284, 261}, {49, 50, 51, 52, 53, 259, 287, 286, 285, 332, 319}}, // LoadID 54
	{"Armas", true, 1.50, PCV_MafiaVan, {56, 299, 272, 261}, {57, 58, 59, 60, 61, 259, 284}}, // LoadID 55
	{"Granadas", true, 1.40, PCV_MafiaVan, {24, 55, 276, 284, 192, 179, 272}, {47, 48, 50, 291, 261}}, // LoadID 56
	{"Heroina", true, 1.40, PCV_MafiaVan, {7, 24, 48, 247, 261}, {50, 51, 62, 63, 259}}, // LoadID 57
	{"Caximbos", true, 1.50, PCV_MafiaVan, {47, 55, 259, 266, 267, 268, 275, 280}, {50, 53, 57}}, // LoadID 58
	{"Fumo", true, 1.20, PCV_MafiaVan, {10, 266, 267, 268, 275, 280}, {18, 22, 259, 263, 261, 272}}, // LoadID 59
	{"Oxi", true, 1.30, PCV_MafiaVan, {4, 284, 198, 299}, {1, 2, 3, 5, 285, 287}}, // LoadID 60
	{"Trevo", true, 1.50, PCV_MafiaVan, {21, 22}, {23, 43, 47, 259}}, // LoadID 61
	{"Extase", true, 1.50, PCV_MafiaVan, {43, 259, 299}, {44, 49, 50, 51, 52, 53, 265, 272, 225}}, // LoadID 62
	{"Cigarros", true, 1.50, PCV_MafiaVan, {14, 275, 270, 268, 259}, {9, 62, 214, 266, 267, 263, 225}} // LoadID 63

};  */


// Sistema de Rotas NOVO
#define MAX_ROTAS   150
#define MAX_LOCAIS  350

forward ObterRotas();
enum TLocation
{
	LocationName[50],
	Float:LocX,
	Float:LocY,
	Float:LocZ,
    MySQL_LocationID,
    Text3D:LocalText
};
new ALocations[MAX_LOCAIS][TLocation];

enum TLoad
{
	LoadName[50],
	bool:Mafia,
	Float:PayPerUnit,
	PCV_Required,
	FromLocations[75],
    bool:fLo[75],       // Confirmar
	ToLocations[75],
    bool:tLo[75],       // Confirmar
    MySQL_LoadID,
    LoadTime        // Tempo para expirar
};
new ALoads[MAX_ROTAS][TLoad];

public ObterRotas() {
    new Cache:q, tmp = GetTickCount();
    for(new i = 0; i < MAX_ROTAS; i++) {
        ALoads[i][MySQL_LoadID] = ALoads[i][LoadName] = ALoads[i][PCV_Required] = 0;
        for(new x = 0; x < 75; x++) {
            ALoads[i][FromLocations][x] = ALoads[i][ToLocations][x] = 0;
            ALoads[i][fLo][x] = ALoads[i][tLo][x] = false;
        }
        ALoads[i][Mafia] = false;
        ALoads[i][PayPerUnit] = 0.0;
    }
    for(new i = 0; i < MAX_LOCAIS; i++) {
        ALocations[i][MySQL_LocationID] = ALocations[i][LocationName] = 0;
        ALocations[i][LocX] = ALocations[i][LocY] = ALocations[i][LocZ] = 0.0;
        if(IsValidDynamic3DTextLabel(ALocations[i][LocalText])) {
            DestroyDynamic3DTextLabel(ALocations[i][LocalText]);
            ALocations[i][LocalText] = Text3D:INVALID_3DTEXT_ID;
        }
    }
    // Carregando Locais
    q = mysql_query(getConexao(), "SELECT * FROM rotas_locais ORDER BY id ASC", true);
    if(cache_num_rows() > 0) {
        for(new i = 0; i < cache_num_rows(); i++) {
            static Coordenadas[50];
            cache_get_value_name(i, "nome", ALocations[i+1][LocationName], 100);
            cache_get_value_name_int(i, "id", ALocations[i+1][MySQL_LocationID]);
            cache_get_value_name(i, "XYZ", Coordenadas, 100);
            unformat(Coordenadas, "p<,>fff", ALocations[i+1][LocX],ALocations[i+1][LocY],ALocations[i+1][LocZ]);
            if(!IsValidDynamic3DTextLabel(ALocations[i+1][LocalText]))
                ALocations[i+1][LocalText] = CreateDynamic3DTextLabel(ALocations[i+1][LocationName], 0xFF000060, ALocations[i+1][LocX],ALocations[i+1][LocY],ALocations[i+1][LocZ], 15.0);
            //printf("[LOCAL %i] %s %s [mysql %i]", i+1, ALocations[i+1][LocationName], Coordenadas, ALocations[i+1][MySQL_LocationID]);
        }
    }
    cache_delete(q);
    // Carregando Rotas
    q = mysql_query(getConexao(), "SELECT * FROM rotas WHERE expirar=0 OR expirar > UNIX_TIMESTAMP() ORDER BY id ASC", true);
    if(cache_num_rows() > 0) {
        for(new i = 0; i < cache_num_rows(); i++) {
            static Carregamentos[150], Descarregamentos[150];
            cache_get_value_name(i, "produto", ALoads[i][LoadName], 100);
            cache_get_value_name_float(i, "valor", ALoads[i][PayPerUnit]);
            cache_get_value_name_int(i, "mafia", ALoads[i][Mafia]);
            cache_get_value_name_int(i, "carga", ALoads[i][PCV_Required]);
            cache_get_value_name_int(i, "id", ALoads[i][MySQL_LoadID]);
            cache_get_value_name(i, "carregamentos", Carregamentos, 150);
            cache_get_value_name(i, "descarregamentos", Descarregamentos, 150);
            unformat(Carregamentos, "p<|>a<i>[75]", ALoads[i][FromLocations]);
            unformat(Descarregamentos, "p<|>a<i>[75]", ALoads[i][ToLocations]);
            cache_get_value_name_int(i, "expirar", ALoads[i][LoadTime]);
            //printf("[ROTA %i] %s [%s] > [%s] [mysql %i]", i, ALoads[i][LoadName], Carregamentos, Descarregamentos, ALoads[i][MySQL_LoadID]);
        }
    }
    cache_delete(q);
    //////////////////////////////////
    printf("Rotas carregadas tempo demorado: %i ms", GetTickCount() - tmp);
    //////////////////////////////////
    tmp = GetTickCount();
    for(new rota = 0; rota < sizeof(ALoads); rota++) {
        if(ALoads[rota][MySQL_LoadID] == 0) break;
        for(new ponto = 0; ponto < 75; ponto++) {
            if(ALoads[rota][FromLocations][ponto] != 0 && ALoads[rota][fLo][ponto] != true) {
                for(new local = 1; local < sizeof(ALocations); local++) {
                    if(ALocations[local][MySQL_LocationID] == 0) break;
                    if(ALocations[local][MySQL_LocationID] == ALoads[rota][FromLocations][ponto]) {
                        ALoads[rota][FromLocations][ponto] = local;
                        ALoads[rota][fLo][ponto] = true;
                        break;
                    }
                }
            }
            if(ALoads[rota][ToLocations][ponto] != 0 && ALoads[rota][tLo][ponto] != true) {
                for(new local = 1; local < sizeof(ALocations); local++) {
                    if(ALocations[local][MySQL_LocationID] == 0) break;
                    if(ALocations[local][MySQL_LocationID] == ALoads[rota][ToLocations][ponto]) {
                        ALoads[rota][ToLocations][ponto] = local;
                        ALoads[rota][tLo][ponto] = true;
                        break;
                    }
                }
            }
        }
    }
    // O que acima faz? converte o ID do MySQL para o ID do Slot obtido.
    printf("Rotas alocadas tempo demorado: %i ms", GetTickCount() - tmp);
    return 1;
}

hook OnGameModeInit()
{
	ObterRotas();

	return 1;
}


Product_GetList(PCV_Needed, &NumProducts)
{
	new ProductList[50];
	for (new i; i < sizeof(ALoads); i++)
	{
        if (NumProducts < 50)
		{
			if (ALoads[i][PCV_Required] == PCV_Needed)
			{
                ProductList[NumProducts] = i;
				NumProducts++;
			}
		}
	}
	return ProductList;
}
Product_GetRandom(PCV_Needed)
{
	new ProductList[50], NumProducts = 0;
	ProductList = Product_GetList(PCV_Needed, NumProducts);
	return ProductList[random(NumProducts)];
}
Product_GetRandomStartLoc(ProductID)
{
	new NumProducts = 0;
	for (new i=0; i < 75; i++)
	{
        if ((ALoads[ProductID][FromLocations][i] != 0) && (ALoads[ProductID][fLo][i] == true))
		    NumProducts++;
		else
		    break;
	}
	return ALoads[ProductID][FromLocations][random(NumProducts)];
}
Product_GetRandomEndLoc(ProductID)
{
    new NumProducts = 0;
	for (new i=0; i < 75; i++)
	{
		if ((ALoads[ProductID][ToLocations][i] != 0) && (ALoads[ProductID][tLo][i] == true))
            NumProducts++;
		else
		    break;
	}
	return ALoads[ProductID][ToLocations][random(NumProducts)];
}

enum TRandomBonusMission
{
	RandomLoad,
	RandomStartLoc,
	RandomEndLoc,
	bool:MissionFinished
}
new RandomBonusMission[TRandomBonusMission];

TodasRotas(playerid, pag) {
    new Cache:qr, str[1000], Query[128];
    new cc[][] = {"Trailer Caçamba", "Trailer Fluídos", "Trailer Baú", "Caminhão de Cimento", "Caminhão Comum", "Aviões", "Helicóptero", "Mafia", "Barcos"};
    mysql_format(getConexao(), Query, sizeof(Query), "SELECT produto,carga FROM rotas ORDER BY id ASC LIMIT %i,25", pag);
    qr =  mysql_query(getConexao(), Query, true);
    strcat(str, "Rota\tCarga\n");
    for(new i = 0; i < cache_num_rows(); i++) {
        new Produto[64], carga;

        cache_get_value_name_int(i, "carga", carga);
        cache_get_value_name(i, "produto", Produto, 64);
        format(str, sizeof(str), "%s%s\t%s\n", str, Produto, cc[carga-1]);
    }
    if(cache_num_rows() >= 25)
        strcat(str, "{FFFF00}Próxima página\n");
    ShowPlayerDialog(playerid, TodasRotas, DIALOG_STYLE_TABLIST_HEADERS, "{FF0000}# {FFFFFF}Rotas", str, "Selecionar", "Cancelar");
    return cache_delete(qr);
}
/*TodosLocais(playerid, pag) {
    new Cache:qr, Query[128], str[1000];
    mysql_format(getConexao(), Query, sizeof(Query), "SELECT nome FROM rotas_locais ORDER BY id ASC LIMIT %i,40", pag);
    qr = mysql_query(getConexao(), Query, true);
    for(new i; i < cache_num_rows(); i++) {
        new NomeLocal[64];
        cache_get_value_name(i, "nome", NomeLocal, 64);
        format(str, sizeof(str), "%s%s\n", str, NomeLocal);
    }
    if(cache_num_rows() >= 40)
        strcat(str, "\n{FFFF00}Próxima página");
    ShowPlayerDialog(playerid, ApagarRotaLocal, DIALOG_STYLE_LIST, "{FFFF00}# {FFFFFF}Apagar local de rota:", str, "Selecionar", "Cancelar");
    return cache_delete(qr);
}*/