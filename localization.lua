
local addon, ns = ...;
local L=setmetatable({},{__index=function(t,k) local v="?"; if(k) then v=tostring(k); rawset(t,k,v); end return v; end});
ns.L=L;


-- Hi. This addon needs your help for localization. :)
-- https://wow.curseforge.com/projects/quickroutes/localization

if LOCALE_deDE then
	--@localization(locale="deDE", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_esES then
	--@localization(locale="esES", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_esMX then
	--@localization(locale="esMX", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_frFR then
	--@localization(locale="frFR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_itIT then
	--@localization(locale="itIT", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_koKR then
	--@localization(locale="koKR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_ptBR then
	--@localization(locale="ptBR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_ruRU then
	--@localization(locale="ruRU", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_zhCN then
	--@localization(locale="zhCN", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_zhTW then
	--@localization(locale="zhTW", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end

--[[ the following lines are a workaround for some problems with gathermate ]]
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
end
if LOCALE_koKR then
end

if LOCALE_ptBR then
end

if LOCALE_ruRU then
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

