local S = minetest.get_translator(minetest.get_current_modname())

--
-- items
--

-- wheel
minetest.register_craftitem("automobiles_buggy:wheel",{
	description = S("Buggy Wheel"),
	inventory_image = "automobiles_buggy_wheel_icon.png",
})

-- buggy
minetest.register_craftitem("automobiles_buggy:buggy", {
	description = S("Buggy"),
	inventory_image = "automobiles_buggy.png",
    liquids_pointable = false,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end

        local pointed_pos = pointed_thing.above
		--pointed_pos.y=pointed_pos.y+0.2
		local car = minetest.add_entity(pointed_pos, "automobiles_buggy:buggy")
		if car and placer then
            local ent = car:get_luaentity()
            local owner = placer:get_player_name()
            if ent then
                ent.owner = owner
			    car:set_yaw(placer:get_look_horizontal())
			    itemstack:take_item()
                ent.object:set_acceleration({x=0,y=-automobiles_lib.gravity,z=0})
                automobiles_lib.setText(ent, "buggy")
                automobiles_lib.create_inventory(ent, buggy.trunk_slots, owner)
            end
		end

		return itemstack
	end,
})

--
-- crafting
--
if minetest.get_modpath("default") then
	minetest.register_craft({
		output = "automobiles_buggy:buggy",
		recipe = {
			{"automobiles_buggy:wheel", "default:steel_ingot", "automobiles_buggy:wheel"},
			{"xpanes:pane_flat", "wool:black", "automobiles_lib:engine"},
			{"automobiles_buggy:wheel", "default:steel_ingot", "automobiles_buggy:wheel"},
		}
	})
	minetest.register_craft({
		output = "automobiles_buggy:wheel",
		recipe = {
			{"technic:rubber", "technic:rubber", "technic:rubber"},
			{"technic:rubber","technic:chromium_ingot", "technic:rubber"},
            {"technic:rubber", "technic:rubber", "technic:rubber"},
		}
	})
end