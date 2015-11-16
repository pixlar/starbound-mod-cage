function init(args)
	message.setHandler("findcages", function(_, _, params)
		findcages()
	end)
end

function update(args)
end

function findcages(arg)
	world.logInfo("console searching")
	countcages = entity.inboundNodeCount(0)
	cages = entity.getInboundNodeIds(0)
	if countcages >= 1 then
		--world.logInfo("loading objects")
		world.setProperty("console"..tostring(entity.id()), nil)
		cages = {}
		for i,j in pairs(entity.getInboundNodeIds(0)) do
			if world.entityName(i) == "creaturecage" or world.entityName(i) == "ironcreaturecage" or world.entityName(i) == "coppercreaturecage" then
				table.insert(cages, i)
				--world.logInfo("Creature Cage "..i)
			end
		end
		--world.logInfo("Setting console"..tostring(entity.id()))
		world.setProperty("console"..tostring(entity.id()), cages)
	end
end
