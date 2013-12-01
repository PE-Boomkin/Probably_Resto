ProbablyEngine.library.register('coreHealing', {
  needsHealing = function(percent, count)
    return ProbablyEngine.raid.needsHealing(tonumber(percent)) >= count
  end,
  needsDispelled = function(spell)
    for unit,_ in pairs(ProbablyEngine.raid.roster) do
      if UnitDebuff(unit, spell) then
        ProbablyEngine.dsl.parsedTarget = unit
        return true
      end
    end
  end,
})

-- Custom Resto Druid Rotation v0.1
-- Updated on Nov 29th

ProbablyEngine.rotation.register_custom(105, "Resto", {

-- Pause Rotation
{ "pause", "modifier.lalt" },

-- Focus Macro
{ "!/focus [target=mouseover]", "modifier.lcontrol" },

-- Tranq Modifier
{ "740", "modifier.rshift" },

-- Incarnation Modifier
{ "106731", "modifier.rcontrol" },

-- Innervate
{ "29166", "player.mana < 80", "player" },

-- Incarnation Regrowth Clearcasting
{ "8936", { 
	"player.buff(33891)",
	"player.buff(16870)", 
	"!lowest.buff(8936)", 
	"lowest.health < 80",
	"!lowest.range > 40"
}, "lowest" },

-- Incarnation Wildgrowth
{ "48438", {
	"player.buff(33891)",
	"@coreHealing.needsHealing(85, 3)",
	"!lowest.range > 40"
}, "lowest" },

-- Incarnation Lifebloom Spam
{ "33763", { 
	"player.buff(33891)",
	"!lowest.buff(33763)",
	"lowest.health < 100",
	"!lowest.range > 40"
}, "lowest" },

-- Regrowth Clearcasting
{ "8936", { 
	"player.buff(16870)", 
	"!lowest.buff(8936)", 
	"lowest.health < 80",
	"!lowest.range > 40"
}, "lowest" },

-- Healing Touch Tier 2 Piece
{ "5185", { 
	"player.buff(144871).count = 5", 
	"lowest.health < 80",
	"!lowest.range > 40"
}, "lowest" },

-- Healing Touch Clearcasting
{ "5185", { 
	"player.buff(16870)",  
	"lowest.health < 80",
	"!lowest.range > 40"
}, "lowest" },

-- Nature's Swiftness
{ "132158", {
	"lowest.health < 30",
	"!lowest.range > 40"
}, "lowest" },

-- Rejuvenation Tank
{ "774", { 
	"!tank.buff(774)",
	"tank.health < 95",
	"!tank.range > 40"
}, "tank" },

-- Swiftmend
{ "18562", { 
	"lowest.health < 75", 
	"lowest.buff(774)",
	"!lowest.range > 40"
}, "lowest" },

-- Regrowth
{ "8936", { 
	"lowest.health < 50", 
	"!lowest.buff(8936)",
	"!lowest.range > 40"
}, "lowest" },

-- Wildgrowth
{ "48438", { 
	"@coreHealing.needsHealing(85, 3)",
	"!lowest.range > 40"
}, "lowest" },

-- Life Bloom Focus
{ "33763", { 
	"tank.buff(33763).count < 3",
	"!tank.range > 40"
}, "tank" },

{ "33763", { 
	"tank.buff(33763).duration < 2",
	"!tank.range > 40"
}, "tank" },

-- Genesis Single Target
{ "145518", { 
	"!player.spell(18562).cooldown = 0",
	"lowest.health < 40", 
	"lowest.buff(774)",
	"!lowest.range > 40"
}, "lowest" },

-- Genesis
{ "145518", { 
	"!player.spell(18562).cooldown = 0",
	"@coreHealing.needsHealing(70, 3)", 
	"lowest.buff(774)",
	"!lowest.range > 40"
}, "lowest" },

-- Rejuvenation
{ "774", { 
	"lowest.health < 80", 
	"!lowest.buff(774)",
	"!lowest.range > 40"
}, "lowest" },

-- Healing Touch
{ "5185", {
	"lowest.health < 40",
	"!lowest.range > 40"
}, "lowest" },


-- Nourish For Harmony
{ "50464", {
	"player.buff(100977).duration <= 2",
	"lowest.health < 95",
	"!lowest.range > 40"
}, "lowest" },

}, {
-- Focus Macro - Out Of Combat
{ "!/focus [target=mouseover]", "modifier.lcontrol" },
})