#include <discord-connector>

new DCC_Channel:tester_Discord_Chat;
new DCC_Guild:gtoguild;
new DCC_Channel:admin_Discord_Chat;
new DCC_Channel:cmdlogs_Discord_Chat;
new DCC_Channel:cmdexecute_Discord_Chat;
new DCC_Channel:cmdann_Discord_Chat;
new DCC_Channel:serverecho_Discord_Chat;
new DCC_Role:developer_role;
//new DCC_Role:betatester_role;
//new DCC_Role:headadmin_role;
//new DCC_Role:senioradmin_role;
//new DCC_Role:generaladmin_role;
//new DCC_Role:junioradmin_role;
//new DCC_Role:muted_role;

hook OnGameModeInit()
{
    gtoguild = DCC_FindGuildById("737741848021434368");
    developer_role = DCC_FindRoleById("739415440463495248");
//    betatester_role = DCC_FindRoleById("708698026243260516");
//    headadmin_role = DCC_FindRoleById("706039178701307954");
//    senioradmin_role = DCC_FindRoleById("706039662640234558");
//    generaladmin_role = DCC_FindRoleById("706039933688873011");
//    junioradmin_role = DCC_FindRoleById("706040215265083432");
//    muted_role = DCC_FindRoleById("731184433306271806");
    tester_Discord_Chat = DCC_FindChannelById("762757280449036289");
    admin_Discord_Chat = DCC_FindChannelById("739420621523386410");
    cmdlogs_Discord_Chat = DCC_FindChannelById("801468152675696670");
    cmdexecute_Discord_Chat = DCC_FindChannelById("801468152675696672");
    cmdann_Discord_Chat = DCC_FindChannelById("739422369193525338");
    serverecho_Discord_Chat = DCC_FindChannelById("751150529748664500");
}