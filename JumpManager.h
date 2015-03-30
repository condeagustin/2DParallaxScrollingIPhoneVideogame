//
//  JumpManager.h
//  Videogame
//
//  Created by Administrator on 5/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JumpManager : NSObject {
	float Vo;
	float Vox;
	float Voy;
	float throwAngle;
	float gravity;
	float time;
	 
}


@property(nonatomic)float gravity;
@property(nonatomic)float time;

- (id)initWithGravity:(float)pGravity;
- (void)setInitialVelocity:(float)velocity withThrowAngle:(float)angle;
- (float)doJump:(float)delta;

@end
