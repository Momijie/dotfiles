#version 120

uniform sampler2D texture;
uniform sampler2D desktop;
uniform vec2 screenSize;

varying vec2 uvCoord;

vec4 border(vec4 rect,vec4 color,vec4 border_color){
    vec2 pixel = vec2(1,1)/screenSize;

    vec4 up = texture2D(texture, vec2(uvCoord.x, uvCoord.y+pixel.y));
    vec4 down = texture2D(texture, vec2(uvCoord.x, uvCoord.y-pixel.y));
    vec4 left = texture2D(texture, vec2(uvCoord.x-pixel.x, uvCoord.y));
    vec4 right = texture2D(texture, vec2(uvCoord.x+pixel.x, uvCoord.y));

    if (rect.a == 0 && (up.a + down.a + left.a + right.a) > 0) {
        return border_color;
    } else {
        return color;
    }
}

vec4 white(){
    return vec4(1,1,1,1);
}

vec4 black(){
    return vec4(0,0,0,0);
}

vec4 dim(float alpha){
    return vec4(0,0,0,alpha);
}

void main()
{   // the color the border will be
    vec4 border_color = white();

    // pixel is initially black
    vec4 color = black();

    vec4 rect = texture2D(texture,uvCoord);
    vec4 irect = (white() - rect);

    // set pixel to a dimmed black.
    color = dim(0.65);

    color = color * irect;

    color = border(rect,color,border_color);

    gl_FragColor = (color);
}
