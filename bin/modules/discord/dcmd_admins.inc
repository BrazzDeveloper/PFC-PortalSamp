#include <discord-connector>
//#include <discord_channels>
#include "../bin/modules/discord/discord_channels"
#include "../bin/modules/discord/dccs"

DCCMD:admins(DCC_Channel:channel, DCC_User:user, const params[])
{
    new
        string[128],
        onlineadmins = 0,
        admin;

    new Cache:cache = mysql_query(getConexao(), "SELECT `username`,`admin` FROM "TABLE_USERS" WHERE `admin`>'0' ORDER BY `admin` DESC;");
    if(channel != tester_Discord_Chat) {
        return 0;
    }
    foreach(new i : Player)
    {
        if(i != INVALID_PLAYER_ID)
        {
            cache_get_value_name_int(i, "admin", admin);
            if(call::ADMIN->GetPlayerAdminLevel(i) > 0)
            {
                format(string, sizeof(string), "Admin:%p (%d) Cargo:%s", i, i, call::ADMIN->CargoAdmin(admin, true));
                DCC_SendChannelMessage(tester_Discord_Chat, string);
                onlineadmins++;
            }
        }
    }
    if(onlineadmins == 0)
    {
        DCC_SendChannelMessage(tester_Discord_Chat, "No Admins online");
    }
    return 1;
}