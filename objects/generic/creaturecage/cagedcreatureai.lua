function init()
	entity.setDropPool(nil)
	entity.setDeathParticleBurst(nil)
	entity.setDeathSound(nil)
	--entity.setGravityEnabled(false)
	--self.die()
end

function update(dt)

end

function die()
	self.dead = true
end

function kill()
	self.dead = true
end


function shouldDie()
  return self.dead
end