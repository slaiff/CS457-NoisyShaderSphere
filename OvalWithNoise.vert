#version 330 compatibility

// will be interpolated into the fragment shader:
out  vec2  vST;                 // texture coords
out  vec3  vN;                  // normal vector
out  vec3  vL;                  // vector from point to light
out  vec3  vE;                  // vector from point to eye
out  vec3  vMC;					// model coordinates


const vec3 LIGHTPOSITION = vec3( 5., 5., 0. );

void
main( )
{
	vST = gl_MultiTexCoord0.st;

	vMC = gl_Vertex.xyz;		//Model Coord position

	//vMC = (gl_ModelViewMatrix * gl_Vertex).xyz;	//using this - versus the line above, changes the model coords to be basing the pattern on the transformed object? :<
													//using above - model coordinates, the texture is fixed on the object. With the eye/world coordinates, it's fixed in space.

	vec4 ECposition = gl_ModelViewMatrix * gl_Vertex; // eye coordinate position

	vN = normalize( gl_NormalMatrix * gl_Normal ); // normal vector

	vL = LIGHTPOSITION - ECposition.xyz; // vector from the point to the light position

	vE = vec3( 0., 0., 0. ) - ECposition.xyz; // vector from the point to the eye position

	gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;			//have to do this - gets us proper coords?view? MC are objects OG coords, 
}
