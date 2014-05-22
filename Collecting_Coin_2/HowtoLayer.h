//
//  HowtoLayer.h
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 7..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"
#import "cocos2d.h"
#import "SceneManager.h"

enum {
	kTagHowtoBackground = 5000,
	kTagHowtoMenu,
};

@interface HowtoLayer : CCLayer {
	SimpleAudioEngine *bgmusic;
    
}

+(CCScene *) scene;


@end
