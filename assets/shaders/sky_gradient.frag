#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 u_resolution;
uniform float u_time;
uniform float u_solar_elevation;

out vec4 fragColor;

void main() {
    vec2 st = FlutterFragCoord().xy / u_resolution;
    // Ambient celestial gradient placeholder shader
    fragColor = vec4(0.08, 0.12, 0.25, 1.0);
}
