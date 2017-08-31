
local addon, ns = ...;
local L = ns.L;
local QuickRoutes = CreateFrame("frame")

local LibQTip = LibStub('LibQTip-1.0')

local tooltip, tooltip2
local LDB_ANCHOR
local GROUP_CHECKMARK	= "|TInterface\\Buttons\\UI-CheckBox-Check:0|t"

local LDB = LibStub("LibDataBroker-1.1"):NewDataObject("QuickRoutes",{
	type	=	"launcher",
	label	=	"Routes",
	text	=	"Routes",
	icon	=	"Interface\\Addons\\QuickRoutes\\icon.tga",
	OnClick	=	function(_, button)
		if button == "LeftButton" then
			LibStub("AceConfigDialog-3.0"):Open("Routes")
		else
			InterfaceOptionsFrame_OpenToCategory("QuickRoutes")
			InterfaceOptionsFrame_OpenToCategory("QuickRoutes")
		end
	end,
});

local LDBIcon = LDB and LibStub("LibDBIcon-1.0", true)

local options = {
	name = "QuickRoutes",
	type = "group",
	args = {
		confdesc = {
			order = 1,
			type = "description",
			name = L["Quickly set and unset routes."],
			cmdHidden = true
		},
		displayheader = {
			order = 2,
			type = "header",
			name = "QuickRoutes Options",
		},
		hide_minimapicon = {
			type = "toggle", width = "double",
			name = L["Hide Minimap Icon"],
			desc = L["Show or hide the minimap icon."],
			order = 3,
			get = function() return QuickRoutesDB.MinimapIcon.hide end,
			set = function(_, v)
				QuickRoutesDB.MinimapIcon.hide = v;
				LDBIcon:Refresh("QuickRoutes");
			end,
		},
		show_hints = {
			type = "toggle", width = "double",
			name = L["Show hints"],
			desc = L["Display hints in tooltip"],
			get = function() return QuickRoutesDB.hints; end,
			set = function(_,v) QuickRoutesDB.hints = v; end
		},
		show_routetooltip = {
			type = "toggle", width = "double",
			name = L["Show second tooltip"],
			desc = L["Display second tooltip with additional informations to a single route"],
			get = function() return QuickRoutesDB.tooltip2; end,
			set = function(_,v) QuickRoutesDB.tooltip2 = v; end
		}
	},
}

LibStub("AceConfig-3.0"):RegisterOptionsTable("QuickRoutes", options)
LibStub("AceConfigDialog-3.0"):AddToBlizOptions("QuickRoutes")

local zoneTable = {}
local zoneData
local zone
local function C(color,str)
	return "|cff"..( ({ltblue="69ccf0",ltgreen="80ff80",ltyellow="fff569",dkyellow="ffcc00",copper="f0a55f"})[color] or "ffffff" )..str.."|r";
end

local function useTipTac(tt)
	-- Tiptac Support for LibQTip Tooltips
	if _G.TipTac and _G.TipTac.AddModifiedTip then
		-- Pass true as second parameter because hooking OnHide causes C stack overflows
		_G.TipTac:AddModifiedTip(tt, true);
	end
end

local function Entry_OnEnter(self, data, button)
	if LibQTip:IsAcquired("QuickRoutes2") then
		tooltip2:Clear()
	else
		tooltip2 = LibQTip:Acquire("QuickRoutes2", 2, "LEFT", "RIGHT");
		tooltip2:SmartAnchorTo(tooltip)
		useTipTac(tooltip2)
	end

	tooltip2:AddHeader(C("dkyellow",L["Route"]..":"),data.name);
	tooltip2:AddSeparator();

	local cat, obj = C("ltblue",CATEGORIES..":"), C("ltblue",L["Objects"]..":");
	for k,v in pairs(Routes.db.global.routes[zone][data.name].db_type)do
		tooltip2:AddLine(cat,C("ltgreen",L[k]));
		cat = " ";
	end

	tooltip2:AddSeparator(1,1,1,1,.5);

	for k,v in pairs(Routes.db.global.routes[zone][data.name].selection)do
		tooltip2:AddLine(obj,C("ltgreen",v));
		obj = " ";
	end

	tooltip2:Show();
end

local function Entry_OnLeave(self)
	tooltip2:Hide();
end

local function Entry_OnMouseUp(frame, route_name, button)
	Routes.db.global.routes[zone][route_name].hidden = not Routes.db.global.routes[zone][route_name].hidden
	Routes:DrawWorldmapLines()
	Routes:DrawMinimapLines(true)
	LDB.OnEnter(LDB_ANCHOR)
end

function LDB.OnEnter(self)
	LDB_ANCHOR = self

	if LibQTip:IsAcquired("QuickRoutes") then
		tooltip:Clear()
	else
		tooltip = LibQTip:Acquire("QuickRoutes", 2, "RIGHT", "LEFT")
		tooltip:SmartAnchorTo(self)
		tooltip:SetAutoHideDelay(0.25, self)
		useTipTac(tooltip)
	end

	tooltip:SetCell(tooltip:AddLine(), 1, C("dkyellow","QuickRoutes"), tooltip:GetHeaderFont() , "CENTER", 0)
	tooltip:AddSeparator()
	tooltip:AddSeparator(4,0,0,0,0);

	zone = GetRealZoneText()
	if Routes.LZName[zone] then
		zone = Routes.LZName[zone][1] -- Get mapfile
		zoneData = Routes.db.global.routes[zone]
	end

	if type(zoneData) == "table" then
		for i = #zoneTable, 1, -1 do
			zoneTable[i] = nil
		end

		for route_name in pairs(zoneData) do
			tinsert(zoneTable, route_name)
		end
		table.sort(zoneTable)

		local route_name, route_data, checked
		for i = 1, #zoneTable do
			route_name = zoneTable[i]
			route_data = zoneData[route_name]
			checked = not route_data.hidden

			if route_data.route and #route_data.route > 0 then
				line = tooltip:AddLine(checked and GROUP_CHECKMARK or " ",  C("ltblue",route_name));
				tooltip:SetLineScript(line, "OnMouseUp", Entry_OnMouseUp, route_name)
				if QuickRoutesDB.tooltip2 then
					tooltip:SetLineScript(line, "OnEnter", Entry_OnEnter, {tt=tooltip, name=route_name})
					tooltip:SetLineScript(line, "OnLeave", Entry_OnLeave)
				end
			end
		end

	end

	if QuickRoutesDB.hints then
		tooltip:AddSeparator(4,0,0,0,0);
		tooltip:SetCell(tooltip:AddLine(),1,C("copper",L["Left-click"]).." || "..C("ltgreen",L["Open routes"]),nil,"CENTER",0)
		tooltip:SetCell(tooltip:AddLine(),1,C("copper",L["Right-click"]).." || "..C("ltgreen",L["Open options"]),nil,"CENTER",0)
	end

	tooltip:UpdateScrolling()
	tooltip:Show()
end

function QuickRoutes:PLAYER_LOGIN()
	if not QuickRoutesDB then
		QuickRoutesDB = {}
	end
	if not QuickRoutesDB.MinimapIcon then
		QuickRoutesDB.MinimapIcon = {
			hide = false,
			minimapPos = 220,
			radius = 80,
		}
	end
	if QuickRoutesDB.hints==nil then
		QuickRoutesDB.hints = true;
	end
	if QuickRoutesDB.tooltip2==nil then
		QuickRoutesDB.tooltip2 = true;
	end
	if LDBIcon then
		LDBIcon:Register("QuickRoutes", LDB, QuickRoutesDB.MinimapIcon)
	end
end

QuickRoutes:SetScript("OnEvent", function(self, event, ...) if self[event] then return self[event](self, event, ...) end end)
QuickRoutes:RegisterEvent("PLAYER_LOGIN")
