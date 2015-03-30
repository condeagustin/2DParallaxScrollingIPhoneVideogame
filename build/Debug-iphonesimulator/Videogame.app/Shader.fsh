//
//  Shader.fsh
//  Videogame
//
//  Created by Administrator on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
