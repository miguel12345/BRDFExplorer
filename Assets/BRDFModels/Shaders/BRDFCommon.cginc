

#include "UnityCG.cginc"
#include "Lighting.cginc"

struct appdata
{
    float4 vertex : POSITION;
    float3 normal : NORMAL;
};

struct v2f
{
    float4 vertex : SV_POSITION;
    float3 worldNormal : NORMAL;
};

v2f vert (appdata v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = UnityObjectToWorldNormal(v.normal);
    return o;
}

fixed4 frag (v2f i) : SV_Target
{
    float3 lightDirection = -_WorldSpaceLightPos0.xyz;
    
    float cosineFactor = saturate(dot(lightDirection,i.worldNormal));
    
    fixed4 irradianceAtSurface = _LightColor0 * cosineFactor;
    
    return brdf(lightDirection,i.worldNormal) * irradianceAtSurface;
}