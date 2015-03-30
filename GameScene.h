//
//  GameScene.h
//  Videogame
//
//  Created by Administrator on 5/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TiledMap.h"
#import "Player.h"
#import "BGLayer.h"
#import "InputSimulator.h"
#import "PlayerCommands.h"
#import "SingletonSoundManager.h"


@interface GameScene : NSObject {
	
	Player *player;
	PlayerCommands *playerCommands;
	InputSimulator *inputSimulator;
	
	
	TiledMap *tiledMap;
	CGPoint position;
	int tileX;
	int horizontalTiles;
	int verticalTiles;
	int widthOffset;
	int heightOffset;
	
	BGLayer *bgLayer1;
	BGLayer *bgLayer2;
	BGLayer *bgLayer3;
	Image2D *supportLayer;
	
	// Sound Manager
	SingletonSoundManager *sharedSoundManager;
	
	
}


- (void)update:(float)delta;
- (void)updateAccelerometer:(UIAcceleration*)acceleration;
- (void)updateTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;
- (void)render;

@end
