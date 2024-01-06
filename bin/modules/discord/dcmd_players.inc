#include <discord-connector>
#include "../bin/modules/discord/discord_channels"
#include "../bin/modules/discord/dccs"

DCCMD:players(DCC_Channel:channel, DCC_User:user, const params[])
{
    new onlineplayers = 0,
    string[251];
    if(channel != serverecho_Discord_Chat) {
        return DCC_SendChannelMessage(channel, "ERRO: Você só pode usar este comando em #chat-geral");
    }
    foreach(new i : Player)
    {
        if(IsPlayerConnected(i))
        {
            format(string, sizeof(string), "%p (%d)", i, i);
            DCC_SendChannelMessage(channel, string);
            onlineplayers++;
        }
    }
    if(onlineplayers == 0) {
        DCC_SendChannelMessage(channel, "Não tem ninguém online.");
    }
    else if(onlineplayers != 0) {
        format(string, sizeof(string), "Estão atualmente %d players online.", onlineplayers);
        DCC_SendChannelMessage(channel, string);
    }
    return 1;
}