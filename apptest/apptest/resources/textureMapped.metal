//
//  textureMapped.metal
//  apptest
//
//  Created by Michael Ong on 16/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct VertexInput  {

    float4 position [[attribute(0)]];
    float4 texCoord [[attribute(1)]];
};

struct TexturedVertex {

    float4 position [[position]];
    float4 texCoord;
};

constexpr sampler       diffSampler     (address::clamp_to_zero ,
                                         filter::linear         ,
                                         mag_filter::linear     ,
                                         min_filter::linear     );

vertex TexturedVertex   tex_vert_main   (VertexInput        input   [[stage_in]],
                                         constant float4x4& matrix  [[buffer(1)]]) {

    TexturedVertex vert;

    vert.position   = matrix * input.position;
    vert.texCoord   = input.texCoord;

    return vert;
}

fragment float4         tex_frag_main   (TexturedVertex     vert        [[stage_in]],
                                         texture2d<float>   texture     [[texture(0)]]) {

    return texture.sample(diffSampler, vert.texCoord.xy);
}
