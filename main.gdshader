shader_type spatial;

void fragment() {

	vec3 dark_purple = vec3(0.08, 0.01, 0.15);
	vec3 bright_purple = vec3(0.55, 0.08, 0.85);

	float pattern = UV.y;

	ALBEDO = mix(
		dark_purple,
		bright_purple,
		pattern
	);
}