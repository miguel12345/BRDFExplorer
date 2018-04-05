Shader "BRDF/Normalized Blinn-Phong"
{
	Properties
	{
		_Diffuse ("Diffuse", Color) = (1,1,1,1)
		_Specular ("Specular color", Color) = (1,1,1,1)
		_Smoothness ("Smoothness", Range(0,100)) = 1
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
			    
			    float3 halfVector = normalize(lightDir + viewDir);
			    
			    float4 specularity =  pow(saturate(dot(halfVector,normal)),_Smoothness);
			    
			    //normalize
			    specularity = specularity * ((_Smoothness+8)/8);
			    
			    return _Diffuse + _Specular * specularity;
			}
			
			#include "BRDFCommon.cginc"
			
			#pragma vertex vert
            #pragma fragment frag
			
			ENDCG
		}
	}
}
