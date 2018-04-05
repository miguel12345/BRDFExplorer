Shader "BRDF/Lambert"
{
	Properties
	{
		_Color ("Diffuse", Color) = (1,0,0,1)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			
			fixed4 _Color;
            
			fixed4 brdf(float3 lightDir, float3 normal,float3 viewDir) {
			    return _Color;
			}
			
			#include "BRDFCommon.cginc"
			
			#pragma vertex vert
            #pragma fragment frag
			
			ENDCG
		}
	}
}
