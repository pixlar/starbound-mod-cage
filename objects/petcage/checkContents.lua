function init(args)
	myID = entity.id()
	self.needsUpdate=true
end


function update(args)
	if (self.needsUpdate) then
		world.logInfo("---------------------------------")
		readTable()
		world.logInfo("---------------------------------")
		self.needsUpdate=false
	end
end

function readTable()
	heldItem = world.containerItemAt(myID, 0)
	if heldItem then
		tableInfo(heldItem, 0)
	end
end

function tableInfo(table, level)
	spaces = string.rep("---", level)
	world.logInfo(spaces.."{")
	for key,value in pairs(table) do
		if type(value) == "table" then
			world.logInfo(spaces..'"' .. key .. '": ')
			tableInfo(value, (level+1))
		elseif type(value) == "boolean" then
			world.logInfo(spaces..'"' .. key .. '": true, ')
		else
			world.logInfo(spaces..'"' .. key .. '": "'..value..'",')
		end
	end
	world.logInfo(spaces.."},")
end