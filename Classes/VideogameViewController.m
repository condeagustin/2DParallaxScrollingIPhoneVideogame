//
//  VideogameViewController.m
//  Videogame
//
//  Created by Administrator on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "VideogameViewController.h"
#import "EAGLView.h"



@interface VideogameViewController ()
@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) CADisplayLink *displayLink;
- (void)initOpenGL;
- (void)initGame;
- (void)mainGameLoop;
- (void)updateScene:(float)delta;
- (void)renderScene;
@end

@implementation VideogameViewController

//@synthesize animating
@synthesize context, displayLink;

- (void)awakeFromNib
{
	EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    
    if (!aContext)
        NSLog(@"Failed to create ES context");
    else if (![EAGLContext setCurrentContext:aContext])
        NSLog(@"Failed to set ES context current");
    
	self.context = aContext;
	[aContext release];
	
    [(EAGLView *)self.view setContext:context];
    [(EAGLView *)self.view setFramebuffer];
	
    animating = FALSE;
    animationFrameInterval = 1;
    self.displayLink = nil;
	
	// Get the bounds of the main screen
	screenBounds = [[UIScreen mainScreen] bounds];
	
	//Setting the accelerometer
	UIAccelerometer *accel = [UIAccelerometer sharedAccelerometer];
    accel.delegate = self;
    accel.updateInterval = 1.0f/100.0f;
	
	// Go and initialise the game entities and graphics etc
	[self initGame];
	
}

-(void)initOpenGL
{
	
	// Switch to GL_PROJECTION matrix mode and reset the current matrix with the identity matrix
	glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	
	// Setup Ortho for the current matrix mode.  This describes a transformation that is applied to
	// the projection.  For our needs we are defining the fact that 1 pixel on the screen is equal to
	// one OGL unit by defining the horizontal and vertical clipping planes to be from 0 to the views
	// dimensions.  The far clipping plane is set to -1 and the near to 1
	
	glOrthof(0, screenBounds.size.width, 0, screenBounds.size.height, -1, 1);
	
	// Switch to GL_MODELVIEW so we can now draw our objects
	glMatrixMode(GL_MODELVIEW);
	
	// Setup how textures should be rendered i.e. how a texture with alpha should be rendered ontop of
	// another texture.  We are setting this to GL_BLEND_SRC by default and not changing it during the
	// game
	glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_BLEND_SRC);
	
	// We are going to be using GL_VERTEX_ARRAY to do all drawing within our game so it can be enabled once
	// If this was not the case then this would be set for each frame as necessary
	glEnableClientState(GL_VERTEX_ARRAY);
	
	// We are not using the depth buffer in our 2D game so depth testing can be disabled.  If depth
	// testing was required then a depth buffer would need to be created as well as enabling the depth
	// test
	glDisable(GL_DEPTH_TEST);
	
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	
	// Set the colour to use when clearing the screen with glClear
	glClearColor(0.0f, 0.0f, 0.0f, 0.5f);
	
	
	
	// Mark OGL as initialised
	glInitialised = YES;	
	
}

- (void)initGame
{
	//Acommodate the world to play horizontally
	glRotatef(90.0f, 0.0f, 0.0f, 1.0f);
	glTranslatef(0.0f, -screenBounds.size.width, 0.0f);
	
	
	glInitialised=NO;
	
	gameScene=[[GameScene alloc] init];
	
	
	font1 = [[AngelCodeFont alloc] initWithFontImageNamed:@"test2.png" controlFile:@"test2" scale:1.0 filter:GL_LINEAR];
	
		
	//NSLog(@"Map Property value = '%@'", [tileMap getMapPropertyForKey:@"MyMapProp" defaultValue:@"default"]);
	//NSLog(@"Collision Property value = '%@'", [tileMap getTilePropertyForGlobalTileID:10 key:@"Collision" defaultValue:@"default"]);
	
	lastTime = CFAbsoluteTimeGetCurrent();

}

- (void)mainGameLoop 
{
	
	// Create variables to hold the current time and calculated delta
	CFTimeInterval		time;
	float				delta;
	
	// This is the heart of the game loop and will keep on looping until it is told otherwise
	//while(true) {
		
		// Create an autorelease pool which can be used within this tight loop.  This is a memory
		// leak when using NSString stringWithFormat in the renderScene method.  Adding a specific
		// autorelease pool stops the memory leak
		NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
		
		// I found this trick on iDevGames.com. The command below pumps events which take place
		// such as screen touches etc so they are handled and then runs our code.  This means
		// that we are always in sync with VBL rather than an NSTimer and VBL being out of sync
		while(CFRunLoopRunInMode(kCFRunLoopDefaultMode, 0.002, TRUE) == kCFRunLoopRunHandledSource);
		
		// Get the current time and calculate the delta between the lasttime and now
		// We multiply the delta by 1000 to give us milliseconds
		time = CFAbsoluteTimeGetCurrent();
		
		delta = (time - lastTime)*1000;
		
		// Go and update the game logic and then render the scene
		[self updateScene:delta];
		[self renderScene];
		
		// Set the lasttime to the current time ready for the next pass
		lastTime = time;
		
		// Release the autorelease pool so that it is drained
		[pool release];
	//}
	
}

- (void)updateScene:(float)delta 
{
	[gameScene update:delta];
}

- (void)renderScene
{
	
	if (!glInitialised) {
		[self initOpenGL];
	}
   
	[(EAGLView *)self.view setFramebuffer];
    glClear(GL_COLOR_BUFFER_BIT);
	
	
	[gameScene render];
	//[font1 drawStringAt:CGPointMake(320, 0) text:@"Test"];

    [(EAGLView *)self.view presentFramebuffer];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration {
	
	[gameScene updateAccelerometer:acceleration];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	
	[gameScene updateTouchesBegan:touches withEvent:event];
	
}


- (void)dealloc
{
    if (program)
    {
        glDeleteProgram(program);
        program = 0;
    }
	[gameScene release];
	[font1 release];
	
    
    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
    
    [context release];
    
    [super dealloc];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self startAnimation];
	    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self stopAnimation];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
    if (program)
    {
        glDeleteProgram(program);
        program = 0;
    }

    // Tear down context.
    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	self.context = nil;	
}

- (NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}

- (void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    /*
	 Frame interval defines how many display frames must pass between each time the display link fires.
	 The display link will only fire 30 times a second when the frame internal is two on a display that refreshes 60 times a second. The default frame interval setting of one will fire 60 times a second when the display refreshes at 60 times a second. A frame interval setting of less than one results in undefined behavior.
	 */
    if (frameInterval >= 1)
    {
        animationFrameInterval = frameInterval;
        
        if (animating)
        {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

- (void)startAnimation
{
    if (!animating)
    {
        //CADisplayLink *aDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(mainGameLoop)];
        //[aDisplayLink setFrameInterval:animationFrameInterval];
        //[aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        //self.displayLink = aDisplayLink;
        gameLoopTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:self selector:@selector(mainGameLoop) userInfo:nil repeats:YES];
        animating = TRUE;
    }
}

- (void)stopAnimation
{
    if (animating)
    {
        //[self.displayLink invalidate];
        //self.displayLink = nil;
		//[gameLoopTimer invalidate];
		//gameLoopTimer=nil;
        animating = FALSE;
    }
}




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

@end
