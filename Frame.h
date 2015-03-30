//
//  Frame.h
//  OGLGame
//
//  Created by Michael Daley on 19/04/2009.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image2D.h"

@interface Frame : NSObject {
	// The image this frame of animation will display
	Image2D *frameImage;
	// How long the frame should be displayed for
	float frameDelay;
}

@property(nonatomic, assign)float frameDelay;
@property(nonatomic, retain)Image2D *frameImage;

- (id)initWithImage:(Image2D*)image delay:(float)delay;
@end
