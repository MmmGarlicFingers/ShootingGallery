shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Get the current pixel color
    vec4 color = COLOR;
	

    // Check if the pixel is white
    if (color.a >= 0.4) {
        // Change white pixels to blue
        color.r = 256.0;
		color.g = 0.0 + abs(cos(TIME/4.0)/4.0)/UV.x;
		color.b = 0.0 + abs(sin(TIME/8.0))/UV.y;
    }


    // Output the modified color
    COLOR = color;
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
