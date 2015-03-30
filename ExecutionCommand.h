//
//  ExecutionCommand.h
//  Videogame
//
//  Created by Administrator on 5/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ExecutionCommand : NSObject {

	float time;
	//1=runningLeft, 2=runningRight, 3=idle
	int command;
	BOOL executed;
}

@property(nonatomic, readonly)float time;
@property(nonatomic, readonly)int command;
@property(nonatomic)BOOL executed;

- (id)initWithTime:(float)time withCommand:(int)command;

@end
