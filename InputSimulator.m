//
//  InputSimulator.m
//  Videogame
//
//  Created by Administrator on 5/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "InputSimulator.h"


@implementation InputSimulator

- (id)initWithCommands:(PlayerCommands*)commands {
	self=[super init];
	if (self!=nil) {
		frameTimer=0.0f;
		playerCommands=commands;
		executionCommands=[[NSMutableArray alloc] init];
		allCommandsExecuted=NO;
	}
	return self;
}

- (void)addCommandWithTime:(float)time withCommand:(int)command {
	ExecutionCommand *execCommand=[[ExecutionCommand alloc] initWithTime:time withCommand:command];
	[executionCommands addObject:execCommand];
	[execCommand release];
}

- (void)update:(float)delta {
	
	if (!allCommandsExecuted) {
		
		allCommandsExecuted=YES;
		for (int index=0; index<[executionCommands count]; index++) {
			ExecutionCommand *execCommand=[executionCommands objectAtIndex:index];
			
			if(![execCommand executed]) {
				allCommandsExecuted=NO;
				if (frameTimer>[execCommand time]) {
					[playerCommands clearCommands];
					switch (execCommand.command) {
						case 1:						
							playerCommands.runningLeft=YES;						
							break;
						case 2:
							playerCommands.runningRight=YES;
							break;
						case 3:
							playerCommands.idle=YES;
							break;
							
						default:
							break;
					}
					
					execCommand.executed=YES;
				}
				
			}
		}
		
		frameTimer+=delta;
		
	}
	
}

- (void)dealloc {
	[executionCommands release];
	[super dealloc];
}

@end
