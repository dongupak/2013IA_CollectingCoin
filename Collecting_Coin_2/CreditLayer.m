//
//  CreditLayer.m
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 7..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "CreditLayer.h"
#import "SceneManager.h"

@implementation CreditLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	CreditLayer *layer = [CreditLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) setBackgroundAndTitles
{
    // 배경 이미지를 표시하기 위해 Sprite를 이용합니다.
    CCSprite *bgSprite = [CCSprite spriteWithFile:@"bg_credit.png"];
    bgSprite.anchorPoint = CGPointZero;
    [bgSprite setPosition: ccp(0, 0)];
    [self addChild:bgSprite z:0 tag:kTagCreditBackground];
    
}

- (id) init {
	if( (self=[super init]) ) {
        [self setBackgroundAndTitles];
		bgmusic=[SimpleAudioEngine sharedEngine];
		[bgmusic playBackgroundMusic:@"bgm_startbg.wav"];
        
        CCMenuItem *close = [CCMenuItemImage itemWithNormalImage:@"bt_menu.png" selectedImage:@"bt_menu_s.png"  target:self selector:@selector(goBack)];
        
        CCMenu *menu = [CCMenu menuWithItems:close, nil];
        menu.position = ccp(160,50);
        [self addChild:menu];
    }
    
    return self;
}

-(void)goBack{
    [SceneManager goMenu];
}

@end
