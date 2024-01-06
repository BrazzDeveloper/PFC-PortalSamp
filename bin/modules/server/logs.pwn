#include <YSI_Coding\y_hooks>

// Log types
enum
{
	LOG_ANTI_CHEAT,
	LOG_ADMIN_CMD
}

// Vars
new DCC_Channel:g_Logs;

// Callbacks
hook OnGameModeInit()
{
	// MySQL
	mysql_query(getConexao(), "CREATE TABLE IF NOT EXISTS `logs`(ID int NOT NULL PRIMARY KEY AUTO_INCREMENT, Date varchar(32) NOT NULL default '-', LogType int(11) NOT NULL default '-1', Log varchar(256) NOT NULL default '-')");

	// Channels
	//g_Logs = DCC_FindChannelById("801468152675696670");
	return 1;
}

// Stocks
CreateLogTimestamp()
{
	new str[32], day, month, year, hour, minute, second;
	getdate(year, month, day);
	gettime(hour, minute, second);
	format(str, sizeof(str), "%02d/%02d/%04d %02d:%02d:%02d", day, month, year, hour, minute, second);
	return str;
}

CreateLog(log_type, const log[])
{
	new day, month, year, hour, minute, second, query[256];

	gettime(hour, minute, second);
	getdate(year, month, day);

	mysql_format(getConexao(), query, sizeof(query), "INSERT INTO `logs`(`Date`, `LogType`, `Log`) VALUES ('%02d/%02d/%04d %02d:%02d:%02d', '%d', '%s')", day, month, year, hour, minute, second, log_type, log);
	mysql_query(getConexao(), query);
	return 1;
}

ShowDiscordLog(DCC_Channel:channelID, log_type)
{
	new DCC_Embed:l_Embed, l_LogDate[32], l_Log[256], l_Rows, l_BigStr[1612], query[256], String[560];

	mysql_format(getConexao(), query, sizeof(query), "SELECT * FROM `logs` WHERE `LogType` = '%d' ORDER BY ID DESC LIMIT 20", log_type);
	mysql_query(getConexao(), query);

	cache_get_row_count(l_Rows);

	l_Embed = DCC_CreateEmbed();

	if(l_Rows > 0)
	{
		format(l_BigStr, sizeof(l_BigStr), "Resultados (max. 20) em ordem decrescente de hora e data:%c%c", 0xA, 0xD);

		for(new i = 0; i < l_Rows; i++)
		{
			cache_get_value_name(i, "Date", l_LogDate, 32);
			cache_get_value_name(i, "Log", l_Log, 256);

			format(String, sizeof(String), "**`[%s]`** %s%c", l_LogDate, l_Log, 0xA);
			strcat(l_BigStr, String);
		}

		DCC_SetEmbedTitle(l_Embed, "**Log**");
		DCC_SetEmbedDescription(l_Embed, l_BigStr);
		DCC_SetEmbedColor(l_Embed, 16776960);
	}
	else
	{
		DCC_SetEmbedDescription(l_Embed, "Nenhum resultado obtido.");
		DCC_SetEmbedColor(l_Embed, 16711680);
	}

	DCC_SendChannelEmbedMessage(channelID, l_Embed);
	return 1;
}

ShowDiscordLogEx(DCC_Channel:channelID, log_type, const search_message[])
{
	new DCC_Embed:l_Embed, l_LogDate[32], l_Log[256], l_Rows, l_Count, l_BigStr[1612], query[256], String[560];

	mysql_format(getConexao(), query, sizeof(query), "SELECT * FROM `logs` WHERE `LogType` = '%d' ORDER BY ID DESC LIMIT 20", log_type);
	mysql_query(getConexao(), query);

	cache_get_row_count(l_Rows);

	l_Embed = DCC_CreateEmbed();
	format(l_BigStr, sizeof(l_BigStr), "Resultados (max. 20) em ordem decrescente de hora e data:%c%c", 0xA, 0xD);

	for(new i = 0; i < l_Rows; i++)
	{
		cache_get_value_name(i, "Date", l_LogDate, 32);
		cache_get_value_name(i, "Log", l_Log, 256);

		if(strfind(l_Log, search_message, true) != -1)
		{
			l_Count ++;
			format(String, sizeof(String), "**`[%s]`** %s%c", l_LogDate, l_Log, 0xA);
			strcat(l_BigStr, String);
		}
	}

	if(l_Count > 0)
	{
		DCC_SetEmbedDescription(l_Embed, l_BigStr);
		DCC_SetEmbedTitle(l_Embed, "**Log**");
		DCC_SetEmbedDescription(l_Embed, l_BigStr);
		DCC_SetEmbedColor(l_Embed, 16776960);
	}
	else
	{
		DCC_SetEmbedDescription(l_Embed, "Nenhum resultado obtido.");
		DCC_SetEmbedColor(l_Embed, 16711680);
	}

	DCC_SendChannelEmbedMessage(channelID, l_Embed);
	return 1;
}