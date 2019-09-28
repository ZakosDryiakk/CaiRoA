//B - Reversals
if (attack == AT_NSPECIAL || attack == AT_FSPECIAL || attack == AT_DSPECIAL || attack == AT_USPECIAL){
    trigger_b_reverse();
}

if (attack == AT_NSPECIAL){
    if (window == 3){
        if (special_pressed){
            window = 1;
            window_timer = 0;
        }
    }
}

if (attack == AT_FSPECIAL){
    if (window == 2){
        if (special_pressed){
            window = 3;
            window_timer = 0;
            destroy_hitboxes();
        }
    }
    can_fast_fall = false;
}

if (attack == AT_USPECIAL){
    if (window == 1 && window_timer == 1){
        times_through = 0;
    }
    if (window == 2){
        if (window_timer == get_window_value(attack, 2, AG_WINDOW_LENGTH)){
            if (times_through < 10){
                times_through++;
                window_timer = 0;
            }
        }
        if (!joy_pad_idle){
            hsp += lengthdir_x(1, joy_dir);
            vsp += lengthdir_y(1, joy_dir);
        } else {
            hsp *= .6;
            vsp *= .6;
        }
        var fly_dir = point_direction(0,0,hsp,vsp);
        var fly_dist = point_distance(0,0,hsp,vsp);
        var max_speed = 12;
        if (fly_dist > max_speed){
            hsp = lengthdir_x(max_speed, fly_dir);
            vsp = lengthdir_y(max_speed, fly_dir);
        }
        if (special_pressed && times_through > 0){
            window = 4;
            window_timer = 0;
        }
        if (shield_pressed){
            window = 3;
            window_timer = 0;
        }
    }
    if (window > 3 && window < 6 && window_timer == get_window_value(attack, window, AG_WINDOW_LENGTH)){
        window++;
        window_timer = 0;
    }
}

if (attack == AT_DSPECIAL){
    if (window == 2){
        can_jump = true;
    }
    can_fast_fall = false;
    can_move = false
}

// Moves that get hitstun bonus via the numbing poison stacks
if (attack == AT_DTILT)
{
    set_hitbox_value(AT_DTILT, 1, HG_HITSTUN_MULTIPLIER, 1+(.05*hit_player_obj.numb_poison));
}

// Strong extension criteria check

if (attack == AT_FSTRONG && has_hit_player && hit_player_obj.last_hbox_num != 2)
{
    if(hit_player_obj.numb_poison == 5 )
    {
        if(window == 2 && window_timer == 1)
            sound_play(asset_get("sfx_blow_heavy2"));
        set_attack_value(AT_FSTRONG, AG_NUM_WINDOWS, 8);
        set_hitbox_value(AT_FSTRONG, 2, HG_HITBOX_GROUP, 0);
         
        set_window_value(AT_FSTRONG, 4, AG_WINDOW_TYPE, 1);
        set_window_value(AT_FSTRONG, 4, AG_WINDOW_LENGTH, 15);
        set_window_value(AT_FSTRONG, 4, AG_WINDOW_ANIM_FRAMES, 1);
        set_window_value(AT_FSTRONG, 4, AG_WINDOW_ANIM_FRAME_START, 8);

        with (asset_get("oPlayer")) {
            if (hitpause && other.window == 5 && state_cat == SC_HITSTUN && hit_player_obj == other.id
            && last_attack == other.attack && state != PS_FROZEN){
                x += (other.x+80*other.spr_dir - x)/8;
                if (free){
                    y += (other.y - y) / 5;
                }
            }
        }
    }

    if(window == 7)
    {
        reset_hitbox_value(AT_FSTRONG, 1, HG_HIT_SFX);
        reset_window_value(AT_FSTRONG, 4, AG_WINDOW_TYPE);
        reset_window_value(AT_FSTRONG, 4, AG_WINDOW_LENGTH);
        reset_window_value(AT_FSTRONG, 4, AG_WINDOW_ANIM_FRAMES);
        reset_window_value(AT_FSTRONG, 4, AG_WINDOW_ANIM_FRAME_START);
        reset_hitbox_value(AT_FSTRONG, 2, HG_HITBOX_GROUP);
        reset_attack_value(AT_FSTRONG, AG_NUM_WINDOWS);
    }
}