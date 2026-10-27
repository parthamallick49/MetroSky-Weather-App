#version 460 core

#include <flutter/runtime_effect.glsl>

uniform vec2 u_resolution;
uniform float u_time;
uniform float u_intensity;

out vec4 fragColor;

void main() {
    vec2 st = FlutterFragCoord().xy / u_resolution;
    // Ambient snow particle placeholder shader
    fragColor = vec4(0.0, 0.0, 0.0, 0.0);
}
