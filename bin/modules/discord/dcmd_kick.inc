#include <discord-connector>
#include "../bin/modules/discord/discord_channels"
#include "../bin/modules/discord/dccs"

DCCMD:kickarserver(DCC_Channel:channel, DCC_User:user, const params[])
{
    new 
        target,
        string[128],
        reason[128];
    if(channel != cmdexecute_Discord_Chat) {
        return 0;
    }
    if(sscanf(params, "us[128]", target, reason)) return DCC_SendChannelMessage(cmdexecute_Discord_Chat, "```!kickarserver (name/id) (reason)```");
    if(!IsPlayerConnected(target)) return DCC_SendChannelMessage(cmdexecute_Discord_Chat, "```Jogador(a) não conectado(a)```");
    SendMsgAllF(COR_ERRO, "[Betinho]: %p (%d) foi kickado por %s", target, target, reason);
    format(string, sizeof(string), "Você kickou o(a9) %p (%d)", target, target);
    DCC_SendChannelMessage(cmdexecute_Discord_Chat, string);
    defer KickTimer(target);
    return 1;
}