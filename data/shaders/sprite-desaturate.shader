shader_type canvas_item;

uniform float saturation;
uniform vec3 modulator;

void fragment() {
	// sample the texture
    vec4 tex_color = texture(TEXTURE, UV);

	//COLOR.rgba = tex_color;
	//float grey = (tex_color.r + tex_color.g + tex_color.b) * 0.333;
	//COLOR.rgba = vec4(grey, grey, grey, tex_color.a);

    COLOR.rgb = mix(vec3(dot(tex_color.rgb, vec3(0.299, 0.587, 0.114))), tex_color.rgb, saturation);
	COLOR.a = tex_color.a;
}