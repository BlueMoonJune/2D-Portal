shader_type canvas_item;

void fragment () {
	vec4 a = vec4(texture(TEXTURE, UV - vec2(0,0.1)).a);
	a = a + vec4(texture(TEXTURE, UV + vec2(0,0.1)).a);
	a = a + vec4(texture(TEXTURE, UV - vec2(0.1,0)).a);
	a = a + vec4(texture(TEXTURE, UV + vec2(0.1,0)).a);
	a = clamp(a,0,1);
	
	COLOR = mix(a,texture(TEXTURE, UV),texture(TEXTURE, UV).a);
}