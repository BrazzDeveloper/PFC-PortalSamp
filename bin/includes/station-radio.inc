
const 
	MAX_STATION_NAME = 60,
	MAX_STATION_URL = 100
;

enum e_STATION_INFO
{
	Nome[MAX_STATION_NAME],
	Url[MAX_STATION_URL]
}
static stations[][e_STATION_INFO] =
{
	{"Perfect City", 						"https://ssl.painelcast.com:6858/;"},
	{"Hunter POP",							"https://live.hunter.fm/pop_normal"},
	{"Hunter Sertanejo",					"http://live.hunter.fm/sertanejo_normal"},
	{"Hunter Rock",							"http://live.hunter.fm/rock_normal"},
	{"Hunter POP2k", 						"http://live.hunter.fm/pop2k_normal"},
	{"Hunter Lofi", 						"http://live.hunter.fm/lofi_normal"},
	{"Hunter Tropical", 					"http://live.hunter.fm/tropical_normal"},
	{"Hunter 80s", 							"http://live.hunter.fm/80s_normal"},
	{"Hunter Smash", 						"http://live.hunter.fm/smash_normal"},
	{"Metropolitana FM Funk", 				"http://ice.fabricahost.com.br/metropoitanaspfunk"}
	
};

stock CountStations()
	return sizeof(stations);

stock GetStationName(idx, stationName[])
{
	if ( idx < 0 || idx >= sizeof(stations) )
		return false;
	
	format(stationName, MAX_STATION_NAME, stations[idx][Nome]);
	return true;
}

stock GetStationUrl(idx, url[])
{
	if ( idx < 0 || idx >= sizeof(stations) )
		return false;
		
	format(url, MAX_STATION_URL, stations[idx][Url]);
	return true;
}