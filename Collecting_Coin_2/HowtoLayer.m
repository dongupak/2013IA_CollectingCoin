//
//  HowtoLayer.m
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 7..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "HowtoLayer.h"


@implementation HowtoLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HowtoLayer *layer = [HowtoLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id) init {
	if((self = [super init])) {
		bgmusic=[SimpleAudioEngine sharedEngine];
		[bgmusic playBackgroundMusic:@"bgm_startbg.wav"];
		
		CCSprite *bgSprite = [CCSprite spriteWithFile:@"bg_howto.png"];
		[bgSprite setAnchorPoint:CGPointZero];
		[bgSprite setPosition:CGPointZero];
		[self addChild:bgSprite z:0 tag:kTagHowtoBackground];
        
		CCMenuItem *closeMenuItem = [CCMenuItemImage itemWithNormalImage:@"bt_menu.png"
														   selectedImage:@"bt_menu_s.png"
																  target:self
																selector:@selector(closeMenuCallback:)];
		CCMenu *menu = [CCMenu menuWithItems:closeMenuItem, nil];
		menu.position = CGPointMake(160, 40);
		[self addChild:menu z:3 tag:kTagHowtoMenu];
	}
	return self;
}

- (void) closeMenuCallback: (id) sender
{
    //  장면에서 빠져나올적에는 iAD를 removeChild 시키자
	[SceneManager goMenu];
}

@end
