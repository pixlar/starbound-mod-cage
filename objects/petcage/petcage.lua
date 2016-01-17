require "/scripts/vec2.lua"
require "/scripts/util.lua"

function init()
  self.initialising=true
  storage.monster = config.getParameter("monster")
  updateDisplay()
  self.initialising=false
end

-----------------------------------------------------

function containerCallback()
  if (self.isComplete~=true) then
    world.logInfo("Contents changed")
    self.needsUpdate=true
  end
end

-----------------------------------------------------

function update(dt)
  if (self.needsUpdate) then
    world.logInfo("update")

    santiseContents()
    updateDisplay()
    self.needsUpdate=false   
  end
end

-----------------------------------------------------

function santiseContents()
  for i=1,world.containerSize(entity.id()) do
    local item = world.containerItemAt(entity.id(), i-1) --container slots are zero indexed, hence the -1

    if (item) then
      world.logInfo("Checking Object=%s",item.name)
      if item.name == "filledcapturepod" then
      	world.logInfo("That's a filledcapturepod")
      	storage.monster = item.parameters.pets[1]
      else
    	storage.monster = nil
        ejectItemFromSlot(i)
      end
    else
    	storage.monster = nil
    end
  end
end

-----------------------------------------------------

function ejectItemFromSlot(slotIndex)
  local item = world.containerTakeAt(entity.id(), slotIndex-1)  --container slots are zero indexed, hence the -1

  if item then
    world.logInfo("Ejecting Object=%s",item.name)

    world.spawnItem(item.name, object.position(), item.count, item.parameters)
  end
end

-----------------------------------------------------
function updateDisplay()
	for i=1,5 do
		tagName=string.format("fossil%s", i)
		animator.setGlobalTag(tagName, "")
	end
	if storage.monster then
		local displayImage = storage.monster.portrait
      	for c,d in pairs(displayImage) do
      		
      		monsterLayerImage = storage.monster.portrait[c].image
      		tagName = string.format("fossil%s", c)
      		
      		world.logInfo("Displaying %s in %s", monsterLayerImage, tagName)
      		animator.setGlobalTag(tagName, monsterLayerImage)
      	end
	end
end

-----------------------------------------------------
function die()
	storage.monster = nil
end

