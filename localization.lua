
local addon, ns = ...;
local L=setmetatable({},{__index=function(t,k) local v="?"; if(k) then v=tostring(k); rawset(t,k,v); end return v; end});
ns.L=L;

-- Do you want to help localize this addon?
-- https://www.curseforge.com/wow/addons/@cf-project-name@/localization

L["Archaeology"] = PROFESSIONS_ARCHAEOLOGY;
L["Fishing"] = PROFESSIONS_FISHING;
L["Extract Gas"] = GetSpellInfo(30075) or "Extract Gas";
L["Herbalism"] = GetSpellInfo(170691) or "Herbalism";
L["Logging"] = GetSpellInfo(167895) or "Logging";
L["Mining"] = GetSpellInfo(2575) or "Mining";
L["Treasure"] = GetSpellInfo(188830) or "Treasure";
L["GathererMINE"] = L["Mining"];
L["GathererHERB"] = L["Herbalism"];
L["GathererOPEN"] = L["Treasure"];
L["GatherMate2Herb Gathering"] = L["Herbalism"];
L["GatherMate2Mining"] = L["Mining"];
L["GatherMate2Fishing"] = L["Fishing"];
L["GatherMate2Extract Gas"] = L["Extract Gas"];
L["GatherMate2Treasure"] = L["Treasure"];
L["GatherMate2Archaeology"] = L["Archaeology"];
L["GatherMate2Logging"] = L["Logging"];

--@localization(locale="enUS", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@

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
elseif LOCALE_ptBR or LOCALE_ptPT then
--@localization(locale="ptBR", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_ruRU then
--@localization(locale="ruRU", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_zhCN then
--@localization(locale="zhCN", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
elseif LOCALE_zhTW then
--@localization(locale="zhTW", format="lua_additive_table", handle-subnamespaces="none", handle-unlocalized="ignore")@
end
