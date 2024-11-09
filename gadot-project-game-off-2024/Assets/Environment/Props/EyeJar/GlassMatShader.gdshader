shader_type spatial;
render_mode diffuse_lambert_wrap, specular_disabled;


group_uniforms common;

uniform vec4 color : source_color = vec4(1.0);
uniform float metalness : hint_range(0.0,1.0) = 1.0;
// the emission alpha determines its power
uniform vec4 emission : source_color;

group_uniforms lighting;
uniform float lighting_power : hint_range(0.0, 1.0, 0.01) = 1.0;
uniform sampler2D lighting_map : source_color, hint_default_black;

group_uniforms reflection;
uniform sampler2D reflected_map;
uniform float reflected_map_power : hint_range(0.0, 1.0, 0.01) = 0.4;

void fragment() {
	
	// matcap implimentation from: https://godotshaders.com/shader/view-matcap/
	vec2 matcap_uv = (NORMAL.xy * vec2(0.5, -0.5) + vec2(0.5, 0.5));
	
	ALBEDO = color.rgb;
	ALPHA = color.a;
	
	vec2 reflected_uv;
	
	// - Reflection
	reflected_uv = matcap_uv - UV;
	ALBEDO *= pow(texture(reflected_map, reflected_uv).rgb, vec3(reflected_map_power));
	ALPHA = texture(reflected_map, reflected_uv).a;
	
	
	// - Lighting
	ALBEDO *= mix(vec3(1.0), pow(texture(lighting_map, matcap_uv).rgb, vec3(lighting_power)), metalness);

}
