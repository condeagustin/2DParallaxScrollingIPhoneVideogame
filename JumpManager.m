//
//  JumpManager.m
//  Videogame
//
//  Created by Administrator on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "JumpManager.h"


@interface JumpManager (Private)

- (void)calculateVelocityComponents;

@end



@implementation JumpManager

@synthesize gravity;
@synthesize time;

- (id)initWithGravity:(float)pGravity {
	self=[super init];
	if (self!=nil) {
		Vo=0.0f;
		throwAngle=0.0f;
		gravity=pGravity;
		time=0.0f;
	}
	return self;
}

- (void)setInitialVelocity:(float)velocity withThrowAngle:(float)angle {
	Vo=velocity;
	throwAngle=angle;
	[self calculateVelocityComponents];
}


- (void)calculateVelocityComponents {
	float angleInRadians=throwAngle*M_PI/180;
	Voy=Vo*sin(angleInRadians);
	Vox=Vo*cos(angleInRadians);
}




- (float)doJump:(float)delta {
	
	//float x=Vox*time;
	
	//float y=Voy*time+(gravity*pow(time, 2))/2;
	float y=Voy*time+((gravity*pow(time, 2))/2);
	
	//CGPoint jumpTranslation=CGPointMake(x, y);
	
	time+=delta/1000;
	
	return y;
	
}

@end
