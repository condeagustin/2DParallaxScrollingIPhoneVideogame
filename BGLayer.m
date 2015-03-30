//
//  BGLayer.m
//  Videogame
//
//  Created by Administrator on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BGLayer.h"



@implementation BGLayer

@synthesize position;
@synthesize speed;
@synthesize direction;
@synthesize horizontalScroller;

- (id)init:(BOOL)horizontal {
	
	self = [super init];
	if(self != nil) {
		// Initialize the array which will hold our background layer images
		position=CGPointMake(0, 0);
		images = [[NSMutableArray alloc] init];
		
		// Set the default values for important properties
		speed = 0;
		direction = -1;
		horizontalScroller=horizontal;
		//length=0;
	}
	return self;
}



- (void)addImage:(Image2D *)image {
	
	[images addObject:image];
	[image release];
	
	
}

- (void)update:(float)delta {
	
	
	position.x+=direction*speed*delta;
	//position.x+=direction*speed*[self getRoundedDelta:delta];
	Image2D *currentImage=[[images objectAtIndex:0] retain];
	Image2D *lastImage=[[images objectAtIndex:[images count]-1] retain];
	
	if (direction==-1){
		if (position.x<-(int)[currentImage imageWidth]) {
			
			
			[images replaceObjectAtIndex:[images count]-1 withObject:currentImage];
			
			for (int index=1; index<[images count]-1; index++) {
				Image2D *image=[images objectAtIndex:index];
				[images replaceObjectAtIndex:index-1 withObject:image];
			}
			
			[images replaceObjectAtIndex:[images count]-2 withObject:lastImage];
			
			
			
			position.x=0;
		}
	}
	else {
		if(position.x>0){
			
			[images replaceObjectAtIndex:0 withObject:lastImage];
			
			for (int index=[images count]-2; index>0; index--) {
				Image2D *image=[images objectAtIndex:index];
				[images replaceObjectAtIndex:index+1 withObject:image];
			}
			
			[images replaceObjectAtIndex:1 withObject:currentImage];
			
			position.x-=[[images objectAtIndex:0] imageWidth];
		}
	}
	
	[lastImage release];
	[currentImage release];

	
}

- (void)render {
	
	float x=position.x;
	float y=position.y;
	
	for (int index=0; index<[images count]; index++) {
		
		if(index!=0){
			x+=[[images objectAtIndex:index-1] imageWidth];
		}
		[[images objectAtIndex:index] renderAtPoint:CGPointMake(x, y) centerOfImage:NO];
		
	}
	

}

- (void)dealloc {
	[images release];
	[super dealloc];
}

@end
