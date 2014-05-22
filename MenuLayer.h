//
//  MenuLayer.h
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 6..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"

@interface MenuLayer : CCLayer {
	CCMenuItem *startMenuItem;
    CCMenuItem *howtoMenuItem;
    CCMenuItem *creditMenuItem;
	
	SimpleAudioEngine *bgmusic;
}

+(CCScene *) scene;

@property (nonatomic, retain) CCMenuItem *startMenuItem;
@property (nonatomic, retain) CCMenuItem *howtoMenuItem;
@property (nonatomic, retain) CCMenuItem *creditMenuItem;



- (void) setBackgroundAndTitles;
- (void) goCreditScene: (id) sender;
- (void) howtoMenuCallback: (id) sender;
- (void) newGameMenuCallback: (id) sender;

@end
