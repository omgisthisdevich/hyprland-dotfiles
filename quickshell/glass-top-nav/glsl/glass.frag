#version 440
layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    vec2 size;        // panel size in px
    vec2 origin;      // panel top-left in screen px
    vec2 screenSize;  // screen size in px
    float radius;
    vec4 tint;        // rgb + strength in alpha
};
layout(binding = 1) uniform sampler2D source; // blurred wallpaper

void main() {
    vec2 p = (qt_TexCoord0 - 0.5) * size;
    vec2 q = abs(p) - (size * 0.5 - radius);
    float d = length(max(q, 0.0)) + min(max(q.x, q.y), 0.0) - radius;
    float mask = 1.0 - smoothstep(-1.0, 1.0, d);

    // sample the blurred wallpaper at this pixel's screen position
    vec2 uv = (origin + qt_TexCoord0 * size) / screenSize;
    vec3 col = texture(source, uv).rgb;

    // tint + soft top-to-bottom sheen
    col = mix(col, tint.rgb, tint.a);
    col += 0.06 * (1.0 - qt_TexCoord0.y);

    // thin rim light just inside the edge, brighter toward the top-left
    float band = smoothstep(-2.5, -0.5, d) * (1.0 - smoothstep(-0.5, 0.5, d));
    float lit = clamp(dot(normalize(p + 0.001), vec2(-0.7, -0.7)), 0.0, 1.0);
    col += band * (0.15 + 0.45 * lit);

    float a = mask * qt_Opacity;
    fragColor = vec4(col * a, a); // premultiplied
}
