//
//  GameScene.m
//  Videogame
//
//  Created by Administrator on 5/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"


@implementation GameScene

- (id)init {
	self=[super init];
	if (self!=nil) {

		tiledMap=[[TiledMap alloc] initWithTiledFile:@"Level2" fileExtension:@"tmx"];
		position=CGPointMake(0, [tiledMap tileHeight]*([tiledMap mapHeight]-1));
		tileX=0;
		horizontalTiles=480/(int)[tiledMap tileWidth];
		verticalTiles=320/(int)[tiledMap tileHeight];
		
		widthOffset=2;
		heightOffset=1;
		
		playerCommands=[[PlayerCommands alloc] init];
		inputSimulator=[[InputSimulator alloc] initWithCommands:playerCommands];
		
		player=[[Player alloc] initWithLocation:CGPointMake(0, 0) withPlayerCommands:playerCommands];
		[player setScreenPosition:CGPointMake(480/2-[player width]/2, player.screenPosition.y)];
		//[player setScreenPosition:CGPointMake(200, 10)];
		
		
		[inputSimulator addCommandWithTime:0 withCommand:2];
		[inputSimulator addCommandWithTime:3000 withCommand:2];
		[inputSimulator addCommandWithTime:8000 withCommand:1];
		[inputSimulator addCommandWithTime:10000 withCommand:3];
		[inputSimulator addCommandWithTime:11000 withCommand:2];
		[inputSimulator addCommandWithTime:18000 withCommand:3];
		
		
		
		
		supportLayer=[[Image2D alloc] initWithImage:[UIImage imageNamed:@"SupportLayer.png"] filter:GL_LINEAR];
		
		bgLayer1 = [[BGLayer alloc] init:YES];
		[bgLayer1 addImage:[[Image2D alloc] initWithImage:[UIImage imageNamed:@"Layer0_0.png"] filter:GL_LINEAR]];
		[bgLayer1 addImage:[[Image2D alloc] initWithImage:[UIImage imageNamed:@"Layer0_1.png"] filter:GL_LINEAR]];
		[bgLayer1 addImage:[[Image2D alloc] initWithImage:[UIImage imageNamed:@"Layer0_2.png"] filter:GL_LINEAR]];
		[bgLayer1 setSpeed:player.speed/4];
		[bgLayer1 setDirection:-player.direction];
		[bgLayer1 setPosition:CGPointMake(0, 0)];
		
		bgLayer2 = [[BGLayer alloc] init:YES];
		[bgLayer2 addImage:[[Image2D alloc] initWithImage:[UIImage imageNamed:@"Layer1_0.png"] filter:GL_LINEAR]];
		[bgLayer2 addImage:[[Image2D alloc] initWithImage:[UIImage imageNamed:@"Layer1_1.png"] filter:GL_LINEAR]];
		[bgLayer2 addImage:[[Image2D alloc] initWithImage:[UIImage imageNamed:@"Layer1_2.png"] filter:GL_LINEAR]];
		[bgLayer2 setSpeed:player.speed/2];
		[bgLayer2 setDirection:-player.direction];
		[bgLayer2 setPosition:CGPointMake(0, 0)];
		
		bgLayer3 = [[BGLayer alloc] init:YES];
		[bgLayer3 addImage:[[Image2D alloc] initWithImage:[UIImage imageNamed:@"Layer2_0.png"] filter:GL_LINEAR]];
		[bgLayer3 addImage:[[Image2D alloc] initWithImage:[UIImage imageNamed:@"Layer2_1.png"] filter:GL_LINEAR]];
		[bgLayer3 addImage:[[Image2D alloc] initWithImage:[UIImage imageNamed:@"Layer2_2.png"] filter:GL_LINEAR]];
		[bgLayer3 setSpeed:player.speed];
		[bgLayer3 setDirection:-player.direction];
		[bgLayer3 setPosition:CGPointMake(0, 0)];	
		
		sharedSoundManager = [SingletonSoundManager sharedSoundManager];
		
		[sharedSoundManager loadBackgroundMusicWithKey:@"background" fileName:@"background" fileExt:@"mp3"];
		[sharedSoundManager playMusicWithKey:@"background" timesToRepeat:-1];
		[sharedSoundManager setBackgroundMusicVolume:0.5f];
		
		[sharedSoundManager loadSoundWithKey:@"playerFall" fileName:@"PlayerFall" fileExt:@"wav" frequency:44000];
		[sharedSoundManager loadSoundWithKey:@"playerJump" fileName:@"PlayerJump" fileExt:@"wav" frequency:44000];
		[sharedSoundManager loadSoundWithKey:@"playerKilled" fileName:@"PlayerKilled" fileExt:@"wav" frequency:44000];
		
	}
	return self;
}

- (void)update:(float)delta {
	
	//[inputSimulator update:delta];
	[player update:delta];
	
	position.x += -player.direction*player.speed*delta;
	
	if(position.x < (int)-[tiledMap tileWidth]) {
		position.x = 0;
		tileX += 1;
	}
	if (position.x>0) {
		position.x= (int)-[tiledMap tileWidth];
		tileX -= 1;
	}
	
	
	bgLayer1.direction=-player.direction;
	bgLayer1.speed=player.speed/4;
	bgLayer2.direction=-player.direction;
	bgLayer2.speed=player.speed/2;
	bgLayer3.direction=-player.direction;
	bgLayer3.speed=player.speed;
	[bgLayer1 update:delta];
	[bgLayer2 update:delta];
	[bgLayer3 update:delta];
	
}

- (void)updateAccelerometer:(UIAcceleration*)acceleration {
	
	
	[playerCommands clearCommands];
	
	float speed = acceleration.y*1.5f;
	if (speed>0.8f) {
		speed=0.8f;
	}
	
	if (speed<-0.8f) {
		speed=-0.8f;
	}
	
	if (acceleration.y>=-0.1f && acceleration.y<=0.1f) {
		playerCommands.idle=YES;
		playerCommands.speed=0;
	}
	
	if (speed>0.15f) {
		playerCommands.runningRight=YES;
		playerCommands.speed=speed;
	}
	
	if (speed<-0.15f) {
		playerCommands.runningLeft=YES;
		playerCommands.speed=-1*speed;
	}
	
	if (acceleration.x<0.4f && acceleration.z>-0.5f) {
		playerCommands.jumping=YES;
	}
	
	

}


- (void)updateTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
	//UITouch *touch=[touches anyObject];
	//CGPoint location=[touch locationInView:[touch view]];
	//CGPoint gameTouchLocation=CGPointMake(480-location.y, 320-location.x);
	//NSLog(@"touchX: %f, touchY: %f", gameTouchLocation.x, gameTouchLocation.y);
	//[playerCommands clearCommands];
	//playerCommands.jumping=YES;
	if (!player.isInAir) {
		[player prepareForJump];
	}
	
	
	
	
}

- (void)render {
	
	[supportLayer renderAtPoint:CGPointMake(0, 0) centerOfImage:NO];
	[bgLayer1 render];
	[bgLayer2 render];
	[bgLayer3 render];
	
	[tiledMap renderAtPoint:position mapX:tileX mapY:0 width:horizontalTiles+widthOffset height:verticalTiles+heightOffset layer:0];
	
	[player render];
	
}

- (void)dealloc {
	[player release];
	[tiledMap release];
	[bgLayer1 release];
	[bgLayer2 release];
	[bgLayer3 release];
	[supportLayer release];
	[playerCommands release];
	[inputSimulator release];
	[super dealloc];
}

@end
