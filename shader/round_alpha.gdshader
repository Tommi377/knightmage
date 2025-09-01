shader_type canvas_item;

uniform float threshold: hint_range(0, 1) = 0.5;

void fragment() {
    float alpha = texture(TEXTURE, UV).a;
    COLOR.a = step(threshold, alpha);
}
