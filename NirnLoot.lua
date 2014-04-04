NL = {}
local LAM = LibStub("LibAddonMenu-1.0")
local bagIDvar = 1 -- WTF is bagId?
local db

SmithList = nil
ClothList = nil
EnchantList = nil
ProvList = nil
WoodList = nil
AlchemyList = nil

local defaults = {

	ITEM_QUALITY_ARCANE = "keep",
	ITEM_QUALITY_ARTIFACT = "keep",
	ITEM_QUALITY_LEGENDARY = "keep",
	ITEM_QUALITY_MAGIC = "keep",
	ITEM_QUALITY_NORMAL = "keep",
	ITEM_QUALITY_TRASH = "keep",
	
	CRAFTING_TYPE_ALCHEMY = "keep",
	CRAFTING_TYPE_BLACKSMITHING = "keep",
	CRAFTING_TYPE_CLOTHIER = "keep",
	CRAFTING_TYPE_ENCHANTING = "keep",
	CRAFTING_TYPE_INVALID = "keep",
	CRAFTING_TYPE_PROVISIONING = "keep",
	CRAFTING_TYPE_WOODWORKING = "keep",
	
	ITEMTYPE_LURE = "keep",
	ITEMTYPE_TRASH = "keep",
	
	ALCHEMY_USER="@NONE",
	SMITHING_USER="@NONE",
	CLOTHIER_USER="@NONE",
	ENCHANTING_USER="@NONE",
	PROVISIONING_USER="@NONE",
	WOODWORKING_USER="@NONE",
	
	
}
local function sendDebug(message)
	if(CHAT_SYSTEM)
	then
		CHAT_SYSTEM:AddMessage(tostring(message))
	end
end

function ListBag()
	local bagIcon, bagSlots = GetBagInfo(BAG_BACKPACK)
	for counter = 0, bagSlots,1 do
		sendDebug("NEW ITEM  - Number " .. counter .. " of " .. bagSlots )
	sortLoot(bagIDvar, counter)
	end
	sendDebug("BagSize is " .. bagSlots)
	sendDebug(BAG_BACKPACK)
	
end

function sortLoot(bagId, slotId)
	local icon, stack, sellPrice, meetsUsageRequirement, locked, equipType, itemStyle, quality = GetItemInfo(bagId, slotId)
	local usedInCraftingType, itemType, extraInfo1, extraInfo2, extraInfo3 = GetItemCraftingInfo(bagId, slotId)
	local itemName = GetItemName(bagId, slotId)
	sendDebug("ItemName : ".. itemName)
	if(equipType>0) then
		sendDebug("EquipType : " .. equipType)
	end
--	sendDebug("Quality : " .. quality)
--	sendDebug("Stack : " .. stack)
--	sendDebug("Crafting Type : " .. usedInCraftingType)
		if(usedInCraftingType==1) then
			addToSendList(slotId, SmithList)
		elseif(usedInCraftingType==2) then
			addToSendList(slotId, ClothList)
		elseif(usedInCraftingType==3) then
			addToSendList(slotId, EnchantList)
		elseif(usedInCraftingType==4) then
			addToSendList(slotId, AlchemyList)
		elseif(usedInCraftingType==5) then
			addToSendList(slotId, ProvList)
		elseif(usedInCraftingType==6) then
			addToSendList(slotId, WoodList)
		else
			sendDebug("Item not crafting material")
		end
end

function addToSendList(slotId, list)
	list = {next = list, value = slotId}
	sendDebug("Added Item to list - " .. list.value)
end

function showList(list)
	sendDebug("Printing list")
	sendDebug(list)
	  while list do
	  sendDebug("WTF")
      sendDebug(list.value)
      list = list.next
	end
end

SLASH_COMMANDS["/nirnloot"] = function()
   sendDebug("Slash Activated")
   ListBag()
end

SLASH_COMMANDS["/cloth"] = function()
	showList(ClothList)
end
EVENT_MANAGER:RegisterForEvent("NirnLoot", EVENT_ADD_ON_LOADED, function(event, addon)


	if(addon=="NirnLoot") then
		EVENT_MANAGER:RegisterForEvent("NirnLoot", EVENT_INVENTORY_SINGLE_SLOT_UPDATE, LF.OnLootReceived)
		EVENT_MANAGER:RegisterForEvent("NirnLoot", EVENT_OPEN_STORE, LF.SellJunk)
		sendDebug("NirnLoot Activated")
	end
	end)
