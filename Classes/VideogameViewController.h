//
//  VideogameViewController.h
//  Videogame
//
//  Created by Administrator on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "Texture2D.h"
#import "Image2D.h"
#import "SpriteSheet.h"
#import "AngelCodeFont.h"
#import "Animation.h"
#import "BGLayer.h"
#import "TiledMap.h"
#import "Player.h"
#import "GameScene.h"


@interface VideogameViewController : UIViewController <UIAccelerometerDelegate>
{
    EAGLContext *context;
    GLuint program;
    BOOL animating;
    NSInteger animationFrameInterval;
    //CADisplayLink *displayLink;
	
	
	CGRect screenBounds;
	CFTimeInterval lastTime;	
	BOOL glInitialised;
	
	AngelCodeFont *font1;
	
	NSTimer *gameLoopTimer;
	
	GameScene *gameScene;
	
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;

- (void)startAnimation;
- (void)stopAnimation;

@end
