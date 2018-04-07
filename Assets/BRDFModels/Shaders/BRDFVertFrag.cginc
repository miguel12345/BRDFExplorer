// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'



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
    float3 worldPos : TEXCOORD0;
};

v2f vert (appdata v)
{
    v2f o;
    o.vertex = UnityObjectToClipPos(v.vertex);
    o.worldNormal = UnityObjectToWorldNormal(v.normal);
    o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;

    return o;
}


fixed4 frag (v2f i) : SV_Target
{
    float3 lightDirection = -_WorldSpaceLightPos0.xyz;
    
    float3 interpolatedWorldNormal = normalize(i.worldNormal);
    
    float cosineFactor = saturate(dot(lightDirection,i.worldNormal));
    
    float3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
    
    float3 viewReflectionDir = reflect(-viewDir,interpolatedWorldNormal);
    
    fixed4 lightIrradianceAtSurface = _LightColor0 * cosineFactor;
    
    return brdf(lightDirection,interpolatedWorldNormal,viewDir) * lightIrradianceAtSurface;
}