//
//  BGLayer.h
//  Videogame
//
//  Created by Administrator on 4/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Image2D.h"

@interface BGLayer : NSObject {
	
	CGPoint position;
	float speed;
	int direction;
	BOOL horizontalScroller;
	NSMutableArray *images;
	//int length;

}
@property(nonatomic)CGPoint position;
@property(nonatomic)float speed;
@property(nonatomic)int direction;
@property(nonatomic,readonly)BOOL horizontalScroller;

- (id)init:(BOOL)horizontal;
- (void)addImage:(Image2D*)image;
- (void)update:(float)delta;
- (void)render;

@end
