//
//  Player.h
//  Videogame
//
//  Created by Administrator on 5/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animation.h"
#import "SpriteSheet.h"
#import "PlayerCommands.h"
#import "JumpManager.h"


@interface Player : NSObject {

	CGPoint screenPosition;
	CGPoint worldPosition;
	float speed;
	int direction;
	BOOL isInAir;
	uint width;
	uint height;
	SpriteSheet *playerSpriteSheet;
	Animation *runningLeft;
	Animation *runningRight;
	Animation *jumpingLeft;
	Animation *jumpingRight;
	Animation *dyingLeft;
	Animation *dyingRight;
	Animation *cheeringLeft;
	Animation *cheeringRight;
	Animation *idle;
	Animation *currentAnimation;
	PlayerCommands *playerCommands;
	
	JumpManager *jumpManager;
}

@property(nonatomic)CGPoint screenPosition;
@property(nonatomic)CGPoint worldPosition;
@property(nonatomic)float speed;
@property(nonatomic)int direction;
@property(nonatomic)BOOL isInAir;
@property(nonatomic)uint width;
@property(nonatomic)uint height;


- (id)initWithLocation:(CGPoint)location withPlayerCommands:(PlayerCommands*)commands;
- (void)update:(float)delta;
- (void)render;
- (void)prepareForJump;

@end
