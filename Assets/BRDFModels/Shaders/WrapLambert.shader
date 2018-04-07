Shader "BRDF/WrapLambert"
{
	Properties
	{
		_Color ("Diffuse", Color) = (1,0,0,1)
		_Wrap ("Wrap", Range(0,1)) = 0.5
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			
			fixed4 _Color;
			float _Wrap;
            
			fixed4 brdf(float3 lightDir, float3 normal,float3 viewDir) {
			    return _Color;
			}
			
			#include "BRDFVertFrag.cginc"
			
			#pragma vertex vert
            #pragma fragment fragWrap
            
            fixed4 fragWrap (v2f i) : SV_Target
            {
                float3 lightDirection = -_WorldSpaceLightPos0.xyz;
                
                float cosineFactor = saturate( (dot(lightDirection,i.worldNormal)+_Wrap)/(1+_Wrap) );
                
                 float3 viewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
                
                fixed4 irradianceAtSurface = _LightColor0 * cosineFactor;
                
                return brdf(lightDirection,i.worldNormal,viewDir) * irradianceAtSurface;
            }
			
			ENDCG
		}
	}
}
