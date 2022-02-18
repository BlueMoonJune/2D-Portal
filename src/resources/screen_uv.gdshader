shader_type canvas_item;

uniform vec2 offset = vec2(0,0);

void fragment() {
	
	COLOR = texture(TEXTURE, SCREEN_UV-offset);
}