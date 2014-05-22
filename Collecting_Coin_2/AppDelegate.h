//
//  AppDelegate.h
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 6..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cocos2d.h"

@interface AppController : NSObject <UIApplicationDelegate, CCDirectorDelegate>
{
	UIWindow *window_;
	UINavigationController *navController_;

	NSInteger       gameScore;
	NSInteger       gameLife;
	CCDirectorIOS	*director_;							// weak ref
}

@property (nonatomic, retain) UIWindow *window;
@property (readonly) UINavigationController *navController;
@property (readonly) CCDirectorIOS *director;

@property (readwrite) NSInteger       gameScore;
@property (readwrite) NSInteger       gameLife;

@end
