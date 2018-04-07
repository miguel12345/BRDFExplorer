
//taken from unityStandardBRDF.cginc 
inline half3 pow5 (half3 x)
{
    return x*x * x*x * x;
}

//taken from unityStandardBRDF.cginc 
half3 fresnelTerm (half3 F0, half cosA)
{
    half t = pow5 (1 - cosA); 
    return F0 + (1-F0) * t;
}

float clampedCosine(float3 vecA, float3 vecB) {
    return saturate(dot(vecA,vecB));
}