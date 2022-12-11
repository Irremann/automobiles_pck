local S = minetest.get_translator(minetest.get_current_modname())

--
-- items
--

-- coupe
minetest.register_craftitem("automobiles_coupe:coupe", {
	description = S("Coupe"),
	inventory_image = "automobiles_coupe.png",
    liquids_pointable = false,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end

        local pointed_pos = pointed_thing.above
		--pointed_pos.y=pointed_pos.y+0.2
		local car = minetest.add_entity(pointed_pos, "automobiles_coupe:coupe")
		if car and placer then
            local ent = car:get_luaentity()
            local owner = placer:get_player_name()
            if ent then
                ent.owner = owner
                --minetest.chat_send_all("owner: " .. ent.owner)
		        car:set_yaw(placer:get_look_horizontal())
		        itemstack:take_item()
                ent.object:set_acceleration({x=0,y=-automobiles_lib.gravity,z=0})
                automobiles_lib.setText(ent, "Coupe")
                automobiles_lib.create_inventory(ent, coupe.trunk_slots, owner)
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
		output = "automobiles_coupe:coupe",
		recipe = {
			{"automobiles_buggy:wheel", "default:steel_ingot", "automobiles_buggy:wheel"},
			{"automobiles_lib:engine", "default:glass", "wool:grey"},
			{"automobiles_buggy:wheel", "default:steel_ingot", "automobiles_buggy:wheel"},
		}
	})
end
