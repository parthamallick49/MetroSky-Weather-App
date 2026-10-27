#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 u_resolution;
uniform float u_time;
uniform float u_solar_elevation;

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / u_resolution;
    float y = uv.y;

    // Define key atmospheric palettes (top and bottom colors)
    // 1. Night (elevation < -18°)
    vec3 nightTop = vec3(0.043, 0.051, 0.106);     // #0B0D1B
    vec3 nightBottom = vec3(0.094, 0.106, 0.204);  // #181B34

    // 2. Twilight (-18° to 0°)
    vec3 twilightTop = vec3(0.173, 0.106, 0.302);  // #2C1B4D
    vec3 twilightBottom = vec3(0.780, 0.475, 0.400); // #C77966

    // 3. Golden Hour (0° to 6°)
    vec3 goldenTop = vec3(0.220, 0.235, 0.471);    // #383C78
    vec3 goldenBottom = vec3(0.961, 0.651, 0.380); // #F5A661

    // 4. Daytime (> 6°)
    vec3 dayTop = vec3(0.118, 0.357, 0.722);       // #1E5BB8
    vec3 dayBottom = vec3(0.349, 0.584, 0.886);    // #5995E2

    vec3 topColor;
    vec3 bottomColor;

    // Interpolate palettes based on solar elevation
    if (u_solar_elevation < -18.0) {
        topColor = nightTop;
        bottomColor = nightBottom;
    } else if (u_solar_elevation < 0.0) {
        float t = smoothstep(-18.0, 0.0, u_solar_elevation);
        topColor = mix(nightTop, twilightTop, t);
        bottomColor = mix(nightBottom, twilightBottom, t);
    } else if (u_solar_elevation < 6.0) {
        float t = smoothstep(0.0, 6.0, u_solar_elevation);
        topColor = mix(twilightTop, goldenTop, t);
        bottomColor = mix(twilightBottom, goldenBottom, t);
    } else {
        float t = smoothstep(6.0, 30.0, u_solar_elevation);
        topColor = mix(goldenTop, dayTop, t);
        bottomColor = mix(goldenBottom, dayBottom, t);
    }

    // Vertical gradient with subtle organic curve
    vec3 finalColor = mix(topColor, bottomColor, smoothstep(0.0, 1.0, y));

    fragColor = vec4(finalColor, 1.0);
}
