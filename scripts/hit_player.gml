//Numb poison application (Nair)

if ((my_hitboxID.attack == AT_NAIR /*&& my_hitboxID.hbox_num == 3*/) && hit_player_obj.numb_poison < 5){
        hit_player_obj.numb_poison += 1; 
}