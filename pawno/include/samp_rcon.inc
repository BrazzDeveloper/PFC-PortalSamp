#if defined samp_rcon_included
	#endinput
#endif
#define samp_rcon_included
#if !defined socket_included
	#error You need socket.inc
#endif

/** @type {number} */
#define INC_SEND_PORT			(5001)
/** @type {number} */
#define INC_RECEIVE_PORT		(5002)

/** @type {number} */
#define MAX_LOGIN_ATTEMPTS		(5)
/** @type {number} */
#define LISTEN_DELAY			(5) // Minuto(s)

/** @type {object} */
static Socket: receiveSocket;
/** @type {object} */
static Socket: sendSocket;
/** @type {boolean} */
static bool:isAllowed;
/** @type {number} */
static attemptsCount;

/**
 *
 * Callback called when data are sent to client by server
 *
 * @param {string} cmd - Command sent by client (required)
 * @param {number} id - Numeric identifier (optional)
 * @param {string} args -  Optional arguments to the command (optional) 
 *
 */
forward OnSRconCmdReceived(cmd[], id, args[]);

/**
 *
 * Callback called in server initialization
 *
 */
public OnGameModeInit()
{
	new ret = 1;

	if (funcidx("SRCON_OnGameModeInit") != -1)
		ret = CallLocalFunction("SRCON_OnGameModeInit", "");
	
	receiveSocket = socket_create(TCP);
	socket_listen(receiveSocket, INC_RECEIVE_PORT);
	socket_set_max_connections(receiveSocket, 1);

	return ret;
}
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit SRCON_OnGameModeInit
forward SRCON_OnGameModeInit();

/**
 *
 * Callback called when data has been received by client
 *
 * @param {object} id - Socket ID
 * @param {number} remote_clientid - Remote ID of socket client
 * @param {string} data - Data sent to the server by client
 * @param {number}  Data length of the data sent to client by server
 *
 */
public onSocketReceiveData(Socket:id, remote_clientid, data[], data_len)
{
	if(isAllowed)
	{
		new _cmd[50], tmpPlayerid[6], _id, _args[50], idx, idx2;

		idx = strfind(data, "|", true, 0);
		strmid(_cmd, data, 0, idx);

		idx2 = strfind(data, "|", true, idx+1);
		strmid(tmpPlayerid, data, idx+1, idx2);
		_id = strval(tmpPlayerid);

		strmid(_args, data, idx2+1, strlen(data));

		OnSRconCmdReceived(_cmd, _id, _args);
	}
	else
	{
		static buffer[100], string[100];

		GetServerVarAsString("rcon_password", buffer, sizeof buffer);

		if(strcmp(buffer, data, false) == 0)
		{
			attemptsCount = 0;
			isAllowed = true;

			print("[SAMP-RCON] Valid password.");

			socket_send(sendSocket, "RCON_1.\r\n", 11);
		}
		else
		{
			attemptsCount ++;

			printf("[SAMP-RCON] Invalid password. (%d/%d)", attemptsCount, MAX_LOGIN_ATTEMPTS);

			socket_send(sendSocket, "RCON_0.\r\n", 11);

			if(attemptsCount >= MAX_LOGIN_ATTEMPTS)
			{
				printf("[SAMP-RCON] Exceeded attempts count. (%d/%d)", attemptsCount, MAX_LOGIN_ATTEMPTS);
				printf("[SAMP-RCON] For security reasons the connection will be invalid for %d minute(s)", LISTEN_DELAY);

				attemptsCount = 0;

				format(string, sizeof string, "For security reasons the connection will be invalid for %d minute(s).\r\n", LISTEN_DELAY);
				socket_send(sendSocket, "Exceeded attempts count.\r\n", 28);
				socket_send(sendSocket, string, sizeof string);

				socket_close_remote_client(receiveSocket, remote_clientid);
				socket_stop_listen(receiveSocket);

				SetTimer("ListenSocket", LISTEN_DELAY * 60 * 1000, false);
			}
		}
	}

	return true;
}

/**
 *
 * Callback chamada toda vez que o cliente se conecta ao servidor
 *
 * @param {object} id - ID do socket
 * @param {string} remote_client - IP do cliente socket
 * @param {number} remote_clientid - ID remoto do cliente socket
 *
 */
public onSocketRemoteConnect(Socket:id, remote_client[], remote_clientid)
{
	sendSocket = socket_create(TCP);
	socket_connect(sendSocket, remote_client, INC_SEND_PORT);

	printf("\n__________________________________________________________________\n[SAMP-RCON] O endereço %s está tentando se conectar remotamente.", remote_client);

	return true;
}

/**
 *
 * Callback chamada toda vez que o cliente se desconecta do servidor
 *
 * @param {object} id - ID do socket
 * @param {number} remote_clientid - ID remoto do cliente socket
 *
 */
public onSocketRemoteDisconnect(Socket:id, remote_clientid)
{
	if(isAllowed)
	{
		isAllowed = false;
		print("\n__________________________________________________________________\n[SAMP-RCON] O cliente se desconectou.");
	}
	else
		print("\n__________________________________________________________________\n[SAMP-RCON] O cliente não autorizado foi desconectado.");

	return true;
}

/**
 *
 * Callback chamada através do temporizador para desbloquear o acesso ao socket
 *
 */
forward ListenSocket();
public ListenSocket()
{
	receiveSocket = socket_create(TCP);
	socket_listen(receiveSocket, INC_RECEIVE_PORT);
	socket_set_max_connections(receiveSocket, 1);

	print("\n__________________________________________________________________\n[SAMP-RCON] O socket foi liberado para conexões externas após o bloqueio.");

	return true;
}

/**
 *
 * Stock chamada para enviar dados ao cliente
 *
 * @param {string} data - Dados enviados ao cliente
 *
 */
stock SRCON_SendSocketData(data[100])
{
	static string[sizeof data];
	format(string, sizeof string, "%s\r\n", data);

	if(is_socket_valid(sendSocket))
		socket_send(sendSocket, string, strlen(data));

	return true;
}
