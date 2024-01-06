#include <YSI_Coding\y_hooks>

static 
	PlayerText:FirePTD[MAX_PLAYERS];



enum e_BOMBEIRO
{
	CompanheiroId,
	bool:Working,
	FireObject,
	FireLife,
	Time,
	WorkVehicle,
	WorkHouse,
	Pay
}
static Bombeiro[MAX_PLAYERS][e_BOMBEIRO];

forward ApagandoFogo(playerid);

hook OnGameModeInit()
{
    // SF
	call::JOB->SetVehicleJob(CreateVehicle(407, -2064.6946, 51.4032, 28.7446, 272.2909, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(407, -2064.8955, 56.9623, 28.7467, 271.3896, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(407, -2064.9619, 69.2078, 28.6338, 271.5610, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(407, -2064.9824, 75.0724, 28.6269, 269.8289, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(407, -2064.9470, 80.2984, 28.6256, 270.4295, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(407, -2064.9607, 86.1980, 28.6250, 269.9244, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(407, -2064.7776, 91.6433, 28.6270, 269.0984, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(407, -2064.7151, 97.4238, 28.6248, 264.1002, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
	call::JOB->SetVehicleJob(CreateVehicle(407, -2064.8779, 63.5667, 28.6859, 269.1982, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
    // LS
    call::JOB->SetVehicleJob(CreateVehicle(407, 2343.8481,-1368.5393,24.2497,180.3391, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
    call::JOB->SetVehicleJob(CreateVehicle(407, 2349.5520,-1368.4418,24.2525,179.1509, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
    call::JOB->SetVehicleJob(CreateVehicle(407, 2355.1958,-1368.5491,24.2597,180.5371, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
    // LV
    call::JOB->SetVehicleJob(CreateVehicle(544, 1770.2406,2075.4634,11.0548,179.1410, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
    call::JOB->SetVehicleJob(CreateVehicle(544, 1764.1517,2075.0442,11.0580,181.9221, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
    call::JOB->SetVehicleJob(CreateVehicle(544, 1757.4657,2075.4839,11.0596,181.7867, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
    call::JOB->SetVehicleJob(CreateVehicle(544, 1751.3210,2074.5691,11.0549,182.7374, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);
    call::JOB->SetVehicleJob(CreateVehicle(544, 1742.0278,2075.5869,11.0513,243.2994, 3, 3, TIME_VEHICLE_SPAWN), BOMBEIRO);

	new tmpobjid;
    tmpobjid = CreateDynamicObject(19462, 2315.773925, -1340.963867, 24.823993, -0.000007, -0.000014, -179.921554, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2320.666503, -1336.237304, 24.823993, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2330.296875, -1336.238769, 24.823993, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2330.701660, -1336.241455, 24.823993, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2335.421386, -1341.142822, 24.823993, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2335.444824, -1344.824951, 24.823993, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2335.457519, -1354.452636, 24.823993, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19443, 2334.575195, -1359.180908, 24.827283, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2333.860351, -1354.278564, 24.823993, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2331.064453, -1364.280273, 24.823993, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2331.052734, -1354.647949, 24.823993, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2324.589843, -1369.005615, 24.823993, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19443, 2330.183105, -1369.007568, 24.812883, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2319.856933, -1364.097656, 24.823993, -0.000007, -0.000014, -179.921554, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2320.506347, -1359.365234, 24.823993, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2315.771484, -1354.464599, 24.823993, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2320.508300, -1345.869873, 24.823993, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2320.490722, -1349.560791, 24.823993, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2318.122558, -1348.617431, 24.823993, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19392, 2332.424804, -1358.583496, 25.815412, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19370, 2326.497558, -1343.748291, 31.833951, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19370, 2321.771484, -1342.060791, 31.833951, -0.000007, -0.000014, -179.921554, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19370, 2323.457519, -1340.544677, 31.833951, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19370, 2326.665527, -1340.546630, 31.833951, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19370, 2328.183105, -1342.240478, 31.833951, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19370, 2323.292480, -1343.749755, 31.833951, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2315.773437, -1340.964355, 28.320190, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2320.507812, -1345.869628, 28.320322, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2315.783203, -1346.426025, 28.320190, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2315.769042, -1354.464111, 28.320190, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2320.489746, -1349.561279, 28.320322, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2320.506347, -1359.364746, 28.320322, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2320.910156, -1364.273437, 27.169170, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2325.823242, -1369.004394, 27.167642, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2330.544921, -1364.103759, 27.169170, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2330.531738, -1354.475830, 27.169170, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2325.804199, -1359.352783, 28.320322, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2329.397949, -1358.585449, 28.320322, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2330.526367, -1354.448242, 28.320190, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2320.669921, -1336.237060, 28.320322, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2330.297851, -1336.236083, 28.320322, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2330.701171, -1336.238525, 28.320322, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2335.460937, -1354.452636, 28.320190, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19443, 2334.575195, -1359.181152, 28.315540, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2333.859863, -1354.282226, 28.320190, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2335.445312, -1344.825439, 28.320190, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19462, 2335.434082, -1341.040771, 28.320190, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2330.363769, -1369.011962, 22.334241, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19449, 2320.493164, -1359.383789, 22.333692, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2315.755859, -1354.481933, 22.333692, -0.000007, -0.000014, -179.921554, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2315.736816, -1340.935546, 22.333692, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2318.920898, -1349.578857, 22.333692, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2318.932128, -1345.839111, 22.333692, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2319.833984, -1364.282958, 22.333692, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2324.746093, -1369.011718, 22.333692, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2331.071777, -1364.108398, 22.333692, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2330.749511, -1359.209716, 22.333692, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2335.470214, -1354.306640, 22.333692, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2320.630859, -1336.208251, 22.333692, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2330.262695, -1336.207519, 22.333692, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2335.454101, -1344.672363, 22.333692, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2330.705566, -1336.215332, 22.333692, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2317.102539, -1354.266845, 26.483900, -0.000007, 90.003181, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2318.914062, -1347.708251, 26.482532, 0.000014, 89.999992, 89.988952, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2320.181152, -1357.967285, 26.482532, 0.000014, 89.999992, 89.988952, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2317.161132, -1341.152343, 26.483900, -0.000007, 89.999984, -179.928451, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2330.705566, -1336.215332, 22.333692, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2333.731445, -1355.785644, 22.333692, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2324.602050, -1363.839843, 26.490543, -0.000014, 269.999633, -90.015914, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2320.516113, -1354.185791, 29.997869, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2320.520507, -1343.692626, 29.997869, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2320.520019, -1341.414550, 29.993070, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2330.146972, -1341.417724, 29.993070, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2330.689453, -1341.417724, 29.991472, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2330.686523, -1351.914550, 29.991472, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2330.147460, -1354.186523, 29.997869, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2330.715332, -1354.182861, 29.994672, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2324.442871, -1348.214843, 29.994672, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2326.323242, -1363.828613, 26.498542, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2325.710937, -1363.835205, 28.837320, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19362, 2323.373046, -1342.217041, 33.529548, -0.000014, 89.977180, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19362, 2326.579589, -1342.218017, 33.529548, -0.000014, 89.972534, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2318.926757, -1340.484619, 23.016622, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18231, "cs_coast", "grasstype4", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2318.930664, -1354.832519, 23.016622, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18231, "cs_coast", "grasstype4", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2318.919921, -1369.048339, 23.019823, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18231, "cs_coast", "grasstype4", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2318.924804, -1358.762207, 23.013422, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18231, "cs_coast", "grasstype4", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2315.649902, -1340.186279, 25.219013, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2315.649902, -1342.207275, 25.219013, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2315.650390, -1352.952636, 25.219013, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2315.649414, -1354.972412, 25.219013, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2319.734375, -1363.014160, 25.219013, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2319.733398, -1365.036865, 25.219013, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(1557, 2333.203125, -1358.598388, 24.074302, -0.000007, -0.000014, 179.972290, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1569, 2318.069335, -1346.195312, 23.782163, -0.000014, 0.000007, -89.951957, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18029, "genintintsmallrest", "GB_restaursmll12", 0x00000000);
    tmpobjid = CreateDynamicObject(1569, 2318.077148, -1349.195068, 23.778963, 0.000014, -0.000007, 90.060607, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 18029, "genintintsmallrest", "GB_restaursmll12", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 2340.044189, -1359.147338, 24.801477, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 2349.573974, -1359.147338, 24.801477, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(1256, 2313.618652, -1360.200195, 23.719213, 0.000007, 0.000014, 0.027595, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7525, "vgnfirestat", "vegasfiredept1_256", 0x00000000);
    tmpobjid = CreateDynamicObject(1256, 2313.508789, -1364.218261, 23.719213, 0.000007, 0.000014, 0.027481, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7525, "vgnfirestat", "vegasfiredept1_256", 0x00000000);
    tmpobjid = CreateDynamicObject(1256, 2313.644531, -1337.703613, 23.719213, 0.000007, 0.000014, 0.027481, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7525, "vgnfirestat", "vegasfiredept1_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 2356.156982, -1359.146362, 24.801477, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 2360.888671, -1363.867065, 24.801477, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 2360.889648, -1369.566650, 24.801477, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2340.292724, -1359.119995, 22.333692, -0.000007, -0.000014, -89.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2349.883300, -1359.106811, 22.333692, -0.000007, -0.000014, -89.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2356.144775, -1359.098632, 22.333692, -0.000007, -0.000014, -89.922958, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2360.922119, -1363.842895, 22.333692, -0.000007, -0.000014, 0.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2360.927734, -1369.573486, 22.333692, -0.000007, -0.000014, 0.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2360.867675, -1369.573486, 22.333692, -0.000007, -0.000014, 0.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2360.863769, -1363.951904, 22.333692, -0.000007, -0.000014, 0.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2356.099853, -1359.177612, 22.333692, -0.000007, -0.000014, 90.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2346.500732, -1359.192382, 22.333692, -0.000007, -0.000014, 90.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2340.028564, -1359.200683, 22.333692, -0.000007, -0.000014, 90.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2356.091308, -1364.343505, 28.837390, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2356.091064, -1369.093261, 28.838949, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2346.460449, -1364.323486, 28.837387, -0.000022, 269.994506, -90.016380, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2346.460205, -1369.093261, 28.838949, -0.000022, 269.994506, -90.016380, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2356.091064, -1369.093261, 28.838949, -0.000014, 269.994506, -90.016403, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2338.647705, -1364.323486, 28.837484, -0.000029, 269.994506, -90.016357, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(19375, 2338.647460, -1369.093261, 28.839048, -0.000029, 269.994506, -90.016357, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7555, "bballcpark1", "ws_carparknew2", 0x00000000);
    tmpobjid = CreateDynamicObject(18766, 2358.354248, -1369.346191, 29.411384, 90.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18766, 2358.354248, -1364.135009, 29.411483, 90.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18766, 2353.343505, -1369.346191, 29.411384, 89.999992, 179.999984, -90.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18766, 2353.343505, -1364.135009, 29.411483, 89.999992, 179.999984, -90.000007, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18766, 2348.352294, -1369.346191, 29.411384, 89.999992, 179.999984, -89.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18766, 2348.352294, -1364.135009, 29.411483, 89.999992, 179.999984, -89.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18766, 2343.402832, -1369.346191, 29.411384, 89.999992, 179.999984, -89.999969, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18766, 2343.402832, -1364.135009, 29.411483, 89.999992, 179.999984, -89.999969, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18766, 2338.428710, -1369.346191, 29.411384, 89.999992, 180.000000, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18766, 2338.428710, -1364.135009, 29.411483, 89.999992, 180.000000, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18766, 2336.326660, -1369.346191, 29.412384, 89.999992, 180.000015, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18766, 2336.326660, -1364.135009, 29.412483, 89.999992, 180.000015, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19449, 2333.755615, -1365.348510, 22.333692, -0.000007, -0.000014, 180.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2333.754882, -1369.498779, 22.333692, -0.000007, -0.000014, 0.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 2333.746826, -1369.518310, 24.801477, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 2333.746826, -1360.057739, 24.801477, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2333.743652, -1355.908813, 22.333692, -0.000007, -0.000014, 180.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2333.734863, -1369.538818, 22.333692, -0.000007, -0.000014, 0.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19449, 2333.725097, -1359.908691, 22.333692, -0.000007, -0.000014, 0.077041, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2315.649902, -1340.186279, 28.129035, -0.000022, 0.000007, -89.999900, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2315.649902, -1342.207275, 28.129035, -0.000022, 0.000007, -89.999900, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2315.650390, -1352.952636, 28.129035, -0.000022, 0.000007, -89.999900, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2315.649414, -1354.972412, 28.129035, -0.000022, 0.000007, -89.999900, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2315.650390, -1346.670776, 28.129035, -0.000029, 0.000007, -89.999877, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(2257, 2315.649414, -1348.690551, 28.129035, -0.000029, 0.000007, -89.999877, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 1, 3979, "civic01_lan", "sl_dwntwnshpfrnt1", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 2357.513671, -1369.531738, 21.259166, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(19456, 2353.293701, -1369.531738, 21.259166, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(19456, 2354.951904, -1364.670898, 18.199163, 89.999992, 179.999984, -89.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(19456, 2355.852783, -1364.670898, 18.199163, 89.999992, 179.999984, -89.999984, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(19355, 2359.196777, -1374.317626, 22.337823, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 2359.196777, -1374.317626, 25.807807, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 2359.197753, -1374.316650, 27.147817, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 2335.260742, -1374.317626, 22.337823, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 2335.260742, -1374.317626, 25.807807, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 2335.261718, -1374.316650, 27.147817, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(5422, 2349.694091, -1376.309936, 26.914239, 0.000022, 90.000000, 89.999931, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2352.614501, -1374.291992, 22.319992, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2352.614501, -1374.291992, 25.799982, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2352.615478, -1374.291015, 27.170097, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 2351.728271, -1369.531738, 21.259166, 0.000000, 0.000014, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(19456, 2347.508300, -1369.531738, 21.259166, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(19456, 2349.166503, -1364.670898, 18.199163, 89.999992, 179.999984, -89.999969, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(19456, 2350.067382, -1364.670898, 18.199163, 89.999992, 179.999984, -89.999969, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(5422, 2355.538085, -1376.309936, 26.914239, 0.000022, 90.000000, 89.999931, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2346.808837, -1374.291992, 22.319992, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2346.808837, -1374.291992, 25.799982, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2346.809814, -1374.291015, 27.170097, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19456, 2345.922607, -1369.531738, 21.259166, 0.000000, 0.000022, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(19456, 2341.702636, -1369.531738, 21.259166, 0.000000, 0.000029, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(19456, 2343.360839, -1364.670898, 18.199163, 89.999992, 180.000000, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(19456, 2344.261718, -1364.670898, 18.199163, 89.999992, 180.000000, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0xFFFFFF00);
    tmpobjid = CreateDynamicObject(5422, 2343.903808, -1376.309936, 26.914239, 0.000022, 90.000000, 89.999931, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10763, "airport1_sfse", "ws_rollerdoor_fire", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2340.986816, -1374.291992, 22.319992, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2340.986816, -1374.291992, 25.799982, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2340.987792, -1374.291015, 27.170097, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2346.157470, -1374.827880, 29.427368, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18980, 2348.469482, -1374.827880, 29.247364, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18980, 2348.469482, -1374.827880, 29.416368, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(18980, 2346.157470, -1374.827880, 29.246364, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12944, "ce_bankalley2", "sw_brick04", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1897, 2353.359375, -1374.306518, 28.149084, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2357.451904, -1374.306518, 28.149084, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2356.400878, -1374.306518, 26.979061, 90.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2354.570068, -1374.306518, 26.979061, 90.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2354.570068, -1374.306518, 28.599077, 90.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2356.441406, -1374.306518, 28.789081, 270.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2355.311523, -1374.306518, 28.149084, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2354.570068, -1374.306518, 28.199075, 90.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2356.441406, -1374.306518, 28.389080, 270.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2347.565917, -1374.306518, 28.149084, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2351.658447, -1374.306518, 28.149084, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2350.607421, -1374.306518, 26.979061, 89.999992, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2348.776611, -1374.306518, 26.979061, 89.999992, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2348.776611, -1374.306518, 28.599077, 89.999992, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2350.647949, -1374.306518, 28.789081, -89.999992, -179.999984, 90.000015, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2349.518066, -1374.306518, 28.149084, -0.000007, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2348.776611, -1374.306518, 28.199075, 89.999992, 0.000000, -89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2350.647949, -1374.306518, 28.389080, -89.999992, -179.999984, 90.000015, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2341.760742, -1374.306518, 28.149084, -0.000022, 0.000000, -89.999931, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2345.853271, -1374.306518, 28.149084, -0.000022, 0.000000, -89.999931, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2344.802246, -1374.306518, 26.979061, 89.999992, 0.000025, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2342.971435, -1374.306518, 26.979061, 89.999992, 0.000025, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2342.971435, -1374.306518, 28.599077, 89.999992, 0.000025, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2344.842773, -1374.306518, 28.789081, -89.999992, -179.999984, 89.999969, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2343.712890, -1374.306518, 28.149084, -0.000022, 0.000000, -89.999931, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2342.971435, -1374.306518, 28.199075, 89.999992, 0.000025, -89.999961, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(1897, 2344.842773, -1374.306518, 28.389080, -89.999992, -179.999984, 89.999969, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2338.495361, -1374.291992, 26.309986, 90.000015, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(936, 2347.658203, -1359.890258, 23.410486, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(936, 2345.887207, -1359.890258, 23.410585, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(936, 2344.026855, -1359.890258, 23.410585, 0.000000, 0.000007, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19355, 2336.761474, -1362.080200, 25.744234, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 2336.760498, -1360.820434, 25.744335, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19355, 2335.241455, -1366.580932, 25.744335, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19356, 2335.263916, -1364.750366, 24.020526, 0.000007, 90.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6282, "beafron2_law2", "boardwalk2_la", 0x00000000);
    tmpobjid = CreateDynamicObject(19356, 2335.263916, -1361.258544, 24.020526, 0.000007, 90.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6282, "beafron2_law2", "boardwalk2_la", 0x00000000);
    tmpobjid = CreateDynamicObject(19356, 2335.263916, -1360.878173, 24.021526, 0.000007, 90.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 6282, "beafron2_law2", "boardwalk2_la", 0x00000000);
    tmpobjid = CreateDynamicObject(1893, 2355.028564, -1371.275268, 28.773033, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1893, 2355.028564, -1364.474853, 28.773033, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1893, 2349.403564, -1371.275268, 28.773033, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1893, 2349.403564, -1364.474853, 28.773033, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1893, 2343.709716, -1371.275268, 28.773033, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1893, 2343.709716, -1364.474853, 28.773033, 0.000014, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1893, 2338.505615, -1371.275268, 28.773033, 0.000022, 0.000000, 89.999931, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(1893, 2338.505615, -1364.474853, 28.773033, 0.000022, 0.000000, 89.999931, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    tmpobjid = CreateDynamicObject(19476, 2327.323486, -1378.789672, 22.846666, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19483, 2338.570068, -1374.408935, 26.680034, -0.000015, 0.000000, -89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7525, "vgnfirestat", "vegasfiredept1_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19476, 2339.259765, -1374.418457, 26.940046, 0.000015, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19476, 2338.869384, -1374.418457, 26.940046, 0.000015, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19483, 2339.077880, -1374.425048, 26.920021, -0.000015, 0.000000, -89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    SetDynamicObjectMaterialText(tmpobjid, 0, "{FFFFFF}LOS ANGELES", 90, "Ariel", 21, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(19483, 2315.179931, -1347.734863, 23.051927, -0.000007, -90.000038, -179.999893, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 7525, "vgnfirestat", "vegasfiredept1_256", 0x00000000);
    tmpobjid = CreateDynamicObject(19476, 2315.440185, -1348.424316, 23.061449, -0.000007, 90.000038, -0.000023, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19476, 2315.440185, -1348.034179, 23.061449, -0.000007, 90.000038, -0.000023, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    tmpobjid = CreateDynamicObject(19483, 2315.419921, -1348.242675, 23.068040, -0.000007, -90.000038, -179.999893, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    SetDynamicObjectMaterialText(tmpobjid, 0, "{FFFFFF}LOS ANGELES", 90, "Ariel", 21, 1, 0x00000000, 0x00000000, 1);
    tmpobjid = CreateDynamicObject(1499, 2340.210693, -1374.269042, 23.000000, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14847, "mp_policesf", "mp_cop_lectern", 0x00000000);
    tmpobjid = CreateDynamicObject(1499, 2336.858886, -1374.269042, 23.000000, 0.000000, 0.000000, 360.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3980, "cityhall_lan", "LAcityhwal1", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 1, 14847, "mp_policesf", "mp_cop_lectern", 0x00000000);
    tmpobjid = CreateDynamicObject(18880, 2338.593505, -1374.235229, 25.530019, 180.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 2, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(18880, 2338.463378, -1374.235229, 25.530019, 180.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, -1, "none", "none", 0xFFFFFFFF);
    SetDynamicObjectMaterial(tmpobjid, 2, 12944, "ce_bankalley2", "sw_brick04", 0x00000000);
    tmpobjid = CreateDynamicObject(19430, 2338.495361, -1374.291992, 27.909992, 90.000015, 0.000000, 89.999954, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 12855, "cunte_cop", "sw_brick05", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 2323.902587, -1370.456298, 22.282426, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 2326.402587, -1370.456298, 22.282426, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 2328.902587, -1370.456298, 22.282426, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
    tmpobjid = CreateDynamicObject(19866, 2331.042236, -1370.456298, 22.282426, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 19597, "lsbeachside", "carpet19-128x128", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(19357, 2335.445800, -1338.253662, 22.332212, -0.000007, -0.000014, -179.921554, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19357, 2335.436523, -1337.742187, 22.332212, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19357, 2335.445800, -1338.253662, 22.332212, -0.000007, -0.000014, -179.921554, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19357, 2335.436523, -1337.742187, 22.332212, -0.000007, -0.000014, -179.922958, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(14416, 2315.024414, -1347.617431, 20.599653, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(14416, 2331.829101, -1361.160400, 20.909851, 0.000007, 0.000014, 0.177558, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2321.743652, -1374.300781, 23.502805, -0.000007, 359.058807, 179.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3934, 2320.398437, -1353.640136, 30.083711, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3934, 2330.446777, -1353.645507, 30.083711, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3051, 2324.459960, -1343.863525, 31.446180, -0.000004, 0.000015, -43.686374, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3051, 2325.677734, -1343.865234, 31.446180, 0.000004, -0.000015, 136.323242, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1687, 2325.181152, -1364.530517, 29.734720, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2323.813964, -1372.210449, 23.468486, -0.000007, 359.058807, 269.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(781, 2316.115722, -1363.109619, 23.073471, 0.000009, -0.000014, 120.931945, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(781, 2317.501953, -1370.334228, 23.073471, -0.000014, -0.000009, -150.708663, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2314.109375, -1351.756835, 23.627313, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2314.107421, -1355.921875, 23.627313, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2314.102050, -1360.091308, 23.627313, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2314.101074, -1364.260498, 23.627313, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2314.098632, -1368.426513, 23.627313, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2314.098632, -1372.175292, 23.627313, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2316.160156, -1374.287841, 23.555313, -0.000007, -0.000014, 179.995910, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2320.302246, -1374.300781, 23.526443, -0.000007, 359.058807, 179.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2314.112792, -1343.665283, 23.603313, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2314.107421, -1339.516357, 23.604913, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2314.103027, -1335.347412, 23.604913, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2323.813964, -1368.101440, 23.400966, -0.000007, 359.058807, 269.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2315.730468, -1357.325927, 30.618291, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2317.820800, -1359.411376, 30.614309, -0.000007, -0.000014, 179.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2321.996582, -1359.413085, 30.614309, -0.000007, -0.000014, 179.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2326.172363, -1359.413330, 30.614309, -0.000007, -0.000014, 179.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2333.427246, -1359.401367, 30.614309, -0.000007, -0.000014, 179.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2335.507812, -1357.318359, 30.618291, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2335.507324, -1353.141601, 30.618291, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2335.510742, -1348.966552, 30.618291, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2335.511230, -1344.793212, 30.618291, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2333.426269, -1342.709228, 30.614309, -0.000007, -0.000014, 179.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2329.250488, -1342.707519, 30.614309, -0.000007, -0.000014, 179.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2315.732421, -1353.153564, 30.618291, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2315.732421, -1348.985107, 30.618291, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2315.729492, -1344.814208, 30.618291, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2317.816894, -1342.730712, 30.614309, -0.000007, -0.000014, 179.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(970, 2321.988281, -1342.730468, 30.614309, -0.000007, -0.000014, 179.994384, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3526, 2323.640625, -1357.896972, 30.152822, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3526, 2316.981933, -1357.874267, 30.152822, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3526, 2327.037109, -1357.900878, 30.152822, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3526, 2333.685058, -1357.909667, 30.152822, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3526, 2333.664062, -1349.205322, 30.152822, 0.000014, -0.000007, 89.794799, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3526, 2327.038085, -1349.188720, 30.152822, 0.000014, -0.000007, 89.791198, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3526, 2323.601074, -1349.199462, 30.152822, 0.000014, -0.000007, 89.791198, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3526, 2316.980468, -1349.191162, 30.152822, 0.000014, -0.000007, 89.791198, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2886, 2326.581054, -1343.767089, 31.401723, 0.000007, 0.000014, 0.177558, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1216, 2313.799804, -1345.013549, 23.545190, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2921, 2315.904785, -1359.375488, 29.870260, 0.000017, 0.000000, 62.615451, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2921, 2321.729003, -1340.662597, 33.235160, 0.000001, 0.000015, -17.715435, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2674, 2312.028808, -1362.419921, 23.093933, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2670, 2312.094726, -1335.239501, 23.164142, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1328, 2313.591308, -1339.489990, 23.515100, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1328, 2313.578613, -1362.249511, 23.585102, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(640, 2316.886718, -1373.890136, 23.383062, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(640, 2314.674804, -1371.120849, 23.383062, -0.000007, -0.000014, 179.063110, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(640, 2314.724609, -1365.963867, 23.383062, -0.000007, -0.000014, 179.060546, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(640, 2314.777343, -1360.884277, 23.383062, -0.000007, -0.000014, 179.969726, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(640, 2314.830078, -1355.804199, 23.383062, -0.000007, -0.000014, 179.966918, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(640, 2314.781250, -1352.395507, 23.383062, -0.000007, -0.000014, 179.966918, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(640, 2314.643066, -1342.740722, 23.383062, -0.000007, -0.000014, 179.966918, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(640, 2314.645019, -1337.533691, 23.383062, -0.000007, -0.000014, 179.966918, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(638, 2320.543945, -1373.906738, 23.386053, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(808, 2317.126464, -1367.143066, 24.216722, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(808, 2320.197265, -1371.626464, 24.216722, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(870, 2316.849121, -1360.932373, 23.321083, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(870, 2316.749511, -1363.709716, 23.321083, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(870, 2316.785644, -1366.246093, 23.321083, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(870, 2316.857421, -1369.242431, 23.321083, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(870, 2316.987792, -1372.003173, 23.321083, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(870, 2319.848144, -1372.173583, 23.321083, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(870, 2321.476562, -1370.281250, 23.321083, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(870, 2318.810058, -1370.635742, 23.321083, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(870, 2318.591308, -1367.728515, 23.321083, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(870, 2318.620605, -1365.033691, 23.321083, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(870, 2318.489746, -1362.273193, 23.321083, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1328, 2313.591308, -1351.240600, 23.515100, -0.000014, 0.000007, -89.999923, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1257, 2313.069824, -1370.262451, 24.193819, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1613, 2335.393310, -1374.310424, 24.727186, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1613, 2359.365722, -1374.310424, 24.727186, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19899, 2360.390380, -1361.453979, 22.980482, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19899, 2358.638671, -1359.682861, 22.980482, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19899, 2356.068115, -1359.682861, 22.980482, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19900, 2360.480468, -1365.621215, 23.020708, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19917, 2360.377197, -1365.564086, 23.910844, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11709, 2360.496337, -1363.972290, 23.710704, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11707, 2360.773437, -1364.386962, 24.801019, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11713, 2360.801513, -1367.734619, 24.611608, 0.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11729, 2354.343261, -1359.552001, 23.020172, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11729, 2353.672607, -1359.552001, 23.020172, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11729, 2353.011962, -1359.552001, 23.020172, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2007, 2360.309814, -1369.173461, 23.022230, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1764, 2360.335693, -1370.602905, 23.022428, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19915, 2351.513427, -1359.533935, 23.020179, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19916, 2350.149902, -1359.655761, 23.020292, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19815, 2347.357421, -1359.222290, 24.570358, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19815, 2344.377929, -1359.222290, 24.570358, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18633, 2347.086181, -1359.933349, 23.890218, 0.000000, 90.000000, -29.500000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18633, 2344.301513, -1359.817260, 23.890218, 0.000000, 90.000000, -137.600021, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19921, 2346.268798, -1359.706176, 23.980209, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2103, 2348.004150, -1359.731323, 23.870372, 0.000000, 0.000000, -18.000003, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(920, 2345.543945, -1359.921752, 24.240385, 0.000000, 0.000000, 14.100004, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(919, 2342.528564, -1359.815063, 23.340431, 0.000000, 0.000000, -20.699996, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(935, 2339.620605, -1360.012451, 23.594327, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(935, 2338.900878, -1359.672363, 23.594327, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(935, 2339.451660, -1361.333007, 23.504325, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1431, 2341.010009, -1359.858764, 23.490720, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(16601, 2345.963134, -1355.146484, 27.610721, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(16601, 2356.243164, -1355.146484, 27.610721, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3675, 2356.326660, -1360.435791, 31.394973, 270.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3675, 2345.895507, -1360.435791, 31.394973, 270.000000, 0.000000, 180.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3052, 2360.325439, -1361.380126, 24.326866, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3052, 2360.325439, -1361.919921, 24.326866, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3052, 2360.325439, -1362.480346, 24.326866, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(3761, 2334.615234, -1369.909545, 24.386940, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18763, 2335.146972, -1365.147705, 21.589429, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18763, 2335.387207, -1362.168212, 21.589429, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18763, 2335.146972, -1360.707519, 21.589429, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18763, 2335.387207, -1360.707519, 21.590429, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18763, 2335.357177, -1363.637695, 21.590429, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18763, 2335.357177, -1365.178588, 21.590528, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11729, 2334.041748, -1359.582153, 24.050413, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11729, 2334.041748, -1360.252197, 24.050413, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11729, 2334.041748, -1360.902465, 24.050413, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11729, 2334.041748, -1361.562255, 24.050413, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11729, 2334.041748, -1362.222778, 24.050413, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11729, 2334.041748, -1362.842407, 24.050413, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2311, 2335.702880, -1362.078613, 24.001461, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19940, 2334.089355, -1364.158447, 24.256898, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19940, 2334.089355, -1364.158447, 26.086910, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19940, 2334.089355, -1365.158935, 25.096889, 90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19940, 2334.089355, -1363.178466, 25.096889, 90.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19940, 2334.339599, -1364.158447, 24.076894, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2690, 2334.026367, -1363.466674, 24.581401, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2690, 2334.026367, -1363.796997, 24.581401, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2690, 2334.026367, -1364.166625, 24.581401, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2690, 2334.026367, -1364.526855, 24.581401, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2690, 2334.026367, -1364.887084, 24.581401, 0.000007, 0.000000, 89.999977, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19940, 2334.089355, -1364.158447, 24.986904, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19330, 2334.093505, -1363.367065, 25.111906, 0.000000, 270.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19330, 2334.093505, -1363.707397, 25.111906, 0.000000, 270.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19330, 2334.093505, -1364.057739, 25.111906, 0.000000, 270.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19330, 2334.093505, -1364.368041, 25.111906, -0.000014, 270.000000, -89.999954, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19330, 2334.093505, -1364.708374, 25.111906, -0.000014, 270.000000, -89.999954, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19330, 2334.093505, -1365.028686, 25.111906, -0.000007, 270.000000, -89.999977, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19940, 2334.089355, -1364.158447, 25.266910, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2401, 2334.018554, -1363.458251, 25.709062, -12.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2383, 2334.089355, -1364.040893, 25.719152, 0.000000, -14.100001, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2401, 2334.018554, -1364.708618, 25.709062, -12.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11709, 2334.169433, -1365.842529, 24.773988, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18763, 2335.577392, -1365.178588, 21.360528, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18763, 2335.817626, -1365.178588, 21.140523, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18763, 2336.047851, -1365.178588, 20.940519, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18763, 2336.298095, -1365.178588, 20.770515, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19466, 2354.302246, -1374.296997, 28.038713, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19466, 2356.502685, -1374.296997, 28.038713, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19466, 2350.730224, -1374.296997, 28.038713, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19466, 2348.478759, -1374.296997, 28.038713, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19466, 2344.957031, -1374.296997, 28.038713, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19466, 2342.685302, -1374.296997, 28.038713, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11245, 2333.797119, -1376.117309, 29.536293, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11245, 2360.780517, -1376.117309, 29.536293, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11245, 2313.862548, -1359.197753, 29.916301, 0.000000, 0.000000, 540.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(11245, 2313.862548, -1336.297241, 29.916301, 0.000000, 0.000000, 540.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18633, 2360.275390, -1360.636108, 24.274251, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(18633, 2360.275390, -1360.636108, 24.624259, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(2595, 2359.024169, -1359.622924, 24.579502, 0.000000, 0.000000, 270.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19921, 2356.131103, -1359.955566, 24.320209, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19621, 2357.420166, -1359.994873, 24.324415, 0.000000, 0.000000, 90.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19621, 2358.021972, -1360.030273, 24.324415, 0.000000, 0.000000, 135.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19622, 2358.200195, -1360.255126, 23.698621, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19823, 2356.283447, -1359.947143, 25.041511, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19816, 2357.254394, -1359.820678, 24.510303, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19816, 2356.703857, -1359.400756, 24.510303, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19816, 2357.114257, -1359.400756, 24.510303, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19812, 2360.464355, -1366.734985, 23.463394, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(19843, 2355.979003, -1360.528564, 23.337848, 45.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1764, 2337.304687, -1362.393310, 23.022428, 0.000000, 0.000000, 450.000000, -1, -1, -1, 300.00, 300.00); 
    tmpobjid = CreateDynamicObject(1216, 2334.203857, -1374.702514, 23.630008, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid)
{
	Bombeiro[playerid][CompanheiroId] = INVALID_PLAYER_ID;

	RemoveBuildingForPlayer(playerid, 17535, 2364.054, -1391.531, 41.351, 0.250);
    RemoveBuildingForPlayer(playerid, 17965, 2322.281, -1355.195, 25.406, 0.250);
    RemoveBuildingForPlayer(playerid, 1266, 2317.585, -1355.828, 37.218, 0.250);
    RemoveBuildingForPlayer(playerid, 17970, 2364.054, -1391.531, 41.351, 0.250);
    RemoveBuildingForPlayer(playerid, 17543, 2322.281, -1355.195, 25.406, 0.250);
    RemoveBuildingForPlayer(playerid, 1260, 2317.593, -1355.820, 37.226, 0.250);
    RemoveBuildingForPlayer(playerid, 17542, 2347.919, -1364.290, 27.156, 0.250);
    RemoveBuildingForPlayer(playerid, 17966, 2347.919, -1364.290, 27.156, 0.250);
    RemoveBuildingForPlayer(playerid, 955, 2352.179, -1357.160, 23.773, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 2344.919, -1379.520, 26.226, 0.250);
}

hook OnPlayerDisconnect(playerid, reason)
{
	if ( Bombeiro[playerid][CompanheiroId] != INVALID_PLAYER_ID )
	{
		SendClientMessage(Bombeiro[playerid][CompanheiroId], COR_ERRO, "| ERRO | Seu companheiro de trabalho saiu do servidor e o serviço foi cancelado.");
		call::BOMBEIRO->CancelarServico(Bombeiro[playerid][CompanheiroId]);
	}
	call::BOMBEIRO->CancelarServico(playerid);
	return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
	if ( playerid != INVALID_PLAYER_ID )
	{
		if ( Bombeiro[playerid][CompanheiroId] != INVALID_PLAYER_ID )
		{
			SendClientMessage(Bombeiro[playerid][CompanheiroId], COR_ERRO, "| ERRO | Seu companheiro de trabalho foi morto e o serviço foi cancelado.");
			call::BOMBEIRO->CancelarServico(Bombeiro[playerid][CompanheiroId]);
		}
		call::BOMBEIRO->CancelarServico(playerid);
	}

	return Y_HOOKS_CONTINUE_RETURN_1;	
}


hook OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if( PRESSING(newkeys, KEY_FIRE))
	{
		if ( GetPlayerWeapon(playerid) != 42 || Jogador[playerid][Profissao] != BOMBEIRO)// || !call::JOB->IsPlayerInWorking(playerid) )
		{
			return Y_HOOKS_CONTINUE_RETURN_1;
		}

		new casaid = Bombeiro[playerid][WorkHouse];
		if ( Bombeiro[playerid][Working] && IsPlayerInRangeOfPoint(playerid, 5.0, Casa[casaid][Entrada][X], Casa[casaid][Entrada][Y], Casa[casaid][Entrada][Z]) )
		{
			if ( Bombeiro[playerid][FireLife] == -1 )
			{
				SendClientMessage(playerid, COR_ERRO, "| ERRO | O Seu companheiro de profissão que deve apagar o fogo");
				return Y_HOOKS_BREAK_RETURN_1;
			}

			KillTimer(Bombeiro[playerid][Time]);
			Bombeiro[playerid][Time] = SetTimerEx("ApagandoFogo", 1000, true, "i", playerid);
			return Y_HOOKS_BREAK_RETURN_1;
		}
	}
	if ( RELEASED(KEY_FIRE) )
	{
		if ( Bombeiro[playerid][Time] != 0 )
		{
			KillTimer(Bombeiro[playerid][Time]);
			Bombeiro[playerid][Time] = 0;
			return Y_HOOKS_BREAK_RETURN_1;
		}
	}
	return Y_HOOKS_CONTINUE_RETURN_1;
}

public ApagandoFogo(playerid)
{
	if ( Bombeiro[playerid][Working] )
	{
		new id = Bombeiro[playerid][CompanheiroId];
		if ( GetPlayerState(id) != PLAYER_STATE_DRIVER || !IsPlayerInVehicle(id, Bombeiro[id][WorkVehicle]) )
		{
			KillTimer(Bombeiro[playerid][Time]);
			Bombeiro[playerid][Time] = 0;

			SendClientMessage(playerid, COR_ERRO, "| ERRO | Seu companheiro de trabalho deve ficar no caminhão dos bombeiros enquanto você apaga o fogo.");
			return 1;
		}


		new string[128];
		Bombeiro[playerid][FireLife] -= random(3, 1);
		format(string, sizeof(string), "Fogo: %d%", Bombeiro[playerid][FireLife]);
		
		UpdateFireTD(playerid, string);
		UpdateFireTD(id, string);

		if ( Bombeiro[playerid][FireLife] < 1 )
		{
			Bombeiro[playerid][FireLife] = 0;
			KillTimer(Bombeiro[playerid][Time]);

			GivePlayerMoney(playerid, Bombeiro[playerid][Pay], true);
			GivePlayerMoney(id, Bombeiro[playerid][Pay], true);

			SendClientMessage(id, COR_SISTEMA, "» Volte ao caminhão para iniciar um novo trabalho.");
			SendClientMessage(id, COR_SISTEMA, "» Vocês receberam {"COR_VERDE_INC"}R$%s{"COR_SISTEMA_INC"} cada", RealStr(Bombeiro[playerid][Pay]));

			SendClientMessage(playerid, COR_SISTEMA, "» Fogo apagado, use {"COR_BRANCO_INC"}/pegarincendio{"COR_SISTEMA_INC"} para ir ao próximo incendio.");
			SendClientMessage(playerid, COR_SISTEMA, "» Vocês receberam {"COR_VERDE_INC"}R$%s{"COR_SISTEMA_INC"} cada", RealStr(Bombeiro[playerid][Pay]));

			call::BOMBEIRO->CancelarServico(playerid);
			call::BOMBEIRO->CancelarServico(id);
		}
		return 1;
	}
	return 1;
}

function BOMBEIRO::CancelarServico(playerid)
{
	if ( Bombeiro[playerid][Time] != 0 )
	{
		KillTimer(Bombeiro[playerid][Time]);
	}

	DestroyFireTD(playerid);
	if ( Bombeiro[playerid][FireObject] )
	{
		DestroyObject(Bombeiro[playerid][FireObject]);
	}
	DisablePlayerCheckpoint(playerid);

	new r[e_BOMBEIRO];
	Bombeiro[playerid] = r;
	return true;
}

stock CreateFireTD(playerid)
{
	if ( GetPVarInt(playerid, "CreateFireTD") )return 0;
	
	SetPVarInt(playerid, "CreateFireTD", 1);

	FirePTD[playerid] = CreatePlayerTextDraw(playerid, 119.000000, 378.000000, "FOGO: 0");
	PlayerTextDrawBackgroundColor(playerid, FirePTD[playerid], 253310497);
	PlayerTextDrawFont(playerid, FirePTD[playerid], 1);
	PlayerTextDrawLetterSize(playerid, FirePTD[playerid], 0.210000, 0.599999);
	PlayerTextDrawColor(playerid, FirePTD[playerid], 0xFF6A6AFF);
	PlayerTextDrawSetOutline(playerid, FirePTD[playerid], 0);
	PlayerTextDrawSetProportional(playerid, FirePTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, FirePTD[playerid], 1);
	PlayerTextDrawUseBox(playerid, FirePTD[playerid], 1);
	PlayerTextDrawBoxColor(playerid, FirePTD[playerid], 219027789);
	PlayerTextDrawTextSize(playerid, FirePTD[playerid], 177.000000, -98.000000);

	PlayerTextDrawShow(playerid, FirePTD[playerid]);
	return 1;
}

stock UpdateFireTD(playerid, string[])
{
	if ( GetPVarInt(playerid, "CreateFireTD") )
	{
		PlayerTextDrawSetString(playerid, FirePTD[playerid], string);
		return 1;
	}
	return 1;
}

stock DestroyFireTD(playerid)
{
	if ( GetPVarInt(playerid, "CreateFireTD") )
	{
		DeletePVar(playerid, "CreateFireTD");
		PlayerTextDrawDestroy(playerid, FirePTD[playerid]);
		FirePTD[playerid] = PlayerText:INVALID_TEXT_DRAW;
		return 1;
	}
	return 0;
}

CMD:pegarincendio(playerid, params[])
{
	if ( !IsPlayerInAnyVehicle(playerid) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um veiculo.");

	if ( Jogador[playerid][Profissao] != BOMBEIRO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não faz parte da profissão de Bombeiro");

	//if(!call::JOB->IsPlayerInWorking(playerid))
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando para usar este comando.");

	if( Bombeiro[playerid][Working] )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você já tem um incêndio para ser concluido.");

	if ( GetPlayerState(playerid) != PLAYER_STATE_DRIVER )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é o motorista.");

	new vehicleid = GetPlayerVehicleID(playerid);

	if ( call::JOB->GetVehicleJob(vehicleid) != BOMBEIRO )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um caminhão de bombeiro.");

	if ( !IsVehicleSeatOccupied(vehicleid, 1) )
		return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você precisa de um parceiro de profissão sentado no banco do carona.");

	foreach(new i: Player)
	{
		if( IsPlayerInVehicle(i, vehicleid) && GetPlayerVehicleSeat(i) == 1 )
		{
			new rand = Iter_Random(Casas), zone[MAX_ZONE_NAME];
			GetLocalName(Casa[rand][Entrada][X], Casa[rand][Entrada][Y], zone, MAX_ZONE_NAME);

			new dist = floatround(GetPlayerDistanceFromPoint(playerid, Casa[rand][Entrada][X], Casa[rand][Entrada][Y], Casa[rand][Entrada][Z]));
			 
			Bombeiro[playerid][WorkHouse] = rand;
			Bombeiro[playerid][CompanheiroId] = i;
			Bombeiro[playerid][Working] = true;
			Bombeiro[playerid][WorkVehicle] = vehicleid;
			Bombeiro[playerid][FireLife] = -1;
			Bombeiro[playerid][Pay] = (dist * 30 / 100);
			CreateFireTD(playerid);
			UpdateFireTD(playerid, "Fogo: 100%");

			Bombeiro[i][WorkHouse] = rand;
			Bombeiro[i][Working] = true;
			Bombeiro[i][CompanheiroId] = playerid;
			Bombeiro[i][WorkVehicle] = vehicleid;
			Bombeiro[i][FireLife] = 100;
			Bombeiro[i][Pay] = (dist * 30 / 100);
			CreateFireTD(i);
			UpdateFireTD(i, "Fogo: 100%");

			GivePlayerWeapon(i, 42, 9999);

			Bombeiro[i][FireObject] = CreateObject(18691, Casa[rand][Entrada][X], Casa[rand][Entrada][Y], Casa[rand][Entrada][Z]-2.5, 0.0, 0.0, 0.0);

			SetPlayerCheckpoint(i, Casa[rand][Entrada][X], Casa[rand][Entrada][Y], Casa[rand][Entrada][Z]-2.5, 3.0);
			SetPlayerCheckpoint(playerid, Casa[rand][Entrada][X], Casa[rand][Entrada][Y], Casa[rand][Entrada][Z]-2.5, 3.0);
			return 1;
		}
	}
	return 1;
}