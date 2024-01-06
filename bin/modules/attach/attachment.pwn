static
	armedbody_pTick[MAX_PLAYERS],
	weaponid[2], weaponammo[2], pArmedWeapon;

hook OnPlayerUpdate(playerid)
{
	if(GetTickCount() - armedbody_pTick[playerid] > 500)
	{
		
		pArmedWeapon = GetPlayerWeapon(playerid);

		GetPlayerWeaponData(playerid, 4, weaponid[0], weaponammo[0]);
		GetPlayerWeaponData(playerid, 5, weaponid[1], weaponammo[1]);

		/**
		*
		*		Metralhadoras
		*
		**/
		if(weaponid[0] && weaponammo[0] > 0){
			if(pArmedWeapon != weaponid[0]){
				if(!IsPlayerAttachedObjectSlotUsed(playerid, ATTACH_SUBFUZIL)){
					SetPlayerAttachedObject(playerid,ATTACH_SUBFUZIL,GetWeaponModel(weaponid[0]),7, 0.000000, -0.100000, -0.080000, -95.000000, -10.000000, 0.000000, 1.000000, 1.000000, 1.000000);
				}
			}
			else {
				if(IsPlayerAttachedObjectSlotUsed(playerid,ATTACH_SUBFUZIL)){
					RemovePlayerAttachedObject(playerid,ATTACH_SUBFUZIL);
				}
			}
		}
		else if(IsPlayerAttachedObjectSlotUsed(playerid,ATTACH_SUBFUZIL)){
			RemovePlayerAttachedObject(playerid,ATTACH_SUBFUZIL);
		}


		/**
		*
		*		Fuzis
		*
		**/
		if(weaponid[1] && weaponammo[1] > 0){
			if(pArmedWeapon != weaponid[1]){
				if(!IsPlayerAttachedObjectSlotUsed(playerid, ATTACH_FUZIL)){
					SetPlayerAttachedObject(playerid, ATTACH_FUZIL, GetWeaponModel(weaponid[1]),1, 0.200000, -0.119999, -0.059999, 0.000000, 206.000000, 0.000000, 1.000000, 1.000000, 1.000000);
				}
			}
			else {
				if(IsPlayerAttachedObjectSlotUsed(playerid,ATTACH_FUZIL)){
					RemovePlayerAttachedObject(playerid,ATTACH_FUZIL);
				}
			}
		}
		else if(IsPlayerAttachedObjectSlotUsed(playerid, ATTACH_FUZIL)){
			RemovePlayerAttachedObject(playerid, ATTACH_FUZIL);
		}
		armedbody_pTick[playerid] = GetTickCount();
	}
	return 1;
}

stock GetWeaponModel(_weaponid)
{
	switch(_weaponid)
	{
	    case 1:
	        return 331;

		case 2..8:
		    return _weaponid+331;

        case 9:
		    return 341;

		case 10..15:
			return _weaponid+311;

		case 16..18:
		    return _weaponid+326;

		case 22..29:
		    return _weaponid+324;

		case 30,31:
		    return _weaponid+325;

		case 32:
		    return 372;

		case 33..45:
		    return _weaponid+324;

		case 46:
		    return 371;
	}
	return 0;
}
