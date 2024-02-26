shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Get the current pixel color
    vec4 color = COLOR;
	

    // Check if the pixel is white
    if (color.a >= 0.7) {
        // Change white pixels to blue
        color.r = .9/ abs(sin(TIME));
		color.g = abs(cos(TIME/2.0))/(UV.y*2.0);
		color.b = abs(sin(TIME/4.0))/(UV.y*2.0);
    }


    // Output the modified color
    COLOR = color;
}

void light() {
	// Called for every pixel for every light affecting the CanvasItem.
}
