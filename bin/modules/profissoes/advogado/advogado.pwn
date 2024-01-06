
#include <YSI_Coding\y_hooks>

hook OnGameModeInit()
{
	call::JOB->SetVehicleJob(CreateVehicle(405, 950.8460, 1725.4731, 8.4187, -90.0000, -1, -1, TIME_VEHICLE_SPAWN), ADVOGADO);
	call::JOB->SetVehicleJob(CreateVehicle(405, 950.8749, 1711.2153, 8.4187, -90.0000, -1, -1, TIME_VEHICLE_SPAWN), ADVOGADO);
	call::JOB->SetVehicleJob(CreateVehicle(405, 950.8158, 1714.7992, 8.4187, -90.0000, -1, -1, TIME_VEHICLE_SPAWN), ADVOGADO);
	call::JOB->SetVehicleJob(CreateVehicle(405, 957.4675, 1708.1051, 8.4187, 0.0000, -1, -1, TIME_VEHICLE_SPAWN), ADVOGADO);
	call::JOB->SetVehicleJob(CreateVehicle(405, 950.7984, 1721.9824, 8.4187, -90.0000, -1, -1, TIME_VEHICLE_SPAWN), ADVOGADO);
	call::JOB->SetVehicleJob(CreateVehicle(405, 950.9384, 1718.3280, 8.4187, -90.0000, -1, -1, TIME_VEHICLE_SPAWN), ADVOGADO);
	call::JOB->SetVehicleJob(CreateVehicle(405, 965.2034, 1708.1212, 8.4187,  0.0000, -1, -1, TIME_VEHICLE_SPAWN), ADVOGADO);
	call::JOB->SetVehicleJob(CreateVehicle(405, 961.3167, 1708.1132, 8.4187, 0.0000, -1, -1, TIME_VEHICLE_SPAWN), ADVOGADO);
	
	return Y_HOOKS_CONTINUE_RETURN_1;
}

CMD:soltar(playerid, params[])
{
	//if(!call::JOB->IsPlayerInWorking(playerid))
	//	return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está trabalhando para usar este comando.");

	if ( call::PLAYER->GetPlayerVarInt(playerid, Profissao) != ADVOGADO )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não é um Advogado para usar este comando.");

	if(IsPlayerInRangeOfPoint(playerid, 2.0, 248.7233, 67.9884, 1003.6406) || IsPlayerInRangeOfPoint(playerid, 2.0, 298.5375,178.8100,1007.1719) || IsPlayerInRangeOfPoint(playerid, 2.0, 246.5317,118.3733,1003.2188))
	{
		new id;
		if( sscanf(params, "u", id) )
			return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/soltar [playerid/username]");

		new valor = floatround(call::PLAYER->GetPlayerVarInt(id, TempoPreso) / 60) * 100;
		
		if(playerid == id) 
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode soltar si mesmo.");

		if ( call::PLAYER->GetPlayerVarInt(id, Preso) == SOLTO )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Este jogador não está Preso.");

		if ( call::PLAYER->GetPlayerVarInt(id, Preso) == PRESO_ADM )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Este jogador foi preso por um administrador.");

		if ( call::PLAYER->GetPlayerVarInt(id, AdvogadoID) != INVALID_PLAYER_ID )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Esse jogador(a) já tem um pedido pendente, por favor aguarde.");

		SendClientMessage(playerid, COR_LARANJA, "| SERVIÇOS | Você ofereceu seus serviços ao: {"COR_BRANCO_INC"}%s{"COR_LARANJA_INC"}.", GetUserName(id) );

		call::PLAYER->SetPlayerVarInt(id, AdvogadoID, playerid);
		call::PLAYER->SetPlayerVarInt(id, AdvogadoValor, valor);
		call::PLAYER->SetPlayerVarInt(playerid, PrisioneiroID, id);

		SetTimerEx("ExpirouYouCegoFdp", 30000, false, "i", id);

		SendClientMessage(id, COR_LARANJA, "O(A) advogado(a) {"COR_BRANCO_INC"}%s{"COR_LARANJA_INC"}, está oferecendo seus serviços {"COR_BRANCO_INC"}/aceitar servico{"COR_AVISO_INC"} ou {"COR_BRANCO_INC"}/recusar servico{"COR_AVISO_INC"}.", GetUserName(playerid));
		SendClientMessage(id, COR_LARANJA, "No valor de {"COR_VERDE_INC"}R$%s{"COR_LARANJA_INC"}.", RealStr(valor));
		return true;
	}
	SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não está em um Departamento de Polícia.");
	return true;
}

CMD:advogados(playerid, params[])
{
	new str[1045], count;
	foreach(new i: Player)
	{
		if ( call::PLAYER->GetPlayerVarInt(i, Profissao) == ADVOGADO )
		{
			format(str, sizeof(str), "%s[%d] - {"COR_AZUL_INC"}%s{"COR_BRANCO_INC"}\n", str, i, GetUserName(i));
			count++;
		}
	}
	if(count)
		return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "LISTA DE ADVOGADOS", str, "OK", "");

	SendClientMessage(playerid, COR_ERRO, "Não há nenhum Advogado online.");
	return true;
}

CMD:advogado(playerid, params[])
{
	new id, msg[100], str[128];

	if(sscanf(params, "us[100]", id, msg))
		return SendClientMessage(playerid, COR_ERRO, CMD_CORRECT_USE, "/soltar [playerid/username] [msg]");

	if(playerid == id) 
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Você não pode enviar mensagem para si mesmo.");

	if ( call::PLAYER->GetPlayerVarInt(id, Profissao) != ADVOGADO )
			return SendClientMessage(playerid, COR_ERRO, "| ERRO | Este jogador não é um Advogado.");

	format(str, sizeof(str), "Mensagem enviada para: {"COR_BRANCO_INC"}%s[%d]{"COR_AMARELO_INC"} | Assunto: %s",  GetUserName(id), id, msg);
    SendClientMessage(playerid, COR_AMARELO, str);
        
   	format(str, sizeof(str), "Mensagem recebida de: {"COR_BRANCO_INC"}%s[%d]{"COR_AMARELO_INC"} | Assunto: %s",  GetUserName(playerid), playerid, msg);
    SendClientMessage(id, COR_AMARELO, str);

	return true;
}

forward ExpirouYouCegoFdp(id);
public ExpirouYouCegoFdp(id)
{
	if ( call::PLAYER->GetPlayerVarInt(id, AdvogadoID) != INVALID_PLAYER_ID )
	{
		SendClientMessage(id, COR_AVISO, "* {"COR_BRANCO_INC"}Você demorou para responder e o serviço foi cancelado.");
		SendClientMessage(call::PLAYER->GetPlayerVarInt(id, AdvogadoID), COR_AVISO, "* {"COR_BRANCO_INC"}O(A) jogador(a) não respondeu o serviço e o mesmo foi cancelado.");
		
		call::PLAYER->SetPlayerVarInt(id, AdvogadoID, INVALID_PLAYER_ID);
		call::PLAYER->SetPlayerVarInt(id, AdvogadoValor, 0);
		call::PLAYER->SetPlayerVarInt(call::PLAYER->GetPlayerVarInt(id, AdvogadoID), PrisioneiroID, INVALID_PLAYER_ID);

		return true;
	}
	return true;
}
