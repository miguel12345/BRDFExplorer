Shader "BRDF/Normalized Blinn-Phong with Fresnel"
{
	Properties
	{
		_Diffuse ("Diffuse", Color) = (1,1,1,1)
		_Specular ("Specular color", Color) = (1,1,1,1)
		_Smoothness ("Smoothness", Range(0,300)) = 1
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			
			#include "BRDFUtils.cginc"
			
			fixed3 _Diffuse;
			fixed3 _Specular;
			float _Smoothness;
            
			fixed4 brdf(float3 lightDir, float3 normal, float3 viewDir) {
			    
			    float3 halfVector = normalize(lightDir + viewDir);
			    float lh = clampedCosine(lightDir, halfVector);
			    
			    float3 specularity =  pow(clampedCosine(halfVector,normal),_Smoothness);
			    
			    //normalize
			    specularity = specularity * ((_Smoothness+8)/8);
			    
			    half3 color = _Diffuse + fresnelTerm (_Specular, lh) * specularity;
			    //half3 color = _Diffuse + _Specular * specularity;
			    
			    return half4(color,1.0);
			}

			#include "BRDFVertFrag.cginc"
						
			#pragma vertex vert
            #pragma fragment frag
			
			ENDCG
		}
	}
}
