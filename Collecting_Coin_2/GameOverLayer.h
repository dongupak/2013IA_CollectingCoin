//
//  GameOverLayer.h
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 7..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"
#import "cocos2d.h"
#import "AppDelegate.h"
#import "SceneManager.h"

enum {
	kTagBackground = 0,
	kTagMenu,
};

@interface GameOverLayer : CCLayer {
	CCMenuItem *goMenuItem;
    CCMenuItem *gameStartMenuItem;

	AppController *appDelegate;
    NSInteger totalScore;
	
	SimpleAudioEngine *music;
}

- (void) goMenuScene: (id) sender;
- (void) newGameMenuCallback: (id) sender;


+(CCScene *) scene;

@property (nonatomic, retain) CCMenuItem *goMenuItem;
@property (nonatomic, retain) CCMenuItem *gameStartMenuItem;

@end
