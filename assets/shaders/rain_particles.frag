#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 u_resolution;
uniform float u_time;
uniform float u_intensity;
uniform float u_wind;

out vec4 fragColor;

// Pseudo-random 2D hash function
float hash(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

void main() {
    vec2 uv = FlutterFragCoord().xy / u_resolution;

    // Apply wind shear slant to uv coordinates
    uv.x += uv.y * (u_wind * 0.35);

    float rain = 0.0;
    
    // Scale for particle grid columns
    float numColumns = 60.0 + (u_intensity * 40.0);
    float col = floor(uv.x * numColumns);
    float colFrac = fract(uv.x * numColumns);

    // Speed varies slightly by column for organic depth
    float speed = 3.5 + hash(vec2(col, 1.0)) * 2.0;
    float timeOffset = hash(vec2(col, 2.0)) * 10.0;
    
    // Vertical drop position with looping wrap-around
    float y = fract(uv.y * 3.0 - (u_time * speed + timeOffset));
    
    // Raindrop streak shape (sharp top, fading tail)
    float streak = smoothstep(0.0, 0.85, y) * smoothstep(1.0, 0.92, y);
    
    // Thin horizontal line in column center
    float width = smoothstep(0.12, 0.0, abs(colFrac - 0.5));
    
    // Combine streak and width
    rain += streak * width * (0.4 + hash(vec2(col, 3.0)) * 0.6);

    // Secondary subtle background layer for parallax depth
    float bgColumns = numColumns * 1.5;
    float bgCol = floor(uv.x * bgColumns);
    float bgColFrac = fract(uv.x * bgColumns);
    float bgSpeed = 2.2 + hash(vec2(bgCol, 4.0)) * 1.5;
    float bgTimeOffset = hash(vec2(bgCol, 5.0)) * 10.0;
    float bgY = fract(uv.y * 2.5 - (u_time * bgSpeed + bgTimeOffset));
    float bgStreak = smoothstep(0.0, 0.7, bgY) * smoothstep(1.0, 0.88, bgY);
    float bgWidth = smoothstep(0.15, 0.0, abs(bgColFrac - 0.5));
    rain += bgStreak * bgWidth * 0.25;

    // Modulate overall opacity by intensity uniform
    float alpha = rain * clamp(u_intensity, 0.0, 1.0) * 0.65;

    // Soft bluish-white rain streak color
    vec3 rainColor = vec3(0.85, 0.92, 1.0);
    fragColor = vec4(rainColor * alpha, alpha);
}
