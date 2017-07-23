//
//  textureMapped.metal
//  apptest
//
//  Created by Michael Ong on 16/7/17.
//  Copyright © 2017 Michael Ong. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;

struct TexturedVertex
{
    float4 position [[position]];
    float2 texCoord;
};

vertex TexturedVertex   tex_vert_main   (constant float4*   position    [[buffer(0)]],
                                         constant float2*   texCoord    [[buffer(1)]],
                                         uint               vid         [[vertex_id]])
{
    TexturedVertex vert;

    vert.position   = position  [vid];
    vert.texCoord   = texCoord  [vid];

    return vert;
}

fragment float4         tex_frag_main   (TexturedVertex     vert        [[stage_in]],
                                         texture2d<float>   texture     [[texture(0)]],
                                         sampler            samp        [[sampler(0)]])
{
    return vert.position;
}
