#version 120

varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;
varying vec2 normal;
uniform bool hideGUI;

vec2 normalEncode(vec3 n) {
    vec2 enc = normalize(n.xy) * (sqrt(-n.z*0.5+0.5));
    enc = enc*0.5+0.5;
    return enc;
}

void main()
{
	vec4 position = gl_ModelViewMatrix * gl_Vertex;
	gl_Position = gl_ProjectionMatrix * position;
	gl_FogFragCoord = length(position.xyz);
	color = gl_Color;
	texcoord = gl_TextureMatrix[0] * gl_MultiTexCoord0;
	lmcoord = gl_TextureMatrix[1] * gl_MultiTexCoord1;
	normal = normalEncode(gl_NormalMatrix * gl_Normal);
    if ( hideGUI == false ) {
        gl_Position.z *= 0.5;
    }
}