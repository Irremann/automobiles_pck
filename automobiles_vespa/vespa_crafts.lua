local S = minetest.get_translator(minetest.get_current_modname())

--
-- items
--

-- wheel
minetest.register_craftitem("automobiles_vespa:wheel",{
	description = S("Vespa Wheel"),
	inventory_image = "automobiles_vespa_wheel_icon.png",
})

-- vespa
minetest.register_craftitem("automobiles_vespa:vespa", {
	description = S("Vespa"),
	inventory_image = "automobiles_vespa.png",
    liquids_pointable = false,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end

        local pointed_pos = pointed_thing.above
		--pointed_pos.y=pointed_pos.y+0.2
		local car = minetest.add_entity(pointed_pos, "automobiles_vespa:vespa")
		if car and placer then
            local ent = car:get_luaentity()
            local owner = placer:get_player_name()
            if ent then
                ent.owner = owner
			    car:set_yaw(placer:get_look_horizontal())
			    itemstack:take_item()
                ent.object:set_acceleration({x=0,y=-automobiles_lib.gravity,z=0})
                automobiles_lib.setText(ent, "vespa")
                automobiles_lib.create_inventory(ent, vespa.trunk_slots, owner)
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
		output = "automobiles_vespa:vespa",
		recipe = {
            {"pipeworks:pipe_1_empty","",""},
			{"default:tin_ingot","","wool:black"},
			{"automobiles_vespa:wheel","automobiles_lib:engine", "automobiles_vespa:wheel"},
		}
	})
	minetest.register_craft({
		output = "automobiles_vespa:wheel",
		recipe = {
			{"technic:rubber", "", "technic:rubber"},
			{"","default:tin_ingot",  ""},
            {"technic:rubber", "", "technic:rubber"},
		}
	})
end
