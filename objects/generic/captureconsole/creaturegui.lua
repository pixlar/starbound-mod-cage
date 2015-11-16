function init()
	--world.logInfo("console activated")
	theconsole = console.sourceEntity()
	world.sendEntityMessage(theconsole, "findcages")
	cages = getCages()
end

function update()
	console.canvasDrawText( "Cages", {position={40, 200}, horizontalAnchor="left", verticalAnchor="top"}, 16, {255, 255, 255} ) 
	cages = getCages()
	if type(cages) ~= "table" then
		console.canvasDrawRect({19, (213 - 34), 361, (184 - 34)}, {250, 250, 250})
		console.canvasDrawRect({20, (212 - 34), 360, (185 - 34)}, {50, 50, 50})
		console.canvasDrawText( "No Cages Found...", {position={35, (210 - 34)}, horizontalAnchor="left", verticalAnchor="top"}, 12, {255, 255, 255} )
	else
		if tableLength(cages) > 5 then
			numBoxes = 5
		else
			numBoxes = tableLength(cages)
		end
		for i=1,numBoxes do
			creatureText = "no creature"
			console.canvasDrawRect({14, (213 - i*34), 376, (184 - i*34)}, {250, 250, 250})
			console.canvasDrawRect({15, (212 - i*34), 375, (185 - i*34)}, {50, 50, 50})
			
			cageName = world.entityName(cages[i])
			console.canvasDrawImage("/objects/generic/"..cageName.."/"..cageName.."icon.png", {14, (197 - i*34)}, 1)
			if cageName == "creaturecage" then
				console.canvasDrawText( "Basic Cage", {position={30, (210 - i*34)}, horizontalAnchor="left", verticalAnchor="top"}, 10, {255, 255, 255} )
			elseif cageName == "ironcreaturecage" then
				console.canvasDrawText( "Iron Cage", {position={30, (210 - i*34)}, horizontalAnchor="left", verticalAnchor="top"}, 10, {255, 255, 255} )
			elseif cageName == "coppercreaturecage" then
				console.canvasDrawText( "Copper Cage", {position={30, (210 - i*34)}, horizontalAnchor="left", verticalAnchor="top"}, 10, {255, 255, 255} )
			else
				console.canvasDrawText( "Cage", {position={30, (210 - i*34)}, horizontalAnchor="left", verticalAnchor="top"}, 10, {255, 255, 255} )
			end
			
			console.canvasDrawRect({100, (205 - i*34), 370, (188 - i*34)}, {0, 0, 0})
			creatureText = checkCage(cages[i])
			--world.logInfo(creatureText)
			console.canvasDrawText(creatureText, {position={103, (202 - i*34)}, horizontalAnchor="left", verticalAnchor="top"}, 9, {255, 255, 255})
		end
	end
end

function checkCage(cageid)
	--world.logInfo("======================")
	--world.logInfo("check Cage "..cageid)
	if world.entityExists(cageid) and world.containerSize(cageid) ~= nil then
		contents = world.containerItems(cageid)
		if contents == nil then
			--world.logInfo("contents are nil")
			return "no creature inside"
		end
		if tableLength(contents) == 0 then
			--world.logInfo("tableLength == 0")
			return "No creature inside"
		end
		item = contents[1]
		if type(item) == "nil" then
			--world.logInfo("type of item is nil")
			return "no creature inside"
		end
		creature = {}
		creature["type"] = item.parameters.projectileConfig.actionOnReap[1]["type"]
		creature["level"] = item.parameters.projectileConfig.actionOnReap[1]["arguments"]["level"]
		creature["colors"] = item.parameters.projectileConfig.actionOnReap[1]["arguments"]["colors"]
		if type(creature) == "nil" then
			--world.logInfo("type(creature) is nil")
			return "No creature found"
		end
		--world.logInfo(type(creature))
		return "A Level "..creature["level"].." "..creature["colors"].."-colored "..creature["type"]
	end
	--world.logInfo("what cage")
	return "What Cage?"
end

function getCages()
	--world.logInfo("console"..tostring(theconsole))
	cageList = world.getProperty("console"..tostring(theconsole))
	--world.logInfo(type(cageList))
	return cageList
end


----------Thank you lua-users.org/wiki
function tableLength(tab)
	local retVal = 0
	for i,j in pairs(tab) do
		retVal = retVal + 1
	end
	return retVal
end