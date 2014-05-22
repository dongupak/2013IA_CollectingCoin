//
//  CreditLayer.h
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 7..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SimpleAudioEngine.h"
#import "cocos2d.h"

enum {
	kTagCreditBackground = 3000,
	kTagCreditMenu,
};

@interface CreditLayer : CCLayer {
    SimpleAudioEngine *bgmusic;
}

+(CCScene *) scene;


@end
