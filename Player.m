//
//  Player.m
//  Videogame
//
//  Created by Administrator on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "SingletonSoundManager.h"

@implementation Player

@synthesize screenPosition;
@synthesize worldPosition;
@synthesize speed;
@synthesize direction;
@synthesize isInAir;
@synthesize width;
@synthesize height;


- (id)initWithLocation:(CGPoint)location withPlayerCommands:(PlayerCommands*)commands {
	self=[super init];
	if (self!=nil) {
		screenPosition=location;
		worldPosition=CGPointMake(location.x, 320-location.y);
		speed=0.15f;
		direction=1;
		isInAir=NO;
		width=96;
		height=96;
		
		jumpManager=[[JumpManager alloc] initWithGravity:-11.5f];
		
		playerCommands=commands;
		
		playerSpriteSheet=[[SpriteSheet alloc] initWithImageNamed:@"MainPlayer.png" spriteWidth:96 spriteHeight:96 spacing:0 imageScale:1.0f];
		
		runningLeft=[[Animation alloc] init];
		for(int index=0; index<10; index++)
		{
			Image2D *image=[playerSpriteSheet getSpriteAtX:index y:0];
			[runningLeft addFrameWithImage:image delay:80];
			
		}
		
		runningRight=[[Animation alloc] init];
		for(int index=0; index<10; index++)
		{
			Image2D *image=[playerSpriteSheet getSpriteAtX:index y:0];
			[image setFlipHorizontally:YES];
			[runningRight addFrameWithImage:image delay:80];
			
		}
		
		
		jumpingLeft=[[Animation alloc] init];
		for(int index=0; index<10; index++)
		{
			Image2D *image=[playerSpriteSheet getSpriteAtX:index y:1];
			[jumpingLeft addFrameWithImage:image delay:(index+1)*30];
			
		}
		
		jumpingRight=[[Animation alloc] init];
		for(int index=0; index<10; index++)
		{
			Image2D *image=[playerSpriteSheet getSpriteAtX:index y:1];
			[image setFlipHorizontally:YES];
			[jumpingRight addFrameWithImage:image delay:(index+1)*30];
			
		}
		
		dyingLeft=[[Animation alloc] init];
		for(int index=0; index<10; index++)
		{
			Image2D *image=[playerSpriteSheet getSpriteAtX:index y:2];
			[dyingLeft addFrameWithImage:image delay:80];
			
		}
		
		dyingRight=[[Animation alloc] init];
		for(int index=0; index<10; index++)
		{
			Image2D *image=[playerSpriteSheet getSpriteAtX:index y:2];
			[image setFlipHorizontally:YES];
			[dyingRight addFrameWithImage:image delay:80];
			
		}
		
		cheeringLeft=[[Animation alloc] init];
		for(int index=0; index<10; index++)
		{
			Image2D *image=[playerSpriteSheet getSpriteAtX:index y:3];
			[cheeringLeft addFrameWithImage:image delay:80];
			
		}
		
		cheeringRight=[[Animation alloc] init];
		for(int index=0; index<10; index++)
		{
			Image2D *image=[playerSpriteSheet getSpriteAtX:index y:3];
			[image setFlipHorizontally:YES];
			[cheeringRight addFrameWithImage:image delay:80];
		}
		
		idle=[[Animation alloc] init];
		Image2D *image=[playerSpriteSheet getSpriteAtX:0 y:4];
		[idle addFrameWithImage:image delay:80];
		
		currentAnimation=idle;
	}
	return self;
	
}

- (void)updateAnimationDelay:(Animation*)animation{
	
	for (int index=0; index<[animation getAnimationFrameCount]; index++) {
		Frame *frame=[animation getFrame:index];
		frame.frameDelay=80-((60/0.65f)*(speed-0.15f));
	}
}

- (void)prepareForJump {
	
	isInAir=YES;
	
	[[SingletonSoundManager sharedSoundManager] playSoundWithKey:@"playerJump" gain:1.0f pitch:1.0f shouldLoop:NO];
	if(speed==0)
		speed=0.8f;
	[jumpManager setInitialVelocity:speed*12 withThrowAngle:60];
	if (direction==1)
		currentAnimation=jumpingRight;
	else
		currentAnimation=jumpingLeft;
	
	[currentAnimation setRunning:YES];
	[currentAnimation setRepeat:NO];
	
}

- (void)update:(float)delta {
	
	speed=playerCommands.speed;
	
	if (!isInAir) {
		
		if (playerCommands.jumping) {
			[self prepareForJump];
			
		}
		else {
			
			if (playerCommands.runningLeft) {
				direction=-1;
				currentAnimation=runningLeft;
				
			}
			
			if (playerCommands.runningRight) {
				direction=1;
				currentAnimation=runningRight;
				
			}
			if (playerCommands.idle){
				currentAnimation=idle;
			}
			
			
			if (speed!=0) {
				[self updateAnimationDelay:currentAnimation];
				[currentAnimation update:delta];
				[currentAnimation setRunning:YES];
				[currentAnimation setRepeat:YES];
			}
			else {
				[currentAnimation setRunning:NO];
				[currentAnimation setRepeat:NO];
			}
			
			
		}
	}
	else {
		
		float y = [jumpManager doJump:delta];
		
		screenPosition.y+=y;
		
		[currentAnimation update:delta];
		
		if (screenPosition.y<0) {
			screenPosition.y=0;
			jumpManager.time=0.0f;
			isInAir=NO;
		}
	}


}

- (void)render {
	[currentAnimation renderAtPoint:screenPosition];
}


-(void)dealloc {
	[playerSpriteSheet release];
	[runningLeft release];
	[runningRight release];
	[jumpingLeft release];
	[jumpingRight release];
	[dyingLeft release];
	[dyingRight release];
	[cheeringLeft release];
	[cheeringRight release];
	[idle release];
	[super dealloc];
}



@end
