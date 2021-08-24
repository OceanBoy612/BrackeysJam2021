shader_type canvas_item;
render_mode blend_mix;

uniform vec4 new_color;
uniform bool recolor;

void fragment(){
	float limit = 0.01;
	vec4 color = texture(TEXTURE, UV);
	// if the pixel has enough red
//	if (recolor && (color.r > limit || color.g > limit || color.b > limit)){
	if (recolor && (color.a > limit)){
//		color = vec4(0,255.0,0,color.a);
		color = new_color;
	}
	COLOR = color;
}
