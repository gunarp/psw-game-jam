shader_type canvas_item;

uniform vec2 player_position; // Position of the player
uniform float radius = 100.0; // Radius of the revealed area

void fragment() {
    // Get the distance from the current pixel to the player's position
    float dist = distance(player_position, FRAGCOORD.xy);

    // If the distance is greater than the radius, apply the fog
    if (dist > radius) {
        discard;
    }

    // Otherwise, show the pixel as clear
    COLOR = texture(TEXTURE, FRAGCOORD.xy / SCREEN_PIXEL_SIZE);
}
