precision mediump float;
varying vec2 vTextureCoord;
uniform sampler2D uTexture0;
uniform sampler2D uTexture1;
uniform sampler2D uTexture2;

vec4 lookup(in vec4 textureColor){
    mediump float blueColor = textureColor.b * 63.0;
    mediump vec2 quad1;
    quad1.y = floor(floor(blueColor) / 8.0);
    quad1.x = floor(blueColor) - (quad1.y * 8.0);
    mediump vec2 quad2;
    quad2.y = floor(ceil(blueColor) / 8.0);
    quad2.x = ceil(blueColor) - (quad2.y * 8.0);
    highp vec2 texPos1;
    texPos1.x = (quad1.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
    texPos1.y = (quad1.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);
    texPos1.y = 1.0-texPos1.y;
    highp vec2 texPos2;
    texPos2.x = (quad2.x * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.r);
    texPos2.y = (quad2.y * 0.125) + 0.5/512.0 + ((0.125 - 1.0/512.0) * textureColor.g);
    texPos2.y = 1.0-texPos2.y;
    lowp vec4 newColor1 = texture2D(uTexture2, texPos1);
    lowp vec4 newColor2 = texture2D(uTexture2, texPos2);
    lowp vec4 newColor = mix(newColor1, newColor2, fract(blueColor));
    return newColor;
}
void main(){
    vec4 lastFrame = texture2D(uTexture1,vTextureCoord);
    vec4 currentFrame = lookup(texture2D(uTexture0,vTextureCoord));

    gl_FragColor = vec4(0.8 * lastFrame.r  +  0.26* currentFrame.r,0.8* lastFrame.g + 0.29*  currentFrame.g,0.8* lastFrame.b + 0.27 * currentFrame.b,1.0);
}