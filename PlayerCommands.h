//
//  PlayerCommands.h
//  Videogame
//
//  Created by Administrator on 5/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlayerCommands : NSObject {
	
	BOOL runningLeft;
	BOOL runningRight;
	BOOL idle;
	BOOL jumping;
	float speed;
	
	
}
@property(nonatomic)BOOL runningLeft;
@property(nonatomic)BOOL runningRight;
@property(nonatomic)BOOL idle;
@property(nonatomic)BOOL jumping;
@property(nonatomic)float speed;

- (void)clearCommands;

@end
