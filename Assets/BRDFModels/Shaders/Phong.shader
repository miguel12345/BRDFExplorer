Shader "BRDF/Phong"
{
	Properties
	{
		_Diffuse ("Diffuse", Color) = (1,1,1,1)
		_Specular ("Specular color", Color) = (1,1,1,1)
		_Smoothness ("Smoothness", float) = 1
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			
			fixed4 _Diffuse;
			fixed4 _Specular;
			float _Smoothness;
            
			fixed4 brdf(float3 lightDir, float3 normal, float3 viewDir) {
			    float3 lightReflectionDir = reflect(-lightDir,normal);
			    return _Diffuse + _Specular * pow(saturate(dot(lightReflectionDir,viewDir)),_Smoothness);
			}
			
			#include "BRDFCommon.cginc"
			
			#pragma vertex vert
            #pragma fragment frag
			
			ENDCG
		}
	}
}
