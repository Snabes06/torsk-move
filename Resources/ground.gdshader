shader_type spatial;

void vertex() {
	VERTEX.y += cos(VERTEX.x / 3.0) * sin(VERTEX.z / 2.0) * 0.4;
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
