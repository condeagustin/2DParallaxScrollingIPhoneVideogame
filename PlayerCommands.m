//
//  PlayerCommands.m
//  Videogame
//
//  Created by Administrator on 5/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PlayerCommands.h"


@implementation PlayerCommands

@synthesize runningLeft;
@synthesize runningRight;
@synthesize idle;
@synthesize jumping;
@synthesize speed;


- (id)init {
	self=[super init];
	if (self!=nil) {
		runningLeft=NO;
		runningRight=NO;
		idle=NO;
		jumping=NO;
		speed=0.0f;
	}
	return self;
}

- (void)clearCommands {
	runningLeft=NO;
	runningRight=NO;
	idle=NO;
	jumping=NO;
}


@end
