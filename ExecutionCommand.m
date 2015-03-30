//
//  ExecutionCommand.m
//  Videogame
//
//  Created by Administrator on 5/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExecutionCommand.h"


@implementation ExecutionCommand

@synthesize time;
@synthesize command;
@synthesize executed;

- (id)initWithTime:(float)pTime withCommand:(int)pCommand {
	self=[super init];
	if (self!=nil) {
		time=pTime;
		command=pCommand;
		executed=NO;
	}
	return self;
}

@end
