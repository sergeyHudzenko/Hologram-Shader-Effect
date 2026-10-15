varying vec3 vPosition;
varying vec3 vNormal;

uniform vec3 uColor;
uniform float uTime;

void main() {

  // Normal
  vec3 normal = normalize(vNormal);
  if(!gl_FrontFacing) {
    normal *= -1.0;
  }

  // stripes
  float stripe = pow(mod((vPosition.y - uTime * 0.02) * 20.0, 1.0), 3.0);

  // fresnel
  vec3 viewDirection =  normalize(vPosition - cameraPosition); 
  float fresnel = pow(dot(viewDirection, normal) + 1.0, 2.0);
  float falloff = smoothstep(0.8, 0.0, fresnel);

  // Holographic
  float holographic = stripe * fresnel;
  holographic += fresnel * 1.25;  
  holographic *= falloff;

  // color
  // gl_FragColor = vec4(1.0, 1.0, 1.0, stripe);
  gl_FragColor = vec4(uColor, holographic);
  #include <tonemapping_fragment>
  #include <colorspace_fragment>
}