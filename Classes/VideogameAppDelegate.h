//
//  VideogameAppDelegate.h
//  Videogame
//
//  Created by Administrator on 3/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VideogameViewController;

@interface VideogameAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    VideogameViewController *viewController;
	
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet VideogameViewController *viewController;

@end

