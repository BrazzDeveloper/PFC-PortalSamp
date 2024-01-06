enum e_VEHICLE_INFOMATION
{
	Tipo,
	Capacidade,
	ValorConce
}
static VehicleInfo[][e_VEHICLE_INFOMATION] =
{
	{TYPE_GASOLINA, 80, 35000},
	{TYPE_GASOLINA, 60, 40000},
	{TYPE_GASOLINA, 60, 39000},
	{TYPE_DIESEL, 300, 150000},
	{TYPE_GASOLINA, 60, 25000},
	{TYPE_GASOLINA, 60, 30000},
	{TYPE_DIESEL, 300, 200000},
	{TYPE_DIESEL, 300, 350000},
	{TYPE_DIESEL, 300, 120000},
	{TYPE_GASOLINA, 90, 100000},
	{TYPE_GASOLINA, 60, 35000},
	{TYPE_GASOLINA, 70, 200000},
	{TYPE_GASOLINA, 60, 29500},
	{TYPE_DIESEL, 150, 50000},
	{TYPE_DIESEL, 150, 50000},
	{TYPE_GASOLINA, 70, 90000},
	{TYPE_DIESEL, 300, 150000},
	{TYPE_AVG, 500, 500000},
	{TYPE_GASOLINA, 60, 61000},
	{TYPE_GASOLINA, 60, 40000},
	{TYPE_GASOLINA, 60, 40000},
	{TYPE_GASOLINA, 60, 50000},
	{TYPE_GASOLINA, 60, 37000},
	{TYPE_GASOLINA, 60, 65000},
	{TYPE_GASOLINA, 80, 35000},
	{TYPE_DIESEL, 400, 700000},
	{TYPE_GASOLINA, 60, 40000},
	{TYPE_DIESEL, 100, 200000},
	{TYPE_DIESEL, 150, 200000},
	{TYPE_GASOLINA, 70, 81000},
	{TYPE_DIESEL, 90, 150000},
	{TYPE_DIESEL, 150, 150000},
	{TYPE_DIESEL, 200, 500000},
	{TYPE_DIESEL, 150, 200000},
	{TYPE_GASOLINA, 60, 70000},
	{TYPE_NULL, 0, 0},
	{TYPE_GASOLINA, 60, 50000},
	{TYPE_DIESEL, 100, 100000},
	{TYPE_GASOLINA, 60, 45000},
	{TYPE_GASOLINA, 60, 55000},
	{TYPE_DIESEL, 70, 70000},
	{TYPE_NULL, 0, 0},
	{TYPE_GASOLINA, 60, 53000},
	{TYPE_DIESEL, 200, 250000},
	{TYPE_GASOLINA, 80, 120000},
	{TYPE_GASOLINA, 60, 37000},
	{TYPE_DIESEL, 80, 80000},
	{TYPE_AVG, 150, 30000},
	{TYPE_GASOLINA, 30, 25000},
	{TYPE_NULL, 0, 0},
	{TYPE_NULL, 0, 0},
	{TYPE_GASOLINA, 80, 180000},
	{TYPE_DIESEL, 80, 160000},
	{TYPE_DIESEL, 80, 80000},
	{TYPE_DIESEL, 80, 120000},
	{TYPE_DIESEL, 150, 150000},
	{TYPE_DIESEL, 150, 135000},
	{TYPE_GASOLINA, 30, 30000},
	{TYPE_GASOLINA, 60, 35000},
	{TYPE_GASOLINA, 60, 63000},
	{TYPE_AVG, 100, 350000},
	{TYPE_GASOLINA, 30, 20000},
	{TYPE_GASOLINA, 60, 15000},
	{TYPE_GASOLINA, 60, 25000},
	{TYPE_NULL, 0, 0},
	{TYPE_NULL, 0, 0},
	{TYPE_GASOLINA, 60, 40000},
	{TYPE_GASOLINA, 60, 40000},
	{TYPE_GASOLINA, 30, 22000},
	{TYPE_AVG, 150, 250000},
	{TYPE_GASOLINA, 80, 90000},
	{TYPE_GASOLINA, 20, 11000},
	{TYPE_DIESEL, 80, 90000},
	{TYPE_DIESEL, 60, 15000},
	{TYPE_GASOLINA, 60, 29000},
	{TYPE_GASOLINA, 60, 27000},
	{TYPE_AVG, 100, 200000},
	{TYPE_GASOLINA, 70, 70000},
	{TYPE_DIESEL, 60, 35000},
	{TYPE_GASOLINA, 60, 60000},
	{TYPE_GASOLINA, 60, 60000},
	{TYPE_NULL, 0, 600},
	{TYPE_GASOLINA, 60, 40000},
	{TYPE_GASOLINA, 60, 50000},
	{TYPE_DIESEL, 100, 250000},
	{TYPE_DIESEL, 60, 10000},
	{TYPE_DIESEL, 150, 200000},
	{TYPE_AVG, 200, 700000},
	{TYPE_AVG, 200, 700000},
	{TYPE_GASOLINA, 80, 50000},
	{TYPE_GASOLINA, 80, 50000},
	{TYPE_GASOLINA, 60, 45000},
	{TYPE_GASOLINA, 60, 47000},
	{TYPE_DIESEL, 80, 300000},
	{TYPE_GASOLINA, 60, 90000},
	{TYPE_GASOLINA, 80, 111000},
	{TYPE_GASOLINA, 60, 43000},
	{TYPE_AVG, 200, 500000},
	{TYPE_DIESEL, 100, 90000},
	{TYPE_DIESEL, 100, 70000},
	{TYPE_GASOLINA, 60, 33000},
	{TYPE_NULL, 0, 0},
	{TYPE_GASOLINA, 70, 90000},
	{TYPE_GASOLINA, 70, 90000},
	{TYPE_GASOLINA, 60, 70000},
	{TYPE_GASOLINA, 80, 50000},
	{TYPE_GASOLINA, 70, 170000},
	{TYPE_GASOLINA, 60, 45000},
	{TYPE_DIESEL, 100, 100000},
	{TYPE_NULL, 0, 400},
	{TYPE_NULL, 0, 800},
	{TYPE_AVG, 150, 200000},
	{TYPE_AVG, 100, 170000},
	{TYPE_AVG, 100, 170000},
	{TYPE_DIESEL, 300, 200000},
	{TYPE_DIESEL, 300, 180000},
	{TYPE_GASOLINA, 60, 39900},
	{TYPE_GASOLINA, 60, 60000},
	{TYPE_GASOLINA, 60, 30000},
	{TYPE_AVG, 400, 900000},
	{TYPE_AVG, 400, 1500000},
	{TYPE_GASOLINA, 40, 45000},
	{TYPE_GASOLINA, 40, 50000},
	{TYPE_GASOLINA, 30, 50000},
	{TYPE_DIESEL, 200, 160000},
	{TYPE_GASOLINA, 60, 70000},
	{TYPE_GASOLINA, 60, 54000},
	{TYPE_GASOLINA, 60, 54000},
	{TYPE_DIESEL, 100, 100000},
	{TYPE_GASOLINA, 60, 50000},
	{TYPE_DIESEL, 60, 15000},
	{TYPE_DIESEL, 60, 16000},
	{TYPE_DIESEL, 100, 200000},
	{TYPE_GASOLINA, 60, 45000},
	{TYPE_GASOLINA, 60, 56000},
	{TYPE_GASOLINA, 60, 69990},
	{TYPE_GASOLINA, 60, 65500},
	{TYPE_NULL, 0, 0},
	{TYPE_NULL, 0, 0},
	{TYPE_GASOLINA, 60, 15000},
	{TYPE_GASOLINA, 60, 44500},
	{TYPE_GASOLINA, 60, 190000},
	{TYPE_GASOLINA, 60, 25000},
	{TYPE_GASOLINA, 60, 27000},
	{TYPE_DIESEL, 150, 200000},
	{TYPE_GASOLINA, 60, 44000},
	{TYPE_GASOLINA, 60, 50000},
	{TYPE_GASOLINA, 60, 49000},
	{TYPE_DIESEL, 250, 500000},
	{TYPE_GASOLINA, 60, 37000},
	{TYPE_GASOLINA, 60, 70000},
	{TYPE_GASOLINA, 60, 48000},
	{TYPE_GASOLINA, 60, 60000},
	{TYPE_AVG, 500, 1000000},
	{TYPE_GASOLINA, 60, 40000},
	{TYPE_GASOLINA, 60, 30000},
	{TYPE_GASOLINA, 80, 90000},
	{TYPE_GASOLINA, 80, 90000},
	{TYPE_GASOLINA, 60, 70000},
	{TYPE_GASOLINA, 60, 88000},
	{TYPE_GASOLINA, 60, 95000},
	{TYPE_GASOLINA, 60, 90000},
	{TYPE_GASOLINA, 60, 85000},
	{TYPE_AVG, 250, 250000},
	{TYPE_NULL, 0, 0},
	{TYPE_GASOLINA, 60, 88000},
	{TYPE_GASOLINA, 60, 55000},
	{TYPE_GASOLINA, 60, 70000},
	{TYPE_GASOLINA, 60, 30000},
	{TYPE_NULL, 0, 0},
	{TYPE_NULL, 0, 0},
	{TYPE_GASOLINA, 30, 8000},
	{TYPE_GASOLINA, 30, 3000},
	{TYPE_DIESEL, 150, 150000},
	{TYPE_GASOLINA, 60, 4000},
	{TYPE_GASOLINA, 60, 39000},
	{TYPE_GASOLINA, 60, 39000},
	{TYPE_AVG, 500, 1200000},
	{TYPE_DIESEL, 200, 70000},
	{TYPE_GASOLINA, 60, 54000},
	{TYPE_GASOLINA, 60, 33000},
	{TYPE_GASOLINA, 30, 45000},
	{TYPE_GASOLINA, 60, 100000},
	{TYPE_GASOLINA, 60, 15000},
	{TYPE_NULL, 0, 0},
	{TYPE_GASOLINA, 60, 39000},
	{TYPE_GASOLINA, 30, 35000},
	{TYPE_GASOLINA, 60, 65000},
	{TYPE_DIESEL, 100, 100000},
	{TYPE_GASOLINA, 60, 45000},
	{TYPE_NULL, 0, 0},
	{TYPE_NULL, 0, 0},
	{TYPE_AVG, 300, 110000},
	{TYPE_AVG, 150, 150000},
	{TYPE_NULL, 0, 0},
	{TYPE_DIESEL, 100, 100000},
	{TYPE_GASOLINA, 60, 90000},
	{TYPE_GASOLINA, 60, 90000},
	{TYPE_GASOLINA, 60, 90000},
	{TYPE_GASOLINA, 60, 90000},
	{TYPE_GASOLINA, 60, 45000},
	{TYPE_GASOLINA, 100, 90000},
	{TYPE_GASOLINA, 60, 60000},
	{TYPE_GASOLINA, 70, 120000},
	{TYPE_GASOLINA, 60, 45000},
	{TYPE_GASOLINA, 60, 45000},
	{TYPE_NULL, 0, 0},
	{TYPE_NULL, 0, 0},
	{TYPE_NULL, 0, 0},
	{TYPE_DIESEL, 100, 100000},
	{TYPE_NULL, 0, 0},
	{TYPE_NULL, 0, 0}
};

// ============================== [ FORWARDs ] ============================== //
forward UpdateVehicleStatus();


/*			includes files		*/
#include "../bin/modules/veiculos/callbacks.pwn"


// ============================== [ FUNCTIONs ] ============================== //
function VH::GetVehicleModelValor(model)
{
	if(model < 400 || model > 611)
		return 0;

	return VehicleInfo[model - 400][ValorConce];
}

function VH::SetVehicleFuel(vehicleid, Float:fuel)
{
	if(!IsValidVehicle(vehicleid))
		return false;

	Vehicle[vehicleid][Fuel] = fuel;
	return true;
}


Float:function VH::GetVehicleFuel(vehicleid)
{
	if(!IsValidVehicle(vehicleid))
		return Float:false;

	return Vehicle[vehicleid][Fuel];
}

stock GetVehicleMaxFuel(model){
	if(model < 400 || model > 611)
		return false;

	return VehicleInfo[model - 400][Capacidade];
}

function VH::GetVehicleFuelType(model)
{
	if(model < 400 || model > 611)
		return 0;

	return VehicleInfo[model - 400][Tipo];
}

function VH::GetVehicleValorFuel(model)
{
	if(model < 400 || model > 611)
		return 0;

	switch(call::VH->GetVehicleFuelType(model))
	{
		case TYPE_GASOLINA:
			return VALOR_GASOLINA;
		
		case TYPE_DIESEL:
			return VALOR_DIESEL;
		
		case TYPE_AVG:
			return VALOR_AVG;

		default:
			return 0;
	}
	return 0;
}

function VH::UpdateVehicleFuel(vehicleid) // chamado a cada 1 segundo
{
	if(IsBike(GetVehicleModel(vehicleid)))
		return true;

	Vehicle[vehicleid][UpTime]++;
	
	if(Vehicle[vehicleid][UpTime] > 15) // Atualizar a cada 15 segundos
	{
		Vehicle[vehicleid][UpTime] = 0;
		if(call::VH->GetVehicleFuel(vehicleid) > 0)
		{
			if ( GetVehicleDriverID(vehicleid) != INVALID_PLAYER_ID )
			{	
				switch( floatround(call::VH->GetVehicleFuel(vehicleid)) )
				{
					case 1..5, 10:
						SendClientMessage(GetVehicleDriverID(vehicleid), 0xFFFF00AA, "| COMBUSTÍVEL | Seu veículo está ficando sem combustível. Vá até um posto e abasteça!");
				}
			}

			call::VH->SetVehicleFuel(vehicleid, call::VH->GetVehicleFuel(vehicleid) - 0.33);
		}
		return true;
	}
	if(call::VH->GetVehicleFuel(vehicleid) <= 0)
		SetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE, VEHICLE_PARAMS_OFF);

	return true;
}

forward function VH::AbastecerVeiculo(playerid, vehicleid, quantidade);
public function VH::AbastecerVeiculo(playerid, vehicleid, quantidade)
{
	if ( !IsPlayerConnected(playerid) )
		return DeletePVar(playerid, "abastecendo"), TogglePlayerControllable(playerid, true), PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0);

	if( !IsPlayerInAnyVehicle(playerid) )
	{
		DeletePVar(playerid, "abastecendo");
		TogglePlayerControllable(playerid, true);
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você saiu do veiculo, e o abastecimento foi cancelado.");
		// PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0);
		return true;
	}

	if ( GetVehicleParams(vehicleid, VEHICLE_TYPE_ENGINE) == VEHICLE_PARAMS_ON )
	{
		DeletePVar(playerid, "abastecendo"), TogglePlayerControllable(playerid, true);
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode ligar o veiculo abastecendo.");
		return true;
	}

	if ( GetPlayerMoney(playerid) < call::VH->GetVehicleValorFuel(GetVehicleModel(vehicleid)) )
	{
		DeletePVar(playerid, "abastecendo");
		TogglePlayerControllable(playerid, true);
		SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não tem dinheiro para continuar abastecendo.");
		// PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0);
		return true;
	}

	--quantidade;
	call::VH->SetVehicleFuel(vehicleid, call::VH->GetVehicleFuel(vehicleid) + 1);
	GivePlayerMoney(playerid, -call::VH->GetVehicleValorFuel(GetVehicleModel(vehicleid)));
	
	if ( call::VH->GetVehicleFuel(vehicleid) >= GetVehicleMaxFuel(GetVehicleModel(vehicleid)) )
	{
		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}O Tanque do veiculo está cheio.");
		TogglePlayerControllable(playerid, true);
		DeletePVar(playerid, "abastecendo");
		//PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0);
		return true;
	}

	if ( quantidade <= 0 )
	{
		DeletePVar(playerid, "abastecendo");
		TogglePlayerControllable(playerid, true);
		//PlayerPlaySound(playerid, 6003, 0.0, 0.0, 0.0);
		SendClientMessage(playerid, COR_SISTEMA, "» {"COR_BRANCO_INC"}Veiculo abastecido com {"COR_VERDE_INC"}êxito{"COR_BRANCO_INC"}!");
		return true;
	}
	format(m_string, sizeof(m_string), "~r~abastecendo ~y~%d", quantidade);
	GameTextForPlayer(playerid, m_string, 300, 4);
	SetTimerEx("VH_AbastecerVeiculo", 500, false, "ddd", playerid, vehicleid, quantidade);
	return true;
}

stock IsWheels(componentid)
{
	switch(componentid)
	{
		case 1025, 1073..1085, 1096..1098:
			return true;
	}
	return false;
}

stock IsSpoiler(componentid)
{
	switch(componentid)
	{
		case 1000..1003, 1014..1016, 1023, 1049, 1050, 1058, 1061, 1138, 1139, 1146, 1147, 1158, 1162..1164:
			return true;
	}
	return false;
}

stock IsHydraulic(componentid)
{
	switch(componentid)
	{
		case 1087:
			return true;
	}
	return false;
}
stock IsNitro(componentid)
{
	switch(componentid)
	{
		case 1008..1010:
			return true;
	}
	return false;
}

stock IsBike(model)
{
	switch(model)
	{
		case 481, 509, 510:
			return true;
	}
	return false;
}

stock IsMoto(model)
{
	switch(model)
	{
		case 448, 461..463, 468, 471, 521..523, 581, 586:
			return true;
	}
	return false;
}

stock IsCar(model)
{
	switch(model)
	{
		case 400..402, 404..405, 410..413, 415, 418..422, 424, 426, 429, 436, 438, 439, 442, 445, 451, 457, 458, 459:
			return true;

		case  466, 467, 474, 475, 477, 479, 480, 482, 483, 489..492, 494..496, 500, 502..507, 516..518, 525, 527, 533..536:
			return true;
		
		case 540..543, 545..547, 550..552, 554, 555, 558..562, 565..567, 575, 576, 579, 580, 585, 587, 589, 596..600, 602..605:
			return true;
	}
	return false;
}

stock IsTruck(model)
{
	switch(model)
	{
		case 403, 406..408, 414, 416, 423, 427, 428, 431..433, 437, 443, 444, 455, 456, 486, 498, 499, 508, 514, 515, 524, 532:
			return true;

		case 544, 556, 557, 573, 578, 601, 609:
			return true;
	}
	return false;
}