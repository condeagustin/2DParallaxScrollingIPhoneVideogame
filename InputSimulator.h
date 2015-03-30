//
//  InputSimulator.h
//  Videogame
//
//  Created by Administrator on 5/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerCommands.h"
#import "ExecutionCommand.h"

@interface InputSimulator : NSObject {
	float frameTimer;
	PlayerCommands *playerCommands;
	NSMutableArray *executionCommands;
	BOOL allCommandsExecuted;
}
- (id)initWithCommands:(PlayerCommands *)commands;
- (void)addCommandWithTime:(float)time withCommand:(int)command;

- (void)update:(float)delta;

@end
