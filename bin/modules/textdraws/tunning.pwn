#include <YSI_Coding\y_hooks>

new
	Text:wBase[4],
	PlayerText:wMenu[9],
	PlayerText:wMenuCores[11],
	PlayerText:wMenuRodas[11],
	PlayerText:wMenuPaintJobs[4],
	PlayerText:wMenuNitro[4],
	PlayerText:wMenuNeon[8]
;

enum neon_tuning
{
	NEON_DIREITO,
	NEON_ESQUERDO,
};
new bool:wTuning[MAX_PLAYERS];
new neon_add[MAX_VEHICLES][neon_tuning];

new	veiculoNome[][]=
{
    "Landstalker","Bravura","Buffalo","Linerunner","Pereniel","Sentinel","Dumper","Firetruck","Trashmaster",
    "Stretch","Manana","Infernus","Voodoo","Pony","Mule","Cheetah","Ambulancia","Leviathan","Moonbeam","Esperanto",
    "Taxi","Washington","Bobcat","Mr Whoopee","BF Injection","Hunter","Premier","Enforcer","Securicar","Banshee",
    "Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie","Stallion","Rumpo",
    "RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer",
    "Turismo","Speeder","Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer",
    "PCJ-600","Faggio","Freeway","RC Baron","RC Raider","Glendale","Oceanic","Sanchez","Sparrow","Patriot",
    "Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR-350","Walton","Regina","Comet","BMX",
    "Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo",
    "Greenwood","Jetmax","Hotring","Sandking","Blista Compact","Maverick Policial","Boxville","Benson","Mesa",
    "RC Goblin","Hotring Racer A","Hotring Racer B","Bloodring Banger","Rancher","Super GT","Elegant",
    "Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain","Nebula","Majestic",
    "Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona",
    "FBI Truck","Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight",
    "Streak","Vortex","Vincent","Bullet","Clover","Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob",
    "Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A","Monster B","Uranus",
    "Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight",
    "Trailer","Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford",
    "BF-400","Newsvan","Tug","Trailer A","Emperor","Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C",
    "Andromada","Dodo","RC Cam","Launch","Viatura (LSPD)","Viatura (SFPD)","Viatura (LVPD)","Police Ranger",
    "Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
    "Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};

TextDrawBase()
{
    wBase[0] = TextDrawCreate(529.000000, 60.000000+50, "_");
	TextDrawBackgroundColor(wBase[0], 255);
	TextDrawFont(wBase[0], 1);
	TextDrawLetterSize(wBase[0], 0.529999, 1.500000);
	TextDrawColor(wBase[0], -1);
	TextDrawSetOutline(wBase[0], 0);
	TextDrawSetProportional(wBase[0], 1);
	TextDrawSetShadow(wBase[0], 1);
	TextDrawUseBox(wBase[0], 1);
	TextDrawBoxColor(wBase[0], 7274495);
	TextDrawTextSize(wBase[0], 110.000000, 0.000000);
	TextDrawSetSelectable(wBase[0], 0);

	wBase[1] = TextDrawCreate(529.000000, 78.000000+50, "_");
	TextDrawBackgroundColor(wBase[1], 255);
	TextDrawFont(wBase[1], 1);
	TextDrawLetterSize(wBase[1], 0.529999, 1.500000);
	TextDrawColor(wBase[1], -1);
	TextDrawSetOutline(wBase[1], 0);
	TextDrawSetProportional(wBase[1], 1);
	TextDrawSetShadow(wBase[1], 1);
	TextDrawUseBox(wBase[1], 1);
	TextDrawBoxColor(wBase[1], 255);
	TextDrawTextSize(wBase[1], 110.000000, 0.000000);
	TextDrawSetSelectable(wBase[1], 0);

	wBase[2] = TextDrawCreate(289.000000, 96.000000+50, "_");
	TextDrawBackgroundColor(wBase[2], 255);
	TextDrawFont(wBase[2], 1);
	TextDrawLetterSize(wBase[2], 0.529999, 26.000001);
	TextDrawColor(wBase[2], -1);
	TextDrawSetOutline(wBase[2], 0);
	TextDrawSetProportional(wBase[2], 1);
	TextDrawSetShadow(wBase[2], 1);
	TextDrawUseBox(wBase[2], 1);
	TextDrawBoxColor(wBase[2], 150);
	TextDrawTextSize(wBase[2], 110.000000, 0.000000);
	TextDrawSetSelectable(wBase[2], 0);

	wBase[3] = TextDrawCreate(297.000000, 61.000000+50, "Tunagem");
	TextDrawBackgroundColor(wBase[3], -65281);
	TextDrawFont(wBase[3], 2);
	TextDrawLetterSize(wBase[3], 0.200000, 1.200000);
	TextDrawColor(wBase[3], -1);
	TextDrawSetOutline(wBase[3], 0);
	TextDrawSetProportional(wBase[3], 1);
	TextDrawSetShadow(wBase[3], 0);
	TextDrawSetSelectable(wBase[3], 0);

}
TextMenu(playerid)
{
    wMenu[0] = CreatePlayerTextDraw(playerid,123.000000, 61.000000+50, "veiculo:");
	PlayerTextDrawBackgroundColor(playerid,wMenu[0], 255);
	PlayerTextDrawFont(playerid,wMenu[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[0], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[0], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[0], 0);
	PlayerTextDrawSetSelectable(playerid,wMenu[0], 0);

	wMenu[1] = CreatePlayerTextDraw(playerid,512.000000, 61.000000+50, "x");
	PlayerTextDrawBackgroundColor(playerid,wMenu[1], 255);
	PlayerTextDrawFont(playerid,wMenu[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[1], 0);
	PlayerTextDrawUseBox(playerid,wMenu[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[1], 0);
	PlayerTextDrawTextSize(playerid,wMenu[1], 516.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[1], 0);

	wMenu[2] = CreatePlayerTextDraw(playerid,123.000000, 80.000000+50, "rodas");
	PlayerTextDrawBackgroundColor(playerid,wMenu[2], 255);
	PlayerTextDrawFont(playerid,wMenu[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[2], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[2], 0);
	PlayerTextDrawUseBox(playerid,wMenu[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[2], 0);
	PlayerTextDrawTextSize(playerid,wMenu[2], 170.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[2], 0);

	wMenu[3] = CreatePlayerTextDraw(playerid,177.000000, 80.000000+50, "cores");
	PlayerTextDrawBackgroundColor(playerid,wMenu[3], 255);
	PlayerTextDrawFont(playerid,wMenu[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[3], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[3], 0);
	PlayerTextDrawUseBox(playerid,wMenu[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[3], 0);
	PlayerTextDrawTextSize(playerid,wMenu[3], 204.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[3], 0);

	wMenu[4] = CreatePlayerTextDraw(playerid,228.000000, 80.000000+50, "paintjobs");
	PlayerTextDrawBackgroundColor(playerid,wMenu[4], 255);
	PlayerTextDrawFont(playerid,wMenu[4], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[4], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[4], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[4], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[4], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[4], 0);
	PlayerTextDrawUseBox(playerid,wMenu[4], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[4], 0);
	PlayerTextDrawTextSize(playerid,wMenu[4], 276.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[4], 0);

	wMenu[5] = CreatePlayerTextDraw(playerid,299.000000, 80.000000+50, "nitro");
	PlayerTextDrawBackgroundColor(playerid,wMenu[5], 255);
	PlayerTextDrawFont(playerid,wMenu[5], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[5], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[5], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[5], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[5], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[5], 0);
	PlayerTextDrawUseBox(playerid,wMenu[5], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[5], 0);
	PlayerTextDrawTextSize(playerid,wMenu[5], 324.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[5], 0);

	wMenu[6] = CreatePlayerTextDraw(playerid,346.000000, 80.000000+50, "neon");
	PlayerTextDrawBackgroundColor(playerid,wMenu[6], 255);
	PlayerTextDrawFont(playerid,wMenu[6], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[6], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[6], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[6], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[6], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[6], 0);
	PlayerTextDrawUseBox(playerid,wMenu[6], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[6], 0);
	PlayerTextDrawTextSize(playerid,wMenu[6], 374.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[6], 0);

	wMenu[7] = CreatePlayerTextDraw(playerid,391.000000, 80.000000+50, "suspensao");
	PlayerTextDrawBackgroundColor(playerid,wMenu[7], 255);
	PlayerTextDrawFont(playerid,wMenu[7], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[7], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[7], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[7], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[7], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[7], 0);
	PlayerTextDrawUseBox(playerid,wMenu[7], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[7], 0);
	PlayerTextDrawTextSize(playerid,wMenu[7], 444.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[7], 0);

	wMenu[8] = CreatePlayerTextDraw(playerid,461.000000, 80.000000+50, "auto_tunar");
	PlayerTextDrawBackgroundColor(playerid,wMenu[8], 255);
	PlayerTextDrawFont(playerid,wMenu[8], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[8], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[8], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[8], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[8], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[8], 0);
	PlayerTextDrawUseBox(playerid,wMenu[8], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[8], 0);
	PlayerTextDrawTextSize(playerid,wMenu[8], 516.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[8], 0);
	for(new i = 1; i < 9; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenu[i], true);
	/*------------------------------------------------------------------*/


	wMenuRodas[0] = CreatePlayerTextDraw(playerid,118.000000, 101.000000+50, "_______________________]_rodas_]");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[0], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[0], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[0], 255);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[0], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[0], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[0], -1);
	PlayerTextDrawTextSize(playerid,wMenuRodas[0], 281.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[0], 0);

	wMenuRodas[1] = CreatePlayerTextDraw(playerid,123.000000, 137.000000+50, "shadow");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[1], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[1], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[1], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[1], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[1], 0);

	wMenuRodas[2] = CreatePlayerTextDraw(playerid,123.000000, 155.000000+50, "mega");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[2], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[2], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[2], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[2], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[2], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[2], 0);

	wMenuRodas[3] = CreatePlayerTextDraw(playerid,123.000000, 172.000000+50, "rimshine");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[3], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[3], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[3], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[3], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[3], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[3], 0);

	wMenuRodas[4] = CreatePlayerTextDraw(playerid,123.000000, 191.000000+50, "wires");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[4], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[4], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[4], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[4], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[4], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[4], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[4], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[4], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[4], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[4], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[4], 0);

	wMenuRodas[5] = CreatePlayerTextDraw(playerid,123.000000, 211.000000+50, "classic");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[5], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[5], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[5], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[5], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[5], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[5], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[5], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[5], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[5], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[5], 282.000000, 10.000000+50);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[5], 0);

	wMenuRodas[6] = CreatePlayerTextDraw(playerid,123.000000, 230.000000+50, "twist");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[6], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[6], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[6], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[6], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[6], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[6], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[6], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[6], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[6], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[6], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[6], 0);

	wMenuRodas[7] = CreatePlayerTextDraw(playerid,123.000000, 250.000000+50, "cutter");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[7], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[7], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[7], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[7], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[7], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[7], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[7], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[7], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[7], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[7], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[7], 0);

	wMenuRodas[8] = CreatePlayerTextDraw(playerid,123.000000, 271.000000+50, "doller");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[8], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[8], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[8], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[8], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[8], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[8], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[8], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[8], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[8], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[8], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[8], 0);

	wMenuRodas[9] = CreatePlayerTextDraw(playerid,123.000000, 291.000000+50, "atomic");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[9], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[9], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[9], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[9], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[9], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[9], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[9], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[9], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[9], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[9], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[9], 0);

	wMenuRodas[10] = CreatePlayerTextDraw(playerid,123.000000, 310.000000+50, "virtual");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[10], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[10], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[10], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[10], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[10], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[10], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[10], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[10], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[10], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[10], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[10], 0);
    for(new i = 1; i < 11; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenuRodas[i], true);

	/*--------------------------------------------------------------------------------------------------------*/
	wMenuCores[0] = CreatePlayerTextDraw(playerid,118.000000, 101.000000+50, "_______________________]_cores_]");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[0], 255);
	PlayerTextDrawFont(playerid,wMenuCores[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[0], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[0], 255);
	PlayerTextDrawSetOutline(playerid,wMenuCores[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[0], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[0], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[0], -1);
	PlayerTextDrawTextSize(playerid,wMenuCores[0], 281.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[0], 0);

	wMenuCores[1] = CreatePlayerTextDraw(playerid,123.000000, 137.000000+50, "branco");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[1], 255);
	PlayerTextDrawFont(playerid,wMenuCores[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[1], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[1], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[1], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[1], 0);

	wMenuCores[2] = CreatePlayerTextDraw(playerid,123.000000, 155.000000+50, "azul");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[2], 255);
	PlayerTextDrawFont(playerid,wMenuCores[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[2], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[2], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[2], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[2], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[2], 0);

	wMenuCores[3] = CreatePlayerTextDraw(playerid,123.000000, 172.000000+50, "amarelo");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[3], 255);
	PlayerTextDrawFont(playerid,wMenuCores[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[3], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[3], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[3], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[3], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[3], 0);

	wMenuCores[4] = CreatePlayerTextDraw(playerid,123.000000, 191.000000+50, "roxo");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[4], 255);
	PlayerTextDrawFont(playerid,wMenuCores[4], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[4], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[4], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[4], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[4], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[4], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[4], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[4], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[4], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[4], 0);

	wMenuCores[5] = CreatePlayerTextDraw(playerid,123.000000, 211.000000+50, "verde");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[5], 255);
	PlayerTextDrawFont(playerid,wMenuCores[5], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[5], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[5], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[5], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[5], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[5], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[5], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[5], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[5], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[5], 0);

	wMenuCores[6] = CreatePlayerTextDraw(playerid,123.000000, 230.000000+50, "cinza");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[6], 255);
	PlayerTextDrawFont(playerid,wMenuCores[6], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[6], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[6], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[6], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[6], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[6], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[6], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[6], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[6], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[6], 0);

	wMenuCores[7] = CreatePlayerTextDraw(playerid,123.000000, 250.000000+50, "rosa");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[7], 255);
	PlayerTextDrawFont(playerid,wMenuCores[7], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[7], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[7], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[7], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[7], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[7], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[7], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[7], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[7], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[7], 0);

	wMenuCores[8] = CreatePlayerTextDraw(playerid,123.000000, 271.000000+50, "marrom");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[8], 255);
	PlayerTextDrawFont(playerid,wMenuCores[8], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[8], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[8], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[8], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[8], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[8], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[8], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[8], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[8], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[8], 0);

	wMenuCores[9] = CreatePlayerTextDraw(playerid,123.000000, 291.000000+50, "vermelho");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[9], 255);
	PlayerTextDrawFont(playerid,wMenuCores[9], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[9], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[9], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[9], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[9], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[9], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[9], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[9], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[9], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[9], 0);

	wMenuCores[10] = CreatePlayerTextDraw(playerid,123.000000, 310.000000+50, "laranja");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[10], 255);
	PlayerTextDrawFont(playerid,wMenuCores[10], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[10], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[10], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[10], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[10], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[10], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[10], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[10], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[10], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[10], 0);
	for(new i = 1; i < 11; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenuCores[i], true);

	/*------------------------------------------------------------------------*/
	wMenuPaintJobs[0] = CreatePlayerTextDraw(playerid,118.000000, 101.000000+50, "_______________________]_paintjobs_]");
	PlayerTextDrawBackgroundColor(playerid,wMenuPaintJobs[0], 255);
	PlayerTextDrawFont(playerid,wMenuPaintJobs[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenuPaintJobs[0], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuPaintJobs[0], 255);
	PlayerTextDrawSetOutline(playerid,wMenuPaintJobs[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenuPaintJobs[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenuPaintJobs[0], 0);
	PlayerTextDrawUseBox(playerid,wMenuPaintJobs[0], 1);
	PlayerTextDrawBoxColor(playerid,wMenuPaintJobs[0], -1);
	PlayerTextDrawTextSize(playerid,wMenuPaintJobs[0], 281.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuPaintJobs[0], 0);

	wMenuPaintJobs[1] = CreatePlayerTextDraw(playerid,123.000000, 137.000000+50, "paintjobs_1");
	PlayerTextDrawBackgroundColor(playerid,wMenuPaintJobs[1], 255);
	PlayerTextDrawFont(playerid,wMenuPaintJobs[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenuPaintJobs[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuPaintJobs[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenuPaintJobs[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenuPaintJobs[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenuPaintJobs[1], 0);
	PlayerTextDrawUseBox(playerid,wMenuPaintJobs[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenuPaintJobs[1], 0);
	PlayerTextDrawTextSize(playerid,wMenuPaintJobs[1], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuPaintJobs[1], 0);

	wMenuPaintJobs[2] = CreatePlayerTextDraw(playerid,123.000000, 155.000000+50, "paintjobs_2");
	PlayerTextDrawBackgroundColor(playerid,wMenuPaintJobs[2], 255);
	PlayerTextDrawFont(playerid,wMenuPaintJobs[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenuPaintJobs[2], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuPaintJobs[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenuPaintJobs[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenuPaintJobs[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenuPaintJobs[2], 0);
	PlayerTextDrawUseBox(playerid,wMenuPaintJobs[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenuPaintJobs[2], 0);
	PlayerTextDrawTextSize(playerid,wMenuPaintJobs[2], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuPaintJobs[2], 0);

	wMenuPaintJobs[3] = CreatePlayerTextDraw(playerid,123.000000, 172.000000+50, "paintjobs_3");
	PlayerTextDrawBackgroundColor(playerid,wMenuPaintJobs[3], 255);
	PlayerTextDrawFont(playerid,wMenuPaintJobs[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenuPaintJobs[3], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuPaintJobs[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenuPaintJobs[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenuPaintJobs[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenuPaintJobs[3], 0);
	PlayerTextDrawUseBox(playerid,wMenuPaintJobs[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenuPaintJobs[3], 0);
	PlayerTextDrawTextSize(playerid,wMenuPaintJobs[3], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuPaintJobs[3], 0);
	for(new i = 1; i < 4; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenuPaintJobs[i], true);

	/*----------------------------------------------------------------------*/
	wMenuNitro[0] = CreatePlayerTextDraw(playerid,118.000000, 101.000000+50, "_______________________]_nitro_]");
	PlayerTextDrawBackgroundColor(playerid,wMenuNitro[0], 255);
	PlayerTextDrawFont(playerid,wMenuNitro[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNitro[0], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNitro[0], 255);
	PlayerTextDrawSetOutline(playerid,wMenuNitro[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNitro[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNitro[0], 0);
	PlayerTextDrawUseBox(playerid,wMenuNitro[0], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNitro[0], -1);
	PlayerTextDrawTextSize(playerid,wMenuNitro[0], 281.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNitro[0], 0);

	wMenuNitro[1] = CreatePlayerTextDraw(playerid,123.000000, 137.000000+50, "nitro_x2");
	PlayerTextDrawBackgroundColor(playerid,wMenuNitro[1], 255);
	PlayerTextDrawFont(playerid,wMenuNitro[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNitro[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNitro[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNitro[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNitro[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNitro[1], 0);
	PlayerTextDrawUseBox(playerid,wMenuNitro[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNitro[1], 0);
	PlayerTextDrawTextSize(playerid,wMenuNitro[1], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNitro[1], 0);

	wMenuNitro[2] = CreatePlayerTextDraw(playerid,123.000000, 155.000000+50, "nitro_x5");
	PlayerTextDrawBackgroundColor(playerid,wMenuNitro[2], 255);
	PlayerTextDrawFont(playerid,wMenuNitro[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNitro[2], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNitro[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNitro[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNitro[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNitro[2], 0);
	PlayerTextDrawUseBox(playerid,wMenuNitro[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNitro[2], 0);
	PlayerTextDrawTextSize(playerid,wMenuNitro[2], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNitro[2], 0);

	wMenuNitro[3] = CreatePlayerTextDraw(playerid,123.000000, 172.000000+50, "nitro_x10");
	PlayerTextDrawBackgroundColor(playerid,wMenuNitro[3], 255);
	PlayerTextDrawFont(playerid,wMenuNitro[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNitro[3], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNitro[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNitro[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNitro[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNitro[3], 0);
	PlayerTextDrawUseBox(playerid,wMenuNitro[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNitro[3], 0);
	PlayerTextDrawTextSize(playerid,wMenuNitro[3], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNitro[3], 0);
	for(new i = 1; i < 4; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenuNitro[i], true);

	
	/*-----------------------------------------------------------------------*/
	wMenuNeon[0] = CreatePlayerTextDraw(playerid,118.000000, 101.000000+50, "_______________________]_neon_]");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[0], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[0], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[0], 255);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[0], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[0], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[0], -1);
	PlayerTextDrawTextSize(playerid,wMenuNeon[0], 281.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[0], 0);

	wMenuNeon[1] = CreatePlayerTextDraw(playerid,123.000000, 137.000000+50, "azul");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[1], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[1], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[1], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[1], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[1], 0);

	wMenuNeon[2] = CreatePlayerTextDraw(playerid,123.000000, 155.000000+50, "amarelo");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[2], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[2], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[2], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[2], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[2], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[2], 0);

	wMenuNeon[3] = CreatePlayerTextDraw(playerid,123.000000, 172.000000+50, "branco");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[3], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[3], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[3], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[3], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[3], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[3], 0);

	wMenuNeon[4] = CreatePlayerTextDraw(playerid,123.000000, 191.000000+50, "pink");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[4], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[4], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[4], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[4], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[4], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[4], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[4], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[4], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[4], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[4], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[4], 0);

	wMenuNeon[5] = CreatePlayerTextDraw(playerid,123.000000, 211.000000+50, "verde");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[5], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[5], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[5], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[5], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[5], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[5], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[5], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[5], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[5], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[5], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[5], 0);
	
	wMenuNeon[6] = CreatePlayerTextDraw(playerid,123.000000, 230.000000+50, "vermelho");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[6], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[6], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[6], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[6], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[6], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[6], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[6], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[6], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[6], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[6], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[6], 0);

	wMenuNeon[7] = CreatePlayerTextDraw(playerid,123.000000, 250.000000+50, "remover_neon");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[7], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[7], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[7], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[7], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[7], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[7], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[7], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[7], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[7], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[7], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[7], 0);
	
	for(new i = 1; i < 8; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenuNeon[i], true);

}

hook OnGameModeInit()
{
    TextDrawBase();
	return 1;
}

hook OnPlayerConnect(playerid)
{
	TextMenu(playerid);
	return 1;
}

GetVehicleModelEx(Model)
{
    switch(Model)
	{
        case 417, 425, 430, 432, 446, 447, 448, 452, 453, 454, 460,
			 461, 462, 463, 464, 465, 468, 469, 471, 472, 473, 476,
			 481, 484, 487, 488, 493, 497, 501, 509, 510, 511, 512,
			 513, 521, 522, 523, 548: return 0;
    }
    return true;
}


hook OP_ClickTextDraw(playerid, Text:clickedid)
{
    if(clickedid == Text:INVALID_TEXT_DRAW)
    {
        if(wTuning[playerid] == true)
        {
	        for(new u; u < sizeof(wBase); ++u) { TextDrawHideForPlayer(playerid, Text:wBase[u]); }
		    for(new u; u < sizeof(wMenu); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenu[u]); }
		    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
		    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
		    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
		    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
		    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
		    CancelSelectTextDraw(playerid);
            wTuning[playerid] = false;
		}
  	}
  	return 1;
}

hook OP_ClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    new wVeiculo = GetPlayerVehicleID(playerid);
	if(playertextid == wMenu[1])
	{
	    if(wTuning[playerid] == true)
        {
	        for(new u; u < sizeof(wBase); ++u) { TextDrawHideForPlayer(playerid, Text:wBase[u]); }
		    for(new u; u < sizeof(wMenu); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenu[u]); }
		    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
		    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
		    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
		    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
		    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
		    CancelSelectTextDraw(playerid);
		    wTuning[playerid] = false;
		}
	}

	if(playertextid == wMenu[2])
	{
	    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawShow(playerid, PlayerText:wMenuRodas[u]); }
	    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
	    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
	    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
	    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
	}
	
	if(playertextid == wMenu[3])
	{
	    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
	    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawShow(playerid, PlayerText:wMenuCores[u]); }
	    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
	    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
	    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
	}
	
	if(playertextid == wMenu[4])
	{
	    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
	    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
	    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawShow(playerid, PlayerText:wMenuPaintJobs[u]); }
	    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
	    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
	}
	
	if(playertextid == wMenu[5])
	{
	    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
	    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
	    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
	    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawShow(playerid, PlayerText:wMenuNitro[u]); }
	    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
	}
	
	if(playertextid == wMenu[6])
	{
	    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
	    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
	    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
	    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
	    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawShow(playerid, PlayerText:wMenuNeon[u]); }
	}
	
	if(playertextid == wMenu[7]) AddVehicleComponent(wVeiculo,1087);

	if(playertextid == wMenuRodas[1]) AddVehicleComponent(wVeiculo,1073);         // SHADOW
    if(playertextid == wMenuRodas[2]) AddVehicleComponent(wVeiculo, 1074);        // MEGA
    if(playertextid == wMenuRodas[3]) AddVehicleComponent(wVeiculo,1075);         // RINSHIME
    if(playertextid == wMenuRodas[4]) AddVehicleComponent(wVeiculo,1076);         // WIRES
    if(playertextid == wMenuRodas[5]) AddVehicleComponent(wVeiculo,1077);         // CLASSIC
    if(playertextid == wMenuRodas[6]) AddVehicleComponent(wVeiculo,1078);         // TWIST
    if(playertextid == wMenuRodas[7]) AddVehicleComponent(wVeiculo,1079);         // CUTTER
    if(playertextid == wMenuRodas[8]) AddVehicleComponent(wVeiculo,1083);         // DOLLAR
    if(playertextid == wMenuRodas[9]) AddVehicleComponent(wVeiculo,1085);         // ATOMIC
    if(playertextid == wMenuRodas[10]) AddVehicleComponent(wVeiculo,1097);        // VIRTUAL
    
    if(playertextid == wMenuCores[1]) ChangeVehicleColor(wVeiculo, 1, 1);         // BRANCO
    if(playertextid == wMenuCores[2]) ChangeVehicleColor(wVeiculo, 79, 79);       // AZUL
    if(playertextid == wMenuCores[3]) ChangeVehicleColor(wVeiculo, 194, 194);     // AMARELO
    if(playertextid == wMenuCores[4]) ChangeVehicleColor(wVeiculo, 211, 211);     // ROXO
    if(playertextid == wMenuCores[5]) ChangeVehicleColor(wVeiculo, 137, 137);     // VERDE
    if(playertextid == wMenuCores[6]) ChangeVehicleColor(wVeiculo, 75, 75);       // CINZA
    if(playertextid == wMenuCores[7]) ChangeVehicleColor(wVeiculo, 136, 136);     // ROSA
    if(playertextid == wMenuCores[8]) ChangeVehicleColor(wVeiculo, 129, 129);     // MARROM
    if(playertextid == wMenuCores[9]) ChangeVehicleColor(wVeiculo, 3, 3);         // VERMELHO
    if(playertextid == wMenuCores[10]) ChangeVehicleColor(wVeiculo, 158, 158);    // LARANJA
    
    if(playertextid == wMenuPaintJobs[1])  ChangeVehiclePaintjob(wVeiculo, 0);    // PAINTJOBS 1
    if(playertextid == wMenuPaintJobs[2])   ChangeVehiclePaintjob(wVeiculo, 1);   // PAINTJOBS 2
    if(playertextid == wMenuPaintJobs[3])   ChangeVehiclePaintjob(wVeiculo, 2);   // PAINTJOBS 3
    
    if(playertextid == wMenuNitro[1])      AddVehicleComponent(wVeiculo,1009);    // NITRO 1
    if(playertextid == wMenuNitro[2])      AddVehicleComponent(wVeiculo,1008);    // NITRO 2
    if(playertextid == wMenuNitro[3])      AddVehicleComponent(wVeiculo,1010);    // NITRO 3
    
    if(playertextid == wMenuNeon[1])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18648, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18648, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
    }
    
    if(playertextid == wMenuNeon[2])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18650, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18650, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
    }
    
    if(playertextid == wMenuNeon[3])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18652, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18652, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
    }
    
    if(playertextid == wMenuNeon[4])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18651, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18651, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
		
    }
    
    if(playertextid == wMenuNeon[5])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18649, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18649, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	}
	
    if(playertextid == wMenuNeon[6])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18647, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18647, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
    }
    
    if(playertextid == wMenuNeon[7])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
    }
    
    if(playertextid == wMenu[8])
    {
 		switch(GetVehicleModel(wVeiculo))
		{
		    case 483:
		    {
		      	AddVehicleComponent(wVeiculo,1027);
	            ChangeVehiclePaintjob(wVeiculo, 0);
	            AddVehicleComponent(wVeiculo,1010);
	            AddVehicleComponent(wVeiculo,1079);
	            AddVehicleComponent(wVeiculo,1087);
		    }
		    case 562:
		    {
		  		AddVehicleComponent(wVeiculo,1046);
	            AddVehicleComponent(wVeiculo,1171);
	            AddVehicleComponent(wVeiculo,1149);
	            AddVehicleComponent(wVeiculo,1035);
	            AddVehicleComponent(wVeiculo,1147);
	            AddVehicleComponent(wVeiculo,1036);
	            AddVehicleComponent(wVeiculo,1040);
	            ChangeVehiclePaintjob(wVeiculo, 2);
	            ChangeVehicleColor(wVeiculo, 6, 6);
	            AddVehicleComponent(wVeiculo,1010);
	            AddVehicleComponent(wVeiculo,1079);
	            AddVehicleComponent(wVeiculo,1087);
		  	}
		  	case 560:
		  	{
		  	   	AddVehicleComponent(wVeiculo,1028);
	            AddVehicleComponent(wVeiculo,1169);
	            AddVehicleComponent(wVeiculo,1141);
	            AddVehicleComponent(wVeiculo,1032);
	            AddVehicleComponent(wVeiculo,1138);
	            AddVehicleComponent(wVeiculo,1026);
	            AddVehicleComponent(wVeiculo,1027);
	            ChangeVehiclePaintjob(wVeiculo, 2);
	            AddVehicleComponent(wVeiculo,1010);
	            AddVehicleComponent(wVeiculo,1079);
	            AddVehicleComponent(wVeiculo,1087);
		  	}
		  	case 565:
		  	{
		        AddVehicleComponent(wVeiculo,1046);
		        AddVehicleComponent(wVeiculo,1153);
		        AddVehicleComponent(wVeiculo,1150);
		        AddVehicleComponent(wVeiculo,1054);
		        AddVehicleComponent(wVeiculo,1049);
		        AddVehicleComponent(wVeiculo,1047);
		        AddVehicleComponent(wVeiculo,1051);
		        AddVehicleComponent(wVeiculo,1010);
		        AddVehicleComponent(wVeiculo,1079);
		        AddVehicleComponent(wVeiculo,1087);
		        ChangeVehiclePaintjob(wVeiculo, 2);
		  	}
		  	case 559:
		  	{
		  	    AddVehicleComponent(wVeiculo,1065);
	            AddVehicleComponent(wVeiculo,1160);
	            AddVehicleComponent(wVeiculo,1159);
	            AddVehicleComponent(wVeiculo,1067);
	            AddVehicleComponent(wVeiculo,1162);
	            AddVehicleComponent(wVeiculo,1069);
	            AddVehicleComponent(wVeiculo,1071);
	            AddVehicleComponent(wVeiculo,1010);
	            AddVehicleComponent(wVeiculo,1079);
	            AddVehicleComponent(wVeiculo,1087);
	            ChangeVehiclePaintjob(wVeiculo, 1);
		  	}
		  	case 561:
		  	{
		        AddVehicleComponent(wVeiculo,1064);
		        AddVehicleComponent(wVeiculo,1155);
		        AddVehicleComponent(wVeiculo,1154);
		        AddVehicleComponent(wVeiculo,1055);
		        AddVehicleComponent(wVeiculo,1158);
		        AddVehicleComponent(wVeiculo,1056);
		        AddVehicleComponent(wVeiculo,1062);
		        AddVehicleComponent(wVeiculo,1010);
		        AddVehicleComponent(wVeiculo,1079);
		        AddVehicleComponent(wVeiculo,1087);
		        ChangeVehiclePaintjob(wVeiculo, 2);
		  	}
		  	case 558:
		  	{
		  	   	AddVehicleComponent(wVeiculo,1089);
		        AddVehicleComponent(wVeiculo,1166);
		        AddVehicleComponent(wVeiculo,1168);
		        AddVehicleComponent(wVeiculo,1088);
		        AddVehicleComponent(wVeiculo,1164);
		        AddVehicleComponent(wVeiculo,1090);
		        AddVehicleComponent(wVeiculo,1094);
		        AddVehicleComponent(wVeiculo,1010);
		        AddVehicleComponent(wVeiculo,1079);
		        AddVehicleComponent(wVeiculo,1087);
		        ChangeVehiclePaintjob(wVeiculo, 2);
		  	}
		  	case 575:
		  	{
		        AddVehicleComponent(wVeiculo,1044);
		        AddVehicleComponent(wVeiculo,1174);
		        AddVehicleComponent(wVeiculo,1176);
		        AddVehicleComponent(wVeiculo,1042);
		        AddVehicleComponent(wVeiculo,1099);
		        AddVehicleComponent(wVeiculo,1010);
		        AddVehicleComponent(wVeiculo,1079);
		        AddVehicleComponent(wVeiculo,1087);
		        ChangeVehiclePaintjob(wVeiculo, 0);
		  	}
		  	case 534:
		  	{
	            AddVehicleComponent(wVeiculo,1126);
	            AddVehicleComponent(wVeiculo,1179);
	            AddVehicleComponent(wVeiculo,1180);
	            AddVehicleComponent(wVeiculo,1122);
	            AddVehicleComponent(wVeiculo,1101);
	            AddVehicleComponent(wVeiculo,1125);
	            AddVehicleComponent(wVeiculo,1123);
	            AddVehicleComponent(wVeiculo,1100);
	            AddVehicleComponent(wVeiculo,1010);
	            AddVehicleComponent(wVeiculo,1079);
	            AddVehicleComponent(wVeiculo,1087);
	            ChangeVehiclePaintjob(wVeiculo, 2);
		  	}
		  	case 536:
		  	{
		        AddVehicleComponent(wVeiculo,1104);
		        AddVehicleComponent(wVeiculo,1182);
		        AddVehicleComponent(wVeiculo,1184);
		        AddVehicleComponent(wVeiculo,1108);
		        AddVehicleComponent(wVeiculo,1107);
		        AddVehicleComponent(wVeiculo,1010);
		        AddVehicleComponent(wVeiculo,1079);
		        AddVehicleComponent(wVeiculo,1087);
		        ChangeVehiclePaintjob(wVeiculo, 1);
		  	}
		  	case 567:
		  	{
		  	    AddVehicleComponent(wVeiculo,1129);
	            AddVehicleComponent(wVeiculo,1189);
	            AddVehicleComponent(wVeiculo,1187);
	            AddVehicleComponent(wVeiculo,1102);
	            AddVehicleComponent(wVeiculo,1133);
	            AddVehicleComponent(wVeiculo,1010);
	            AddVehicleComponent(wVeiculo,1079);
	            AddVehicleComponent(wVeiculo,1087);
	            ChangeVehiclePaintjob(wVeiculo, 2);
		  	}
		  	case 420:
		  	{
		  	   	AddVehicleComponent(wVeiculo,1010);
	            AddVehicleComponent(wVeiculo,1087);
	            AddVehicleComponent(wVeiculo,1079);
	            AddVehicleComponent(wVeiculo,1139);
		  	}
		  	case 400:
		  	{
		  	    AddVehicleComponent(wVeiculo,1010);
	            AddVehicleComponent(wVeiculo,1087);
	            AddVehicleComponent(wVeiculo,1018);
	            AddVehicleComponent(wVeiculo,1013);
	            AddVehicleComponent(wVeiculo,1079);
	            AddVehicleComponent(wVeiculo,1086);
		  	}
		  	case 401:
		  	{
			  	AddVehicleComponent(wVeiculo,1086);
	            AddVehicleComponent(wVeiculo,1139);
	            AddVehicleComponent(wVeiculo,1079);
	            AddVehicleComponent(wVeiculo,1010);
	            AddVehicleComponent(wVeiculo,1087);
	            AddVehicleComponent(wVeiculo,1012);
	            AddVehicleComponent(wVeiculo,1013);
	            AddVehicleComponent(wVeiculo,1042);
	            AddVehicleComponent(wVeiculo,1043);
	            AddVehicleComponent(wVeiculo,1018);
	            AddVehicleComponent(wVeiculo,1006);
	            AddVehicleComponent(wVeiculo,1007);
	            AddVehicleComponent(wVeiculo,1017);
        	}
        	case 576:
        	{
	        	ChangeVehiclePaintjob(wVeiculo,2);
	            AddVehicleComponent(wVeiculo,1191);
	            AddVehicleComponent(wVeiculo,1193);
	            AddVehicleComponent(wVeiculo,1010);
	            AddVehicleComponent(wVeiculo,1018);
	            AddVehicleComponent(wVeiculo,1079);
	            AddVehicleComponent(wVeiculo,1087);
	            AddVehicleComponent(wVeiculo,1134);
	            AddVehicleComponent(wVeiculo,1137);
        	}
			default:
			{
			 	AddVehicleComponent(wVeiculo,1010);
	            AddVehicleComponent(wVeiculo,1079);
	            AddVehicleComponent(wVeiculo,1087);
			}
		}
    }
    return 1;
}

hook OnVehicleSpawn(vehicleid)
{
	new wVeiculo = vehicleid;

	DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
	return 1;
}