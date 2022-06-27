#macro dir global.dir
#define chat_command(cmd, plr)
if (cmd != "getspr") return false;
var p, _race, _skin, _name, _ok = false;
repeat(1) {
    _name = plr;
    //
    _ok = true;
}
if (!_ok) {
    trace("Use: /getspr <name>");
    trace("e.g. /getspr sprGruntIdle")
    var r = "Races:";
    for (var i = 1; i <= 16; i++) r += ` ${race_get_name(i)}`;
    trace(r);
    return true;
}
dir = _name;
//
scr_sprite(_name, _name)
//
return true;

#define scr_sprite(q, _name)
_q = asset_get_index(q)
var _rel = _name + ".png";
var _full = _rel;
var _num;
if (_q == null) return "mskNone";
if (is_array(_q)) {
    scr_sprite_save_image(_q[0], _q[1], _full);
    _q = _q[0];
    _num = 1;
} else if (sprite_exists(_q)) {
    scr_sprite_save(_q, _full);
	trace("Loaded sprite " + _name)
    _num = sprite_get_number(_q);
} else {
	trace("Failed to load sprite " + _name)
	return "mskNone";
}
var _x = sprite_get_xoffset(_q);
var _y = sprite_get_yoffset(_q);
return `sprite_add("${_rel}", ${_num}, ${_x}, ${_y})`;

#define scr_sprite_save(q, _path)
var w = sprite_get_width(q);
var h = sprite_get_height(q);
var x = sprite_get_xoffset(q);
var y = sprite_get_yoffset(q);
var n = sprite_get_number(q);
var sf = surface_create(w*n, h);
surface_set_target(sf);
draw_clear_alpha(c_black, 0);
draw_set_blend_mode(bm_add);
for (var i = 0; i < n; i++) {
    draw_sprite(q, i, w * i + x, y);
}
draw_set_blend_mode(bm_normal);
surface_reset_target();
surface_save(sf, _path)

#define scr_sprite_save_image(q, _img, _path)
var sf = surface_create(sprite_get_width(q), sprite_get_height(q));
surface_set_target(sf);
draw_clear_alpha(c_black, 0);
draw_set_blend_mode(bm_add);
draw_sprite(q, _img, sprite_get_xoffset(q), sprite_get_yoffset(q));
draw_set_blend_mode(bm_normal);
surface_reset_target();
surface_save(sf, _path)
