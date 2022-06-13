
local addon, ns = ...;
local L = ns.L;

local LDB = LibStub("LibDataBroker-1.1");
local LDBIcon = LibStub("LibDBIcon-1.0");
local LibQTip = LibStub("LibQTip-1.0");
local AC = LibStub("AceConfig-3.0");
local ACD = LibStub("AceConfigDialog-3.0");

local QuickRoutes,LDBObject,tt,tt2,RoutesModuleTT = CreateFrame("frame");

local dbDefaults = {
	MinimapIcon = {
		hide = false,
		minimapPos = 220,
		radius = 80,
	},
	hints = true,
	tooltip2 = true,
	showLoaded = true,
	waypointstomtom = true
};

local colors = {ltblue="69ccf0",ltgreen="80ff80",ltyellow="fff569",dkyellow="ffcc00",copper="f0a55f",gray="808080",green="00ff00",blue="0099ff"};
local function C(color,str)
	return "|cff"..( colors[color] or "ffffff" )..str.."|r";
end

local function tWrappedConcat(tbl,delimiter,maxLetter)
	local tmp,tmp2,count = {},{},0;
	for k, v in pairs(tbl)do
		local c = strlen(v);
		if count+c>maxLetter then
			tinsert(tmp,table.concat(tmp2,delimiter));
			wipe(tmp2);
			count=0;
		end
		tinsert(tmp2,v);
		count=count+c;
	end
	if count>0 then
		tinsert(tmp,table.concat(tmp2,delimiter));
	end
	return table.concat(tmp,delimiter.."|n");
end

local function RoutesTomTom(self,action,button)
	if not RoutesModuleTT then
		RoutesModuleTT = Routes:GetModule("TomTom");
	end
	if RoutesModuleTT and RoutesModuleTT[action] then
		RoutesModuleTT[action](RoutesModuleTT);
	end
end

-- option panel by ace3
local function opt(info,value)
	local key = info[#info];
	if key=="minimap" then
		if value~=nil then
			QuickRoutesDB.MinimapIcon.hide = not QuickRoutesDB.MinimapIcon.hide;
			LDBIcon:Refresh(addon);
		end
		return not QuickRoutesDB.MinimapIcon.hide;
	elseif value~=nil then
		QuickRoutesDB[key] = value
	end
	return QuickRoutesDB[key];
end

local options = {
	name = addon,
	type = "group",
	get = opt,
	set = opt,
	args = {
		g0 = {
			type = "group", order = 1, inline = true,
			name = L.Info,
			args = {
				desc = {
					type = "description", order = 1, fontSize = "medium",
					name = L.Description.."\n "
				},
				version = {
					type = "description", order = 2, fontSize = "medium",
					name = "" -- filled on player login
				},
				authors = {
					type = "description", order = 3, fontSize = "medium",
					name = "" -- filled on player login
				}
			}
		},
		g1 = {
			type = "group", order = 2, inline = true,
			name = L.OnLogin,
			args = {
				showLoaded = {
					type = "toggle", width = "full",
					name = L.ShowAddOnLoaded, desc = L.ShowAddOnLoadedDesc .. "|n|n|cff44ff44"..L.ShowAddOnLoadedDescAlt.."|r"
				}
			}
		},
		g2 = {
			type = "group", order = 3, inline = true,
			name = L.Minimap,
			args = {
				minimap = {
					type = "toggle", order = 3, width = "full",
					name = L.ShowMinimap, desc = L.ShowMinimapDesc
				}
			}
		},
		g3 = {
			type = "group", order = 4, inline = true,
			name = L.Tooltip,
			args = {
				hints = {
					type = "toggle", order = 1, width = "full",
					name = L.Hints, desc = L.HintsDesc
				},
				tooltip2 = {
					type = "toggle", order = 2, width = "full",
					name = L.SecondTT, desc = L.SecondTTDesc
				},
				waypointstomtom = {
					type = "toggle", order = 3, width = "full",
					name = L.WaypointsTomTom, desc = L.WaypointsTomTomDesc
				}
			}
		},
		credits = {
			type = "group", order = 200, inline = true,
			name = L["Credits"],
			args = {
				-- add credit for former author
			}
		}
	}
}

-- register ace3 option table
AC:RegisterOptionsTable(addon, options);
ACD:AddToBlizOptions(addon);
ACD:SetDefaultSize(addon,360,480);
ns.AddCredits(options.args.credits.args);

-- second tooltip - list of nodes of the displayed route
local function CreateTooltip2(self, data)
	if LibQTip:IsAcquired(addon.."2") then
		-- tooltip instance already present, clear exists lines
		tt2:Clear()
	else
		-- aquire new tooltip instance from LibQTip
		tt2 = LibQTip:Acquire(addon.."2", 1, "CENTER");
		tt2:SmartAnchorTo(data.parent);
	end

	if _G.TipTac and _G.TipTac.AddModifiedTip then
		_G.TipTac:AddModifiedTip(tt2, true); -- Tiptac Support for LibQTip Tooltips
	elseif AddOnSkins and AddOnSkins.SkinTooltip then
		AddOnSkins:SkinTooltip(tt2); -- AddOnSkins support
	end

	-- tooltip header
	tt2:SetCell(tt2:AddLine(), 1, C("dkyellow",L.Route..L.Colon.." "..data.name), tt:GetHeaderFont() , "LEFT", 0);

	-- create list of categories and node objects
	local cat,obj = {},{};
	local zoneID = C_Map.GetBestMapForUnit("player");
	for k,v in pairs(Routes.db.global.routes[zoneID][data.name].db_type)do
		tinsert(cat, C("ltgreen",L[k]));
	end
	for k,v in pairs(Routes.db.global.routes[zoneID][data.name].selection)do
		tinsert(obj,C("ltgreen",v));
	end

	-- show list of categories
	if #cat>0 then
		tt2:AddSeparator(4,0,0,0,0);
		tt2:AddLine(C("ltblue",CATEGORIES));
		tt2:AddSeparator();
		table.sort(cat);
		tt2:AddLine(tWrappedConcat(cat,", ",60));
	end

	-- show list of node objects
	if #obj>0 then
		tt2:AddSeparator(4,0,0,0,0);
		tt2:AddLine(C("ltblue",L.Objects));
		tt2:AddSeparator();

		table.sort(obj);
		tt2:AddLine(tWrappedConcat(obj,", ",60));
	end

	-- message on empty lists
	if #cat==0 and #obj==0 then
		tt2:AddLine(C("gray",L.NoRouteData));
	end

	-- show tooltip
	tt2:UpdateScrolling();
	tt2:Show();
end

local function HideTooltip2()
	tt2:Hide();
	LibQTip:Release(tt2);
end

local CreateTooltip;
local function ToggleRoute(frame, data)
	-- toggle hidden state
	Routes.db.global.routes[data.zone][data.name].hidden = not Routes.db.global.routes[data.zone][data.name].hidden;
	-- force update of routes
	Routes:DrawWorldmapLines();
	Routes:DrawMinimapLines(true);
	-- update tooltip
	CreateTooltip(data.parent);
end

function CreateTooltip(parent, data)
	if LibQTip:IsAcquired(addon) then
		-- tooltip instance already present, clear exists lines
		tt:Clear();
	else
		-- aquire new tooltip instance from LibQTip
		tt = LibQTip:Acquire(addon, 3, "CENTER", "CENTER", "CENTER");
		tt:SmartAnchorTo(parent);
		tt:SetAutoHideDelay(0.1, parent);
	end

	if _G.TipTac and _G.TipTac.AddModifiedTip then
		_G.TipTac:AddModifiedTip(tt, true); -- Tiptac Support for LibQTip Tooltips
	elseif AddOnSkins and AddOnSkins.SkinTooltip then
		AddOnSkins:SkinTooltip(tt); -- AddOnSkins support
	end

	-- header
	tt:SetCell(tt:AddLine(),1,C("dkyellow",addon),tt:GetHeaderFont(),"CENTER",0);
	tt:AddSeparator(4,0,0,0,0);

	-- get routes
	local selection,zone = false,C_Map.GetBestMapForUnit("player");
	local routeNames,zoneRoutes = {},Routes.db.global.routes[zone] or {};
	for name, data in pairs(zoneRoutes) do
		if data.route and #data.route>0 then
			tinsert(routeNames, name);
			if not zoneRoutes[name].hidden then
				selection=true;
			end
		end
	end

	-- list routes
	local info=C_Map.GetMapInfo(zone);
	if info then
		tt:SetCell(tt:AddLine(),1,C("ltgreen",info.name),nil,"CENTER",0);
		tt:AddSeparator();
		if routeNames and #routeNames>0 then
			table.sort(routeNames);
			for _,routeName in pairs(routeNames) do
				local texture = (not zoneRoutes[routeName].hidden) and "UI-CheckBox-Check" or "UI-PASSIVEHIGHLIGHT";
				local line = tt:AddLine();
				tt:SetCell(line,1,"|TInterface\\Buttons\\"..texture..":16:16:0:-2|t " .. C("ltblue",routeName),nil,"CENTER",0);
				tt:SetLineScript(line, "OnMouseUp", ToggleRoute, {parent=parent, zone=zone, name=routeName});

				-- sub tooltip for more infomations about single route
				if QuickRoutesDB.tooltip2 then
					tt:SetLineScript(line, "OnEnter", CreateTooltip2, {parent=tt, zone=zone, name=routeName});
					tt:SetLineScript(line, "OnLeave", HideTooltip2);
				end
			end
		else
			-- No routes found for current zone
			tt:SetCell(tt:AddLine(),1,C("gray",L.NoRoutesInZone),nil,"CENTER",0);
		end
	else
		tt:SetCell(tt:AddLine(),1,C("gray",L["Unknown zone"]),nil,"CENTER",0);
	end

	-- routes/tomtom options
	if QuickRoutesDB.waypointstomtom and TomTom then
		tt:AddSeparator(4,0,0,0,0);
		tt:SetCell(tt:AddLine(),1,C("ltgreen",L["WaypointsTomTom"]),nil,"CENTER",0);
		tt:AddSeparator();
		local tomtom={"QueueFirstNode","RemoveQueuedNode","SetClosestWaypoint"};

		--TomTom:SetClosestWaypoint(true)
		local l=tt:AddLine();
		for i=1, #tomtom do
			tt:SetCell(l,i,C("ltblue",L[tomtom[i]]));
			tt:SetCellScript(l,i,"OnMouseUp",RoutesTomTom,tomtom[i]);
		end
	end

	-- add hints
	if QuickRoutesDB.hints then
		tt:AddSeparator(4,0,0,0,0);
		tt:SetCell(tt:AddLine(),1,C("copper",L.LeftClick).." || "..C("green",L.OpenRoutes),nil,"CENTER",0);
		tt:SetCell(tt:AddLine(),1,C("copper",L.RightClick).." || "..C("green",L.OpenOptions),nil,"CENTER",0);
	end

	-- show tooltip
	tt:UpdateScrolling();
	tt:Show();
end

QuickRoutes:SetScript("OnEvent", function(self, event, ...)
	if event=="ADDON_LOADED" and ...==addon then
		-- check savedvariables
		if QuickRoutesDB==nil then
			QuickRoutesDB = {};
		end
		for k,v in pairs(dbDefaults)do
			if QuickRoutesDB[k]==nil then
				QuickRoutesDB[k] = v;
			end
		end

		-- inform player that the addon is loaded :)
		if QuickRoutesDB.showLoaded or IsShiftKeyDown() then
			print(C("blue",addon)..HEADER_COLON,C("green",L.AddOnLoaded));
		end
	elseif event=="PLAYER_LOGIN" then
		-- register data broker
		LDBObject = LDB:NewDataObject(addon,{
			type	=	"launcher",
			label	=	addon,
			text	=	addon,
			icon	=	"Interface\\Addons\\QuickRoutes\\icon.tga",
			OnClick	=	function(_, button)
				local name = "Routes";
				if button == "RightButton" then
					name = addon;
				end
				if ACD.OpenFrames[name]~=nil then
					ACD:Close(name);
				else
					ACD:Open(name);
				end
			end,
			OnEnter = CreateTooltip
		});

		-- register data broker as minimap button
		if LDBObject and LDBIcon then
			LDBIcon:Register(addon, LDBObject, QuickRoutesDB.MinimapIcon);
		end

		-- update option table
		options.args.g0.args.version.name = C("dkyellow",GAME_VERSION_LABEL).." @project-version@";
		options.args.g0.args.authors.name = C("dkyellow",L.Authors).." @project-author@";
	end
end);

QuickRoutes:RegisterEvent("PLAYER_LOGIN");
QuickRoutes:RegisterEvent("ADDON_LOADED");
