#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 u_resolution;
uniform float u_time;
uniform float u_intensity;
uniform float u_wind;

out vec4 fragColor;

float hash21(vec2 p) {
    p = fract(p * vec2(234.34, 435.345));
    p += dot(p, p + 34.23);
    return fract(p.x * p.y);
}

void main() {
    vec2 uv = FlutterFragCoord().xy / u_resolution;
    vec2 st = uv;

    float snow = 0.0;

    // Loop through 3 distinct depth layers for realistic parallax
    for (float i = 1.0; i <= 3.0; i += 1.0) {
        float layerScale = 12.0 * i;
        float speed = (0.2 + (i * 0.15)) * (0.8 + (u_intensity * 0.4));
        
        // Sway calculation
        float sway = sin(u_time * 1.2 + (uv.y * 3.0) + i) * 0.08 * (1.0 + abs(u_wind));
        
        vec2 gridUv = vec2(
            st.x * layerScale + sway + (u_wind * u_time * 0.1),
            (st.y * layerScale) - (u_time * speed * layerScale * 0.1)
        );

        vec2 id = floor(gridUv);
        vec2 gv = fract(gridUv) - 0.5;

        // Random offset for snowflake within its grid cell
        vec2 randomOffset = vec2(
            hash21(id) - 0.5,
            hash21(id + 15.0) - 0.5
        ) * 0.65;

        float dist = length(gv - randomOffset);
        
        // Snowflake disc radius
        float radius = 0.08 + (hash21(id + 42.0) * 0.06);
        float flake = smoothstep(radius, radius * 0.2, dist);

        // Accumulate with layer opacity
        snow += flake * (0.35 + (i * 0.2));
    }

    float alpha = snow * clamp(u_intensity, 0.0, 1.0) * 0.8;
    vec3 snowColor = vec3(1.0, 1.0, 1.0);

    fragColor = vec4(snowColor * alpha, alpha);
}
