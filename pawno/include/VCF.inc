enum {
	VCF_LIGHT_FRONT,
	VCF_LIGHT_BACK
}

enum ( <<= 2 ) {
	VCF_LIGHT_LEFT = 1,
	VCF_LIGHT_RIGHT
}

enum {
	VCF_DOOR_HOOD,
	VCF_DOOR_TRUNK,
	VCF_DOOR_DRIVER,
	VCF_DOOR_PASSENGER
}

enum ( <<=1 ) {
	VCF_DOOR_FIXED = 0,
	VCF_DOOR_OPENED = 1,
	VCF_DOOR_DAMAGED,
	VCF_DOOR_REMOVED,
	VCF_DOOR_OPENED_DAMAGED = 3
}

enum ( <<=1 ) {
	VCF_TIRE_REAR_RIGHT = 1,
	VCF_TIRE_FRONT_RIGHT,
	VCF_TIRE_REAR_LEFT,
	VCF_TIRE_FRONT_LEFT
}

stock IsLightEnabled(const vehicleid, const light, const lightSide) {

	if(0 > vehicleid > MAX_VEHICLES)
		return false;

	new VCF_panels, VCF_doors, VCF_lights, VCF_tires;
	GetVehicleDamageStatus(vehicleid, VCF_panels, VCF_doors, VCF_lights, VCF_tires);

	return ((VCF_lights >>> (4 * light)) & lightSide) ^ lightSide;
}

stock ToogleLightState(const vehicleid, const light, const lightSide) {

	if(0 > vehicleid > MAX_VEHICLES)
		return false;

	new VCF_panels, VCF_doors, VCF_lights, VCF_tires;
	GetVehicleDamageStatus(vehicleid, VCF_panels, VCF_doors, VCF_lights, VCF_tires);

	VCF_lights = VCF_lights ^ (1 << ((4 * light) + ((lightSide == VCF_LIGHT_RIGHT) ? (2) : (0))));

	UpdateVehicleDamageStatus(vehicleid, VCF_panels, VCF_doors, VCF_lights, VCF_tires);
	
	return true;
}

stock GetDoorState(const vehicleid, const door) {

	if(0 > vehicleid > MAX_VEHICLES)
		return false;

	new VCF_panels, VCF_doors, VCF_lights, VCF_tires;
	GetVehicleDamageStatus(vehicleid, VCF_panels, VCF_doors, VCF_lights, VCF_tires);

	return (VCF_doors >>> (8 * door)) & (0b111);
}

stock SetDoorState(const vehicleid, const door, const doorState) {

	if(0 > vehicleid > MAX_VEHICLES)
		return false;


	if(door == VCF_DOOR_TRUNK && doorState == VCF_DOOR_OPENED)
		return false;

	new VCF_panels, VCF_doors, VCF_lights, VCF_tires;
	GetVehicleDamageStatus(vehicleid, VCF_panels, VCF_doors, VCF_lights, VCF_tires);

	new VCF_tmp = (GetDoorState(vehicleid, door) << (8 * door)) ^ VCF_doors;

	VCF_doors = (doorState << (8 * door)) | VCF_tmp;
	
	if(doorState == VCF_DOOR_FIXED) {
		new Float:VCF_health;
		GetVehicleHealth(vehicleid, VCF_health);
		RepairVehicle(vehicleid);
		UpdateVehicleDamageStatus(vehicleid, VCF_panels, VCF_doors, VCF_lights, VCF_tires);
		SetVehicleHealth(vehicleid, VCF_health);
	} else 
		UpdateVehicleDamageStatus(vehicleid, VCF_panels, VCF_doors, VCF_lights, VCF_tires);
	
	return true;
}

stock IsTireInflated(const vehicleid, const tire) {
	if(0 > vehicleid > MAX_VEHICLES)
		return false;

	new VCF_panels, VCF_doors, VCF_lights, VCF_tires;
	GetVehicleDamageStatus(vehicleid, VCF_panels, VCF_doors, VCF_lights, VCF_tires);

	if(tire == VCF_TIRE_FRONT_RIGHT) {
		if((((VCF_tires & tire) >> 1) & 0b001) == 0)
			return true;
	} else if(tire == VCF_TIRE_REAR_LEFT) {
		if((((VCF_tires & tire) >> 2) & 0b01) == 0)
			return true;
	} else if(tire == VCF_TIRE_FRONT_LEFT) {
		if(((VCF_tires & tire) >> 3) == 0)
			return true;
	} else {
		if((VCF_tires & tire) == 0)
			return true;
	}

	return false;
}

stock ToogleTireState(const vehicleid, const tire) {

	if(0 > vehicleid > MAX_VEHICLES)
		return false;

	new VCF_panels, VCF_doors, VCF_lights, VCF_tires;
	GetVehicleDamageStatus(vehicleid, VCF_panels, VCF_doors, VCF_lights, VCF_tires);

	VCF_tires = VCF_tires ^ tire;

	UpdateVehicleDamageStatus(vehicleid, VCF_panels, VCF_doors, VCF_lights, VCF_tires);

	return true;
}

// by renatog
public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
    if(GetDoorState(vehicleid, VCF_DOOR_TRUNK) == VCF_DOOR_OPENED_DAMAGED)
        SetDoorState(vehicleid, VCF_DOOR_TRUNK, VCF_DOOR_DAMAGED);

    #if defined VCF_OnVehicleDamageStatusUpdate
        return VCF_OnVehicleDamageStatusUpdate(vehicleid, playerid);
    #else
        return 1;
    #endif
}
#if defined ALS_OnVehicleDamageStatusUpdate
    #undef OnVehicleDamageStatusUpdate
#else
    #define ALS_OnVehicleDamageStatusUpdate
#endif

#define OnVehicleDamageStatusUpdate VCF_OnVehicleDamageStatusUpdate
#if defined VCF_OnVehicleDamageStatusUpdate
    forward VCF_OnVehicleDamageStatusUpdate(vehicleid, playerid);
#endif
//