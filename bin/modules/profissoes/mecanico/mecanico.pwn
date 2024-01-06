#include <YSI_Coding\y_hooks>
#include <VCF>

#define	VALOR_CADA_PECA 30

enum RepararVehicle
{
	Grana,
	Pecas
}
new 
	RVehicle[MAX_PLAYERS][RepararVehicle]
;

hook OnGameModeInit()
{
	// Carros Blueberry
	call::JOB->SetVehicleJob(CreateVehicle(525, 1595.1973, -2159.0459, 13.4312, 89.4450, -1, -1, TIME_VEHICLE_SPAWN), MECANICO);
	call::JOB->SetVehicleJob(CreateVehicle(525, 1595.2180, -2163.7651, 13.4347, 90.1318, -1, -1, TIME_VEHICLE_SPAWN), MECANICO);
	call::JOB->SetVehicleJob(CreateVehicle(525, 1595.2214, -2168.4360, 13.4281, 89.9248, -1, -1, TIME_VEHICLE_SPAWN), MECANICO);
	call::JOB->SetVehicleJob(CreateVehicle(525, 1583.0228, -2158.6980, 13.3923, 268.5335, -1, -1, TIME_VEHICLE_SPAWN), MECANICO);
	call::JOB->SetVehicleJob(CreateVehicle(525, 1582.9304, -2163.4866, 13.4312, 268.9530, -1, -1, TIME_VEHICLE_SPAWN), MECANICO);

	CreateDynamic3DTextLabel("Menu do Mecanico\nAperte a tecla: {"COR_AMARELO_INC"}'Y'", COR_BRANCO, 1566.5634, -2161.7891, 13.5547, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 8.0); // Blueberry
	CreateDynamic3DTextLabel("Menu do Mecanico\nAperte a tecla: {"COR_AMARELO_INC"}'Y'", COR_BRANCO, 1893.7612,-1575.0468,14.4309, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 8.0); // Los Santos
	
	CreateDynamic3DTextLabel("Local de Reparação\nDigite: {"COR_AMARELO_INC"}/Reparar", COR_BRANCO, 1567.4285,-2154.6431,13.5532, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 8.0); // Los Santos
	CreateDynamic3DTextLabel("Local de Reparação\nDigite: {"COR_AMARELO_INC"}/Reparar", COR_BRANCO, 1909.3612,-1569.2059,14.4309, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 8.0); // Los Santos
	CreateDynamic3DTextLabel("Local de Reparação\nDigite: {"COR_AMARELO_INC"}/Reparar", COR_BRANCO, 1917.7090,-1568.8857,14.4309, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 8.0); // Los Santos

	new tmpobjid;
    tmpobjid = CreateDynamicObject(11387, 1891.449707, -1581.380126, 16.790300, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 12855, "cunte_cop", "sw_bars", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 5, 13363, "cephotoblockcs_t", "sw_wall_05", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 6, 12855, "cunte_cop", "sw_PDground", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 7, 1569, "adam_v_doort", "ws_guardhousedoor", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 11, 13363, "cephotoblockcs_t", "sw_wall_05", 0x00000000);
    tmpobjid = CreateDynamicObject(18981, 1924.244140, -1589.876831, 1.017400, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18981, 1924.246826, -1564.889160, 1.014299, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18981, 1924.347656, -1549.787475, 0.931330, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1922.135131, -1601.895996, 13.002779, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1917.143066, -1601.906127, 13.002779, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1914.171752, -1601.920532, 12.596758, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1924.256713, -1601.937011, 12.596758, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1919.158569, -1602.046752, 12.571298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1905.761962, -1602.152343, 12.596758, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18981, 1892.776611, -1602.157836, 1.017400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18981, 1880.334960, -1602.115112, 1.017400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1868.281005, -1602.141479, 12.596758, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1900.968139, -1602.069824, 12.571298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1891.388061, -1602.081420, 12.571298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1881.767700, -1602.090820, 12.571298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1872.774536, -1602.047241, 12.571298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1859.447875, -1602.246337, 12.596758, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1834.127563, -1602.221191, 13.036800, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(11326, 1862.403076, -1564.960937, 15.812108, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6282, "beafron2_law2", "shutter03LA", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 4, 13363, "cephotoblockcs_t", "sw_wall_05", 0x00000000);
    tmpobjid = CreateDynamicObject(18762, 1859.479125, -1590.397338, 12.596758, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1859.486816, -1593.234863, 12.596798, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1859.513305, -1598.163208, 12.596798, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1859.511962, -1600.208129, 12.596798, 0.000000, 90.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1859.389404, -1586.336791, 12.596758, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1831.993652, -1602.200439, 12.596758, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18981, 1911.426757, -1559.897338, 0.907400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1844.480224, -1602.230346, 12.571298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1837.258789, -1602.239624, 12.571298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1859.564697, -1597.044189, 12.571298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1859.531494, -1595.643920, 12.571298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1924.380249, -1596.835937, 12.571298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1924.401367, -1587.258178, 12.571298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1924.392944, -1577.670043, 12.571298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1924.412597, -1568.066650, 12.571298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1924.412353, -1558.443237, 12.571298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1924.394531, -1548.848144, 12.571298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1924.381347, -1542.672729, 12.571298, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1924.349243, -1538.038574, 12.596758, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1839.027832, -1602.221191, 13.036800, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1843.668457, -1602.221191, 13.036800, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1848.479248, -1602.221191, 13.036800, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1853.289550, -1602.221191, 13.046798, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1854.075317, -1602.250000, 12.571298, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18981, 1893.626342, -1559.897338, 0.907400, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18762, 1856.620239, -1602.221191, 13.046798, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10811, "airportbits_sfse", "brckwhtwash128", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1438, 1835.117675, -1598.966796, 12.949013, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1438, 1838.338012, -1600.157714, 12.949013, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(920, 1841.356079, -1600.765747, 12.960102, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(920, 1841.356079, -1599.775390, 12.960102, 0.000000, 0.000000, -45.900005, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1042, 1835.488159, -1601.105712, 12.758028, 0.000000, 14.599994, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1893.187377, -1559.240112, 13.221300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19447, 1902.487304, -1559.240112, 13.221300, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4835, "airoads_las", "ws_carparkwall1", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(11389, 1907.394775, -1572.062866, 16.560499, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(13591, 1839.955078, -1592.116088, 13.179598, 0.000000, 0.000000, 35.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(13591, 1849.726806, -1585.474121, 13.179598, 0.000000, 0.000000, 35.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(13591, 1846.959228, -1595.250854, 13.179598, 0.000000, 0.000000, 35.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(13591, 1852.923706, -1596.631469, 13.179598, 0.000000, 0.000000, 35.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(12957, 1854.416381, -1589.930786, 13.435770, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18248, 1847.702148, -1581.286987, 18.119310, 0.000000, 0.000000, 339.827331, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(11359, 1911.110961, -1581.153686, 15.580928, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(11359, 1891.251708, -1567.557983, 15.530928, 0.000000, 0.000000, -90.000030, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6282, "beafron2_law2", "shutter03LA", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19899, 1907.641845, -1563.608886, 13.430930, 0.000000, 0.000000, -90.099967, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19899, 1903.601074, -1563.602416, 13.430930, 0.000000, 0.000000, -90.099967, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(11292, 1837.686157, -1599.169555, 13.933798, 0.000000, 0.000000, 178.999969, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 14794, "ab_vegasgymmain", "mp_CJ_SHEET2", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 13363, "cephotoblockcs_t", "sw_wall_05", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 2, 10839, "aircarpkbarier_sfse", "cratetop128", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 3, 13363, "cephotoblockcs_t", "sw_wall_05", 0x00000000);
    tmpobjid = CreateDynamicObject(19899, 1921.282714, -1563.632080, 13.430930, 0.000000, 0.000000, -90.099967, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(11393, 1902.101196, -1576.619140, 14.856200, 0.000000, 0.000000, -88.599891, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(5474, 1931.648437, -1577.570312, 12.359398, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 4, 10811, "airportbits_sfse", "brckwhtwash128", 0x00000000);
    tmpobjid = CreateDynamicObject(1280, 1893.721923, -1587.231445, 14.000928, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1280, 1897.752441, -1587.231445, 14.000928, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1778, 1899.788452, -1586.736328, 13.610926, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1238, 1904.303222, -1587.141357, 13.740924, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1238, 1904.953857, -1587.141357, 13.740924, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1238, 1905.694458, -1587.141357, 13.740924, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(2691, 1906.879394, -1582.782226, 14.340917, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 5114, "beach_las2", "ganggraf04_LA", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19325, 1887.772705, -1576.391967, 15.290933, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 5134, "wasteland_las2", "mural05_LA", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1432, 1888.835205, -1573.281250, 13.430925, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1432, 1884.964355, -1574.601196, 13.430925, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3594, 1863.544677, -1562.241088, 13.599786, 16.200002, 0.000000, 114.299972, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(3594, 1867.172729, -1561.620239, 13.220546, 4.000002, -2.499996, 111.899879, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1571, 1922.008056, -1594.289428, 14.585849, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 915, "airconext", "CJ_plating", 0x00000000);
    tmpobjid = CreateDynamicObject(1498, 1921.505493, -1596.230712, 13.310539, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(1151, 1834.271972, -1600.823730, 13.137784, 0.000000, 0.000000, 51.399993, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1185, 1837.530517, -1599.907958, 12.727781, 0.000000, 0.000000, 15.800001, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19377, 1911.401977, -1565.101318, 12.639048, 0.000000, 89.199958, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19377, 1918.351318, -1565.101318, 12.736088, 0.000000, 89.199958, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11388, 1907.706054, -1572.078979, 20.200199, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11390, 1907.696777, -1571.921508, 17.918699, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1217, 1841.197998, -1598.232666, 13.127780, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1440, 1845.877563, -1591.574829, 13.054300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1440, 1856.982421, -1581.353271, 12.845140, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(852, 1856.892822, -1568.159301, 12.819250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(852, 1852.461791, -1570.693847, 12.819250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1472, 1858.711425, -1587.627563, 12.583458, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1472, 1858.726318, -1589.106933, 12.583458, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3174, 1843.773925, -1581.558349, 12.428890, 0.000000, 0.000000, 97.400260, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1440, 1841.508422, -1585.867065, 13.054300, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19817, 1919.299804, -1570.058959, 12.470668, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19817, 1911.298339, -1570.058959, 12.470668, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19903, 1905.725830, -1565.623901, 13.430930, 0.000000, 0.000000, -61.899990, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(10282, 1917.973144, -1566.926269, 14.400810, 0.000000, 0.000000, -88.499900, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1726, 1900.981323, -1575.559814, 13.276450, 0.000000, 0.000000, -90.699981, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19815, 1900.721435, -1563.069946, 14.987918, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19815, 1900.851562, -1563.140014, 14.987918, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(616, 1928.152709, -1562.004516, 8.828148, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(616, 1928.152709, -1594.494262, 8.828148, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1439, 1880.245971, -1559.836791, 13.480027, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19621, 1907.876342, -1563.647949, 14.829738, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19621, 1908.146606, -1563.647949, 14.829738, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19621, 1908.486938, -1563.647949, 14.829738, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(616, 1922.152343, -1553.264648, 8.828148, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(616, 1910.052124, -1553.264648, 8.828148, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(616, 1898.641845, -1553.264648, 8.828148, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1439, 1878.536254, -1559.836791, 13.480027, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1439, 1881.955688, -1559.836791, 13.480027, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1438, 1872.225463, -1563.983154, 13.138443, 0.000000, -6.799998, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1438, 1872.225463, -1566.597412, 13.014002, 0.000000, 4.799997, 105.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3302, 1871.768920, -1570.434448, 13.331570, -6.400002, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(12957, 1876.423950, -1567.346191, 14.075259, 0.000000, 0.000000, 47.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19917, 1874.505615, -1568.165649, 13.319284, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1428, 1881.712890, -1584.779541, 14.772795, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1521, 1881.342651, -1582.467773, 14.523408, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1521, 1881.072387, -1580.357543, 14.523408, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1244, 1881.855590, -1578.377197, 14.210823, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1244, 1881.855590, -1577.126708, 13.820819, 90.000000, 0.000000, -15.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1346, 1864.353027, -1586.605102, 14.715076, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2125, 1920.107055, -1593.261596, 13.699037, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2125, 1920.107055, -1594.081542, 13.699037, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2125, 1920.107055, -1594.911865, 13.699037, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2125, 1920.107055, -1595.802368, 13.699037, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1756, 1914.314331, -1582.176757, 13.294108, 0.000000, 1.399999, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(917, 1907.119018, -1586.468261, 13.561901, 0.000000, 0.000000, 59.699996, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(926, 1907.145019, -1585.675170, 13.621244, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1450, 1907.277343, -1584.744018, 14.006123, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19996, 1907.670776, -1581.937011, 13.329005, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2165, 1897.880371, -1573.986816, 13.405628, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1714, 1896.624145, -1574.812744, 13.369942, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2596, 1901.191284, -1576.625732, 16.035167, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19917, 1901.629272, -1563.725708, 13.314929, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1226, 1923.818115, -1582.656738, 17.040937, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1226, 1906.967407, -1582.656738, 17.040937, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1226, 1891.347290, -1582.656738, 17.040937, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1886, 1891.347900, -1587.015747, 17.854003, 17.099996, 0.000000, 79.700012, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1886, 1903.678955, -1587.052368, 17.915670, 11.900002, 0.000000, -71.400001, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1886, 1890.583984, -1570.189819, 17.883939, 11.200000, 0.000000, -98.399955, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2606, 1899.401977, -1580.880371, 15.513441, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11743, 1900.341186, -1580.520751, 14.133949, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2222, 1899.550537, -1580.350708, 14.244519, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3504, 1892.246582, -1561.860595, 14.757174, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3504, 1893.637451, -1561.860595, 14.757174, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3504, 1869.177001, -1586.409423, 14.757174, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3504, 1867.786865, -1586.409423, 14.757174, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(935, 1904.875488, -1580.434082, 13.970927, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(935, 1906.125122, -1580.434082, 13.970927, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(935, 1905.814819, -1579.333251, 13.970927, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1431, 1906.069702, -1578.148925, 13.860927, 0.000000, 0.000000, -19.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(922, 1922.970214, -1576.948730, 14.282578, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(922, 1895.299072, -1572.465820, 14.267923, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(943, 1892.132324, -1572.142822, 13.720929, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 

	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	RemoveBuildingForPlayer(playerid, 5515, 1931.648, -1577.570, 12.359, 0.250);
    RemoveBuildingForPlayer(playerid, 5517, 1883.523, -1576.445, 20.195, 0.250);
    RemoveBuildingForPlayer(playerid, 5634, 1931.312, -1574.843, 16.460, 0.250);
    RemoveBuildingForPlayer(playerid, 740, 1887.195, -1565.898, 9.781, 0.250);
    RemoveBuildingForPlayer(playerid, 740, 1863.312, -1568.648, 11.773, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 1870.257, -1602.804, 12.781, 0.250);
    RemoveBuildingForPlayer(playerid, 1308, 1831.890, -1600.312, 12.304, 0.250);
    RemoveBuildingForPlayer(playerid, 645, 1835.140, -1600.179, 12.656, 0.250);
    RemoveBuildingForPlayer(playerid, 5476, 1883.523, -1576.445, 20.195, 0.250);
    RemoveBuildingForPlayer(playerid, 5474, 1931.648, -1577.570, 12.359, 0.250);
    RemoveBuildingForPlayer(playerid, 5630, 1928.492, -1575.968, 20.554, 0.250);

    return 1;
}

hook OnPlayerDisconnect(playerid, reason)
{
	call::MECANICO->CancelarServico(playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid, 1.5, 1566.5634, -2161.7891, 13.5547) || IsPlayerInRangeOfPoint(playerid, 1.5, 1893.7612,-1575.0468,14.4309) && (Jogador[playerid][Profissao] == MECANICO))
		{
			if(RVehicle[playerid][Pecas] >= 21)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem o limite de peças.");
            
            if(Jogador[playerid][Profissao] != MECANICO)
                return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem permissão.");

			ShowPlayerDialog(playerid, Menu_Mecanico, DIALOG_STYLE_INPUT, "* Loja de Peças | preço: {088A08}R$"#VALOR_CADA_PECA" cada", "Digite o número de peças a serem compradas.", "Comprar", "Fechar");
		}
		return true;
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

function MECANICO::CancelarServico(playerid)
{
	new id = Jogador[playerid][ReparandoVeiculo];
	new r[RepararVehicle], t[StateVehicle];
	RVehicle[playerid] = r, State[id] = t;
	return true;
}

timer Fix_PlayerInVehicleCheck[3000](playerid) {

    if(IsPlayerInAnyVehicle(playerid)) {

        TogglePlayerControllable(playerid, true);
        RemovePlayerFromVehicle(playerid);
        SendClientMessage(playerid, -1, "[SERVER]: Please do not exploit this again.");
        TogglePlayerControllable(playerid, false);
    }
}

CMD:consertar(playerid, params[])
{
    if ( Jogador[playerid][Profissao] == MECANICO)
    {    
        //if ( !call::JOB->IsPlayerInWorking(playerid) )
        //{
        //    SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");
        //    return 1;
        //}
        /*else if( !IsPlayerInRangeOfPoint(playerid, 1.5, 1567.4285,-2154.6431,13.5532) || !IsPlayerInRangeOfPoint(playerid, 1.5, 1909.3612,-1569.2059,14.4309) || !IsPlayerInRangeOfPoint(playerid, 1.5, 1917.7090,-1568.8857,14.4309))
        {
            SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está na área adequada de reparo!");
            return 1;
        }*/
        if(IsPlayerInAnyVehicle(playerid))
        {
            SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando dentro de um veículo.");
            return 1;
        }
        else if(GetPVarType(playerid, "FixVehicleTimer"))
        {
            return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já está reparando um veículo!");
        }
        else
        {
            new closestcar = GetClosestCar(playerid);

            if(IsPlayerInRangeOfVehicle(playerid, closestcar, 5.0))
            {
                new engine,lights,alarm,doors,bonnet,boot,objective;
                GetVehicleParamsEx(closestcar,engine,lights,alarm,doors,bonnet,boot,objective);
                if(!IsABike(closestcar) && !IsAPlane(closestcar)) {
                    if(bonnet == VEHICLE_PARAMS_OFF || bonnet == VEHICLE_PARAMS_UNSET)
                    {
                        SendClientMessage(playerid, COR_ERRO, "| ERRO | O capô do veículo precisa estar aberto para fazer o conserto!");
                        return 1;
                    }
                }
                SetTimerEx("FixVehicle", 15000, false, "ii", playerid, closestcar);
                SetPVarInt(playerid, "FixVehicleTimer", SetTimerEx("FixVehicle", 15000, false, "ii", playerid, closestcar));
                TogglePlayerControllable(playerid, 0);
                ApplyAnimation(playerid, "MISC", "Plunger_01", 4.1, 1, 1, 1, 1, 1, 1);
                SendClientMessage(playerid, COR_DISABLE, "| CONSERTO | {ffffff}Você iniciou um conserto.");

                defer Fix_PlayerInVehicleCheck(playerid);
            }
            else return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está próximo a um veículo.");
        }
    }
    else SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é um(a) Mecânico(a).");
    return 1;
}


forward FixVehicle(playerid, vehicleid);
public FixVehicle(playerid, vehicleid)
{
    TogglePlayerControllable(playerid, 1);
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
    ClearAnimationsEx(playerid);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
    //PlayerInfo[playerid][pMechTime] = gettime()+60;
    SetVehicleHealth(vehicleid, 1000.0);
    RepairVehicle(vehicleid);
    //Vehicle_Armor(vehicleid);
    new engine,lights,alarm,doors,bonnet,boot,objective;
    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(GetVehicleModel(vehicleid) == 481 && GetVehicleModel(vehicleid) == 509 && GetVehicleModel(vehicleid) == 510)
    {
        SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
        //arr_Engine{vehicleid} = 1;
    }
    SendClientMessage(playerid, COR_VERDE, "Você concluiu o reparo do veículo.");
    DeletePVar(playerid, "FixVehicleTimer");
}

/*CMD:reparar(playerid) 
{
    
    if ( Jogador[playerid][Profissao] != MECANICO)
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão Mecânico.");

    if ( !call::JOB->IsPlayerInWorking(playerid) )
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando.");

    if(IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode usar este comando dentro de um veiculo.");

    //if(!PlayerToPoint(playerid, 2.0, 1567.4285,-2154.6431,13.5532) || !PlayerToPoint(playerid, 2.0, 1909.3612,-1569.2059,14.4309) || !PlayerToPoint(playerid, 2.0, 1917.7090,-1568.8857,14.4309))
    //    return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está no local de reparação.");
    
    new id = InRangeOfAnyCar(playerid);
    if(id == INVALID_VEHICLE_ID )
        return SendClientMessage(playerid, COR_ERRO, "Você não esta perto de nenhum veiculo.");

    if ( call::CONCE->IsValidVehicleConce(id))
        return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode reparar esse veiculo."); 

    if(IsVehicleInRangeOfPoint(id, 5.0, 1567.4285,-2154.6431,13.5532) || IsVehicleInRangeOfPoint(id, 5.0, 1909.3612,-1569.2059,14.4309) || IsVehicleInRangeOfPoint(id, 5.0, 1917.7090,-1568.8857,14.4309))
    {
        Jogador[playerid][ReparandoVeiculo] = id;
        ShowDialogMenuMechanic(playerid, id);
        
        GetVehicleDoorsDamageStatus(id, State[id][Doors][0], State[id][Doors][1], State[id][Doors][2], State[id][Doors][3]);
        GetVehicleLightsDamageStatus(id, State[id][Lights][0], State[id][Lights][1], State[id][Lights][2], State[id][Lights][3]);
        GetVehicleTiresDamageStatus(id, State[id][Tires][0], State[id][Tires][1], State[id][Tires][2], State[id][Tires][3]);
        return true;
    }

    return true;
}
*/
CMD:mecanicos(playerid, params[])
{
	new str[1045], count;
	foreach(new i: Player)
	{
		if ( Jogador[i][Profissao] == MECANICO )
		{
			format(str, sizeof(str), "%s[%d] - {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}\n", str, i, GetUserName(i));
			count++;
		}
	}
	if(count)
		return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "LISTA DE MECÂNICOS", str, "OK", "");

	SendClientMessage(playerid, COR_ERRO, "Não há nenhum Mecânico online.");
	return true;
}

ShowDialogMenuMechanic(playerid, vehicleid) 
{
	new DialogStr[100] = "Componente\tEstado\nPortas\nRodas\nFarois\nCapo\t";

	if(GetDoorState(vehicleid, VCF_DOOR_HOOD) == VCF_DOOR_FIXED)
		strcat(DialogStr, "Fixado\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_HOOD) == VCF_DOOR_OPENED)
		strcat(DialogStr, "Aberto\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_HOOD) == VCF_DOOR_DAMAGED)
		strcat(DialogStr, "Quebrado\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_HOOD) == VCF_DOOR_REMOVED)
		strcat(DialogStr, "Faltando\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_HOOD) == VCF_DOOR_OPENED_DAMAGED)
		strcat(DialogStr, "Quebrado e Aberto\n");

	strcat(DialogStr, "Porta-Malas\t");

	if(GetDoorState(vehicleid, VCF_DOOR_TRUNK) == VCF_DOOR_FIXED)
		strcat(DialogStr, "Fixado\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_TRUNK) == VCF_DOOR_OPENED)
		strcat(DialogStr, "Aberto\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_TRUNK) == VCF_DOOR_DAMAGED)
		strcat(DialogStr, "Quebrado\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_TRUNK) == VCF_DOOR_REMOVED)
		strcat(DialogStr, "Faltando\n");

	strcat(DialogStr, "Concluir\t");

	ShowPlayerDialog(playerid, MENU_MECHANIC_COMPONENTS, DIALOG_STYLE_TABLIST_HEADERS, "Menu do mecanico", DialogStr, "Selecionar", "Sair");

	return true;
}

ShowMenuMechanicDoors(playerid, vehicleid) 
{
	new DialogStr[100] = "Componente\tEstado\nPorta Esquerda\t";

	if(GetDoorState(vehicleid, VCF_DOOR_DRIVER) == VCF_DOOR_FIXED)
		strcat(DialogStr, "Fixado\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_DRIVER) == VCF_DOOR_OPENED)
		strcat(DialogStr, "Aberto\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_DRIVER) == VCF_DOOR_DAMAGED)
		strcat(DialogStr, "Quebrado\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_DRIVER) == VCF_DOOR_REMOVED)
		strcat(DialogStr, "Faltando\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_DRIVER) == VCF_DOOR_OPENED_DAMAGED)
		strcat(DialogStr, "Aberta e Quebrada\n");

	strcat(DialogStr, "Porta Direita\t");

	if(GetDoorState(vehicleid, VCF_DOOR_PASSENGER) == VCF_DOOR_FIXED)
		strcat(DialogStr, "Fixado\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_PASSENGER) == VCF_DOOR_OPENED)
		strcat(DialogStr, "Aberto\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_PASSENGER) == VCF_DOOR_DAMAGED)
		strcat(DialogStr, "Quebrado\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_PASSENGER) == VCF_DOOR_REMOVED)
		strcat(DialogStr, "Faltando\n");
	else if(GetDoorState(vehicleid, VCF_DOOR_PASSENGER) == VCF_DOOR_OPENED_DAMAGED)
		strcat(DialogStr, "Aberta e Quebrada\n");

	ShowPlayerDialog(playerid, MENU_MECHANIC_DOORS, DIALOG_STYLE_TABLIST_HEADERS, "Menu do Mecanico", DialogStr, "Selecionar", "Voltar");
	
	return true;
}

ShowMenuMechanicTires(playerid, vehicleid) 
{
	new DialogStr[150] = "Pneu\tEstado\nDianteiro Esquerda\t";

	if( IsTireInflated(vehicleid, VCF_TIRE_FRONT_LEFT) )
		strcat(DialogStr, "Inflado\n");
	else
		strcat(DialogStr, "Furado\n");

	strcat(DialogStr, "Dianteiro Direito\t");

	if( IsTireInflated(vehicleid, VCF_TIRE_FRONT_RIGHT) )
		strcat(DialogStr, "Inflado\n");
	else
		strcat(DialogStr, "Furado\n");

	strcat(DialogStr, "Traseiro Esquerdo\t");

	if( IsTireInflated(vehicleid, VCF_TIRE_REAR_LEFT) )
		strcat(DialogStr, "Inflado\n");
	else
		strcat(DialogStr, "Furado\n");

	strcat(DialogStr, "Traseiro Direito\t");

	if( IsTireInflated(vehicleid, VCF_TIRE_REAR_RIGHT) )
		strcat(DialogStr, "Inflado\n");
	else
		strcat(DialogStr, "Furado\n");

	ShowPlayerDialog(playerid, MENU_MECHANIC_TIRES, DIALOG_STYLE_TABLIST_HEADERS, "Menu do Mecanico", DialogStr, "Selecionar", "Voltar");

	return true;
}

ShowMenuMechanicLights(playerid, vehicleid)
{
	new DialogStr[150] = "Pneu\tEstado\nDianteiro Esquerdo\t";

	if(IsLightEnabled(vehicleid, VCF_LIGHT_FRONT, VCF_LIGHT_LEFT))
		strcat(DialogStr, "Fixado\n");
	else
		strcat(DialogStr, "Quebrado\n");

	strcat(DialogStr, "Dianteiro Direito\t");

	if(IsLightEnabled(vehicleid, VCF_LIGHT_FRONT, VCF_LIGHT_RIGHT))
		strcat(DialogStr, "Fixado\n");
	else
		strcat(DialogStr, "Quebrado\n");

	strcat(DialogStr, "Traseiro Esquerdo\t");

	if(IsLightEnabled(vehicleid, VCF_LIGHT_BACK, VCF_LIGHT_LEFT))
		strcat(DialogStr, "Fixado\n");
	else
		strcat(DialogStr, "Quebrado\n");

	strcat(DialogStr, "Traseiro Direito\t");

	if(IsLightEnabled(vehicleid, VCF_LIGHT_BACK, VCF_LIGHT_RIGHT))
		strcat(DialogStr, "Fixado\n");
	else
		strcat(DialogStr, "Qubrado\n");

	ShowPlayerDialog(playerid, MENU_MECHANIC_LIGHTS, DIALOG_STYLE_TABLIST_HEADERS, "Menu do Mecnaido", DialogStr, "Selecionar", "Voltar");
	return true;
}

Dialog:MENU_MECHANIC_TIRES(playerid, response, listitem, inputtext[]) 
{
	if(!response)
		return ShowDialogMenuMechanic(playerid, Jogador[playerid][ReparandoVeiculo]);

	switch(listitem) 
	{
		case 0: 
		{
			if(RVehicle[playerid][Pecas] <= 0)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

			new id = Jogador[playerid][ReparandoVeiculo];
			if( IsTireInflated(id, VCF_TIRE_FRONT_LEFT) ) 
				return SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");

			ToogleTireState(id, VCF_TIRE_FRONT_LEFT);
			SendClientMessage(playerid, COR_AVISO, "O pneu dianteiro esquerdo do veiculo %d foi reparado.", id);
			RVehicle[playerid][Pecas] -= 1, RVehicle[playerid][Grana] += random(280, 150);
			ShowDialogMenuMechanic(playerid, id);
		}
		case 1: 
		{
			if(RVehicle[playerid][Pecas] <= 0)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

			new id = Jogador[playerid][ReparandoVeiculo];
			if( IsTireInflated(id, VCF_TIRE_FRONT_RIGHT) ) 
				return SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");

			ToogleTireState(id, VCF_TIRE_FRONT_RIGHT);
			SendClientMessage(playerid, COR_AVISO, "O pneu dianteiro direito do veiculo %d foi reparado.", id);
			RVehicle[playerid][Pecas] -= 1, RVehicle[playerid][Grana] += random(280, 150);
			ShowDialogMenuMechanic(playerid, id);

		}
		case 2: 
		{
			if(RVehicle[playerid][Pecas] <= 0)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

			new id = Jogador[playerid][ReparandoVeiculo];
			if( IsTireInflated(id, VCF_TIRE_REAR_LEFT) ) 
				return SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");

			ToogleTireState(id, VCF_TIRE_REAR_LEFT);
			SendClientMessage(playerid, COR_AVISO, "O pneu traseiro esquerdo do veiculo %d foi reparado.", id);
			RVehicle[playerid][Pecas] -= 1, RVehicle[playerid][Grana] += random(280, 150);
			ShowDialogMenuMechanic(playerid, id);

		}
		case 3: 
		{
			if(RVehicle[playerid][Pecas] <= 0)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

			new id = Jogador[playerid][ReparandoVeiculo];
			if( IsTireInflated(id, VCF_TIRE_REAR_RIGHT) ) 
				return SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");

			ToogleTireState(id, VCF_TIRE_REAR_RIGHT);
			SendClientMessage(playerid, COR_AVISO, "O pneu traseiro direito do veiculo %d foi reparado.", id);
			RVehicle[playerid][Pecas] -= 1, RVehicle[playerid][Grana] += random(280, 150);
			ShowDialogMenuMechanic(playerid, id);

		}
	}
	return true;

}

Dialog:MENU_MECHANIC_DOORS(playerid, response, listitem, inputtext[]) 
{
	if(!response)
		return ShowDialogMenuMechanic(playerid, Jogador[playerid][ReparandoVeiculo]);

	switch(listitem)
	{
		case 0:
		{
			if(RVehicle[playerid][Pecas] <= 0)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

			new id = Jogador[playerid][ReparandoVeiculo];
			if(GetDoorState(id, VCF_DOOR_DRIVER) != VCF_DOOR_FIXED) 
			{
				SetDoorState(id, VCF_DOOR_DRIVER, VCF_DOOR_FIXED);
				SendClientMessage(playerid, COR_AVISO, "A porta direita do veiculo %d foi reparada.", id);
				RVehicle[playerid][Pecas] -= 1, RVehicle[playerid][Grana] += random(450, 250);
				ShowDialogMenuMechanic(playerid, id);
			} else 
				SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");
		}
		case 1: 
		{
			if(RVehicle[playerid][Pecas] <= 0)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

			new id = Jogador[playerid][ReparandoVeiculo];
			if(GetDoorState(id, VCF_DOOR_PASSENGER) != VCF_DOOR_FIXED) 
			{
				SetDoorState(id, VCF_DOOR_PASSENGER, VCF_DOOR_FIXED);
				SendClientMessage(playerid, COR_AVISO, "A porta direita do veiculo %d foi reparada.", id);
				RVehicle[playerid][Pecas] -= 1, RVehicle[playerid][Grana] += random(450, 250);
				ShowDialogMenuMechanic(playerid, id);
			} else 
				SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");
		}
	}
	return true;
}

Dialog:MENU_MECHANIC_LIGHTS(playerid, response, listitem, inputtext[])
{
	if(!response)
		return ShowDialogMenuMechanic(playerid, Jogador[playerid][ReparandoVeiculo]);

	switch(listitem)
	{
		case 0:
		{
			if(RVehicle[playerid][Pecas] <= 0)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

			new id = Jogador[playerid][ReparandoVeiculo];
			if(IsLightEnabled(id, VCF_LIGHT_FRONT, VCF_LIGHT_LEFT))
				return SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");

			ToogleLightState(id, VCF_LIGHT_FRONT, VCF_LIGHT_LEFT);
			SendClientMessage(playerid, COR_AVISO, "O farol dianteiro esquerdo do veiculo %d foi reparado.", id);
			RVehicle[playerid][Pecas] -= 1, RVehicle[playerid][Grana] += random(150, 50);
			ShowDialogMenuMechanic(playerid, id);
		}
		case 1:
		{
			if(RVehicle[playerid][Pecas] <= 0)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

			new id = Jogador[playerid][ReparandoVeiculo];
			if(IsLightEnabled(id, VCF_LIGHT_FRONT, VCF_LIGHT_RIGHT))
				return SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");

			ToogleLightState(id, VCF_LIGHT_FRONT, VCF_LIGHT_RIGHT);
			SendClientMessage(playerid, COR_AVISO, "O farol dianteiro direito do veiculo %d foi reparado.", id);
			RVehicle[playerid][Pecas] -= 1, RVehicle[playerid][Grana] += random(150, 50);
			ShowDialogMenuMechanic(playerid, id);
		}
		case 2:
		{
			if(RVehicle[playerid][Pecas] <= 0)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

			new id = Jogador[playerid][ReparandoVeiculo];
			if(IsLightEnabled(id, VCF_LIGHT_BACK, VCF_LIGHT_LEFT))
				return SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");

			ToogleLightState(id, VCF_LIGHT_BACK, VCF_LIGHT_LEFT);
			SendClientMessage(playerid, COR_AVISO, "O farol traseiro esquerdo do veiculo %d foi reparado.", id);
			RVehicle[playerid][Pecas] -= 1, RVehicle[playerid][Grana] += random(150, 50);
			ShowDialogMenuMechanic(playerid, id);
		}
		case 3:
		{
			if(RVehicle[playerid][Pecas] <= 0)
				return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

			new id = Jogador[playerid][ReparandoVeiculo];
			if(IsLightEnabled(id, VCF_LIGHT_BACK, VCF_LIGHT_RIGHT))
				return SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");

			ToogleLightState(id, VCF_LIGHT_BACK, VCF_LIGHT_RIGHT);
			SendClientMessage(playerid, COR_AVISO, "O farol traseiro direito do veiculo %d foi reparado.", id);
			RVehicle[playerid][Pecas] -= 1, RVehicle[playerid][Grana] += random(150, 50);
			ShowDialogMenuMechanic(playerid, id);
		}
	}
	return true;
}

Dialog:MENU_MECHANIC_COMPONENTS(playerid, response, listitem, inputtext[]) {

	if(response)
	{
		switch(listitem)
		{
			case 0: // mostrar dialog portas
			{
				ShowMenuMechanicDoors(playerid, Jogador[playerid][ReparandoVeiculo]);
			}
			case 1: // mostrar dialog rodas
			{
				ShowMenuMechanicTires(playerid, Jogador[playerid][ReparandoVeiculo]);
			}
			case 2: // mostrar dialog farois
			{
				ShowMenuMechanicLights(playerid, Jogador[playerid][ReparandoVeiculo]);
			}
			case 3: // capo
			{
				if(RVehicle[playerid][Pecas] <= 0)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

				new id = Jogador[playerid][ReparandoVeiculo];
				if(GetDoorState(id, VCF_DOOR_HOOD) != VCF_DOOR_FIXED) 
				{
					SetDoorState(id, VCF_DOOR_HOOD, VCF_DOOR_FIXED);
					SendClientMessage(playerid, COR_AVISO, "O capô do veiculo %d foi reparado.", id);
					RVehicle[playerid][Pecas] -= 2, RVehicle[playerid][Grana] += random(380, 180);
					ShowDialogMenuMechanic(playerid, id);
				} else 
					SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");
			}
			case 4: // porta-malas
			{
				if(RVehicle[playerid][Pecas] <= 0)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

				new id = Jogador[playerid][ReparandoVeiculo];
				if(GetDoorState(id, VCF_DOOR_TRUNK) != VCF_DOOR_FIXED) 
				{
					SetDoorState(id, VCF_DOOR_TRUNK, VCF_DOOR_FIXED);
					SendClientMessage(playerid, COR_AVISO, "O porta-malas do veiculo %d foi reparado.", id);
					RVehicle[playerid][Pecas] -= 2, RVehicle[playerid][Grana] += random(500, 150);
					ShowDialogMenuMechanic(playerid, id);
				} else 
					SendClientMessage(playerid, COR_ERRO, "Você não pode reparar uma peça já reparada.");
			}
			case 5: // conclusão
			{
				if(RVehicle[playerid][Pecas] <= 4)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem peças suficientes.");

				if(RVehicle[playerid][Grana] <= 0)
					return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está reparando o veiculo para concluir sua reparação.");

				new vehicleid = Jogador[playerid][ReparandoVeiculo], id = GetPlayerIDByName(Vehicle[vehicleid][Owner][Name]);

				SetPVarInt(id, "MecanicoID", playerid), SetPVarInt(id, "MecSolicitado", 1), SetPVarInt(id, "DinheiroReparo", RVehicle[playerid][Grana]);


				SendClientMessage(playerid, COR_AVISO, "* Você está reparando o veiculo de: %s aguarde-o a aceitar o conserto.", GetUserName(id));
				SendClientMessage(id, COR_BRANCO, "* O(A) Mecânico {"COR_VERDE_INC"}%s{"COR_BRANCO_INC"} consertou seu veiculo e ficou no valor de: {"COR_VERDE_INC"}R$%s{"COR_BRANCO_INC"}.", GetUserName(playerid), RealStr(RVehicle[playerid][Grana]));
				SendClientMessage(id, COR_BRANCO, "* Use: /aceitar conserto ou /recusar conserto.");
			}
			default: SendClientMessage(playerid, COR_ERRO, "Você cancelou a reparação do veículo."), call::MECANICO->CancelarServico(playerid);
		}
	}
	return true;
}

Dialog:Menu_Mecanico(playerid, response, listitem, inputtext[])
{
	if(response)
	{
		if ( isnull(inputtext) || !IsNumeric(inputtext))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você tem que digitar um número válido.");

		new pecas = strval(inputtext);

		if(pecas <= 0 || pecas >= 21)
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você só pode digitar valores entre 1 e 20.");

		if( (VALOR_CADA_PECA * pecas) > GetPlayerMoney(playerid))
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro suficiente.");

		GivePlayerMoney(playerid, -(VALOR_CADA_PECA * pecas) );
		RVehicle[playerid][Pecas] += strval(inputtext);

		SendClientMessage(playerid, COR_BRANCO, "* Você comprou {"COR_AMARELO_INC"}%d{"COR_BRANCO_INC"} Peças no valor de {088A08}R$%s{"COR_BRANCO_INC"}.", pecas, RealStr(VALOR_CADA_PECA * pecas));
	}
	return true;
}

stock GetClosestCar(iPlayer, iException = INVALID_VEHICLE_ID, Float: fRange = Float: 0x7F800000) {

    new
        iReturnID = INVALID_VEHICLE_ID,
        Float: fVehiclePos[4];

    for(new i = 1; i <= MAX_VEHICLES; ++i) if(GetVehicleModel(i) && i != iException) {
        GetVehiclePos(i, fVehiclePos[0], fVehiclePos[1], fVehiclePos[2]);
        if((fVehiclePos[3] = GetPlayerDistanceFromPoint(iPlayer, fVehiclePos[0], fVehiclePos[1], fVehiclePos[2])) < fRange) {
            fRange = fVehiclePos[3];
            iReturnID = i;
        }
    }
    return iReturnID;
}

stock IsPlayerInRangeOfVehicle(playerid, vehicleid, Float:range)
{
    if(vehicleid < 0 || vehicleid > MAX_VEHICLES) return 0;
    new Float:v_Pos[3];
    GetVehiclePos(vehicleid, v_Pos[0], v_Pos[1], v_Pos[2]);
    if(IsPlayerInRangeOfPoint(playerid, range, v_Pos[0], v_Pos[1], v_Pos[2])) return 1;
    return 0;
}

stock IsAPlane(carid2)
{
    new carid = GetVehicleModel(carid2);
    if(carid == 592 || carid == 577 || carid == 511 || carid == 512 || carid == 593 || carid == 520 || carid == 553 || carid == 476 || carid == 519 || carid == 460 || carid == 513) return 1;
    return 0;
}

stock ClearAnimationsEx(playerid)
{
    ClearAnimations(playerid);
    new sid = GetPlayerSkin(playerid);
    SetPlayerSkin(playerid, sid);

    return 1;
}