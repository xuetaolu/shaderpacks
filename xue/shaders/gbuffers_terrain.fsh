#version 120

const int noiseTextureResolution = 256;

uniform int fogMode;
uniform sampler2D texture;
uniform sampler2D lightmap;
uniform bool hideGUI;
uniform vec3 cameraPosition;
uniform vec3 previousCameraPosition;

varying vec4 color;
varying vec4 texcoord;
varying vec4 lmcoord;
varying vec2 normal;
varying vec4 rpos;

/* DRAWBUFFERS:02 */
void main() {
    if ( hideGUI == true ) {
        gl_FragData[0] = texture2D(texture, texcoord.st) * texture2D(lightmap, lmcoord.st) * color;
        if(fogMode == 9729)
        	gl_FragData[0].rgb = mix(gl_Fog.color.rgb, gl_FragData[0].rgb, clamp((gl_Fog.end - gl_FogFragCoord) / (gl_Fog.end - gl_Fog.start), 0.0, 1.0));
        else if(fogMode == 2048)
        	gl_FragData[0].rgb = mix(gl_Fog.color.rgb, gl_FragData[0].rgb, clamp(exp(-gl_FogFragCoord * gl_Fog.density), 0.0, 1.0));
        gl_FragData[1] = vec4(normal, 0.0, 1.0);
    }
    else {
        vec4 tmpColor = texture2D(texture, texcoord.st) * texture2D(lightmap, lmcoord.st) * color;
        gl_FragData[0].rgba = mix( tmpColor.rgba, gl_FragData[0].rgba, 0.0 );
        if(fogMode == 9729)
            gl_FragData[0].rgb = mix(gl_Fog.color.rgb, gl_FragData[0].rgb, clamp((gl_Fog.end - gl_FogFragCoord) / (gl_Fog.end - gl_Fog.start), 0.0, 1.0));
        else if(fogMode == 2048)
            gl_FragData[0].rgb = mix(gl_Fog.color.rgb, gl_FragData[0].rgb, clamp(exp(-gl_FogFragCoord * gl_Fog.density), 0.0, 1.0));
        gl_FragData[1] = vec4(normal, 0.0, 1.0);
        //if ( 0.05 < position.x && position.s < 0.95 && 0.05 < texcoord.t && texcoord.t < 0.95 )
        gl_FragData[0] *= vec4(1.0,1.0,1.0,0.5);
        //gl_FragData[0] = rpos;
    }
}