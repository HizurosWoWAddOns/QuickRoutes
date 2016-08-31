
local addon, ns = ...;
local L=setmetatable({},{__index=function(t,k) local v="?"; if(k) then v=tostring(k); rawset(t,k,v); end return v; end});
ns.L=L;

--[[

L["Display hints in tooltip"] = "";
L["Display second tooltip with additional informations to a single route"] = "";
L["Hide Minimap Icon"] = "";
L["Left-click"] = "";
L["Objects"] = "";
L["Open options"] = "";
L["Open routes"] = "";
L["Quickly set and unset routes."] = "";
L["Right-click"] = "";
L["Route"] = "";
L["Show hints"] = "";
L["Show or hide the minimap icon."] = "";
L["Show second tooltip"] = "";

]]

if LOCALE_enUS or LOCALE_enGB then
	L["GathererMINE"] = "Mining"
	L["GathererHERB"] = "Herbalism"
	L["GathererOPEN"] = "Treasure"
	L["GatherMate2Herb Gathering"] = "Herbalism"
	L["GatherMate2Mining"] = "Mining"
	L["GatherMate2Fishing"] = "Fishing"
	L["GatherMate2Extract Gas"] = "Extract Gas"
	L["GatherMate2Treasure"] = "Treasure"
	L["GatherMate2Archaeology"] = "Archaeology"
	L["GatherMate2Logging"] = "Logging"
end

if LOCALE_deDE then
	-- For german translations...
	L["Display hints in tooltip"] = "Zeigt Tipps im Tooltip";
	L["Display second tooltip with additional informations to a single route"] = "Zeigt zweiten Tooltip mit zusätzlichen Informationen zu einer einzelnen Route";
	L["Hide Minimap Icon"] = "Verstecke Minimap Symbol";
	L["Left-click"] = "Linksklick";
	L["Objects"] = "Objekte";
	L["Open options"] = "Optionen öffnen";
	L["Open routes"] = "Routes öffnen";
	--L["Quickly set and unset routes."] = "";
	L["Right-click"] = "Rechtsklick";
	L["Route"] = "Route";
	L["Show hints"] = "Zeige Tipps";
	L["Show or hide the minimap icon."] = "Zeige oder verstecke das Minimap Symbol.";
	L["Show second tooltip"] = "Zeige zweiten Tooltip";
	--
	--
	L["Fishing"] = "Angeln"
	L["GathererHERB"] = "Kräuterkunde"
	L["GathererMINE"] = "Bergbau"
	L["GathererOPEN"] = "Schätze"
	L["GatherMate2Archaeology"] = "Archäologie"
	L["GatherMate2Extract Gas"] = "Gas"
	L["GatherMate2Fishing"] = "Angeln"
	L["GatherMate2Herb Gathering"] = "Kräuterkunde"
	L["GatherMate2Logging"] = "Holzfällen"
	L["GatherMate2Mining"] = "Bergbau"
	L["GatherMate2Treasure"] = "Schätze"
	L["Herbalism"] = "Kräuterkunde"
	L["Mining"] = "Bergbau"
end

if LOCALE_esES or LOCALE_esMX then
	-- For spanish translations...
	L["Fishing"] = "Pesca"
	L["GathererHERB"] = "Herbología"
	L["GathererMINE"] = "Minería"
	L["GathererOPEN"] = "Tesoro"
	L["GatherMate2Archaeology"] = "Arqueología"
	L["GatherMate2Extract Gas"] = "Extraer Gas"
	L["GatherMate2Fishing"] = "Pesca"
	L["GatherMate2Herb Gathering"] = "Herbología"
	--L["GatherMate2Logging"] = ""
	L["GatherMate2Mining"] = "Minería"
	L["GatherMate2Treasure"] = "Tesoro"
	L["Herbalism"] = "Herbología"
	L["Mining"] = "Minería"
end

if LOCALE_frFR then
	-- For french translations...
	L["Fishing"] = "Pêche"
	L["GathererHERB"] = "Herboristerie"
	L["GathererMINE"] = "Minage"
	L["GathererOPEN"] = "Trésor"
	L["GatherMate2Archaeology"] = "Archéologie"
	L["GatherMate2Extract Gas"] = "Gaz"
	L["GatherMate2Fishing"] = "Pêche"
	L["GatherMate2Herb Gathering"] = "Herboristerie"
	--L["GatherMate2Logging"] = ""
	L["GatherMate2Mining"] = "Minage"
	L["GatherMate2Treasure"] = "Trésor"
	L["Herbalism"] = "Herboristerie"
	L["Mining"] = "Minage"
end

if LOCALE_itIT then
	-- For italian translations...
end
if LOCALE_koKR then
	-- For korean translations...
end

if LOCALE_ptBR then
	-- For Brazilian/Portuguese translations...
end

if LOCALE_ruRU then
	-- For russian translations...
	L["Fishing"] = "Рыбалка"
	L["GathererHERB"] = "Травничество"
	L["GathererMINE"] = "Горное дело"
	L["GathererOPEN"] = "Сокровища"
	L["GatherMate2Archaeology"] = "Археология"
	L["GatherMate2Extract Gas"] = "Извлечение газа"
	L["GatherMate2Fishing"] = "Рыболовство"
	L["GatherMate2Herb Gathering"] = "Травничество"
	-- L["GatherMate2Logging"] = ""
	L["GatherMate2Mining"] = "Горное дело"
	L["GatherMate2Treasure"] = "Сокровища"
	L["Herbalism"] = "Травничество"
	L["Mining"] = "Горное дело"
end

if LOCALE_zhCN then
	-- For simplified chinese translations...
	L["Left-click"] = "左单击";
	L["Right-click"] = "右键";
	--
	--
	L["Fishing"] = "钓鱼"
	L["GathererHERB"] = "草药"
	L["GathererMINE"] = "采矿"
	L["GathererOPEN"] = "宝藏"
	L["GatherMate2Archaeology"] = "考古"
	L["GatherMate2Extract Gas"] = "气体云"
	L["GatherMate2Fishing"] = "钓鱼"
	L["GatherMate2Herb Gathering"] = "草药"
	L["GatherMate2Logging"] = "日志记录"
	L["GatherMate2Mining"] = "采矿"
	L["GatherMate2Treasure"] = "宝藏"
	L["Herbalism"] = "草药"
	L["Mining"] = "采矿"
end

if LOCALE_zhTW then
	-- For traditional chinese translations...
	L["Fishing"] = "釣魚"
	L["GathererHERB"] = "採藥"
	L["GathererMINE"] = "採礦"
	L["GathererOPEN"] = "寶藏"
	L["GatherMate2Archaeology"] = "考古"
	L["GatherMate2Extract Gas"] = "氣雲"
	L["GatherMate2Fishing"] = "釣魚"
	L["GatherMate2Herb Gathering"] = "採藥"
	-- L["GatherMate2Logging"] = ""
	L["GatherMate2Mining"] = "採礦"
	L["GatherMate2Treasure"] = "寶藏"
	L["Herbalism"] = "採藥"
	L["Mining"] = "採礦"
end

