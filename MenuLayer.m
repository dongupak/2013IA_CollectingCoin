//
//  MenuLayer.m
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 6..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "MenuLayer.h"
#import "SceneManager.h"


@implementation MenuLayer

enum {
    kTagBackground1 = 9000,
    kTagGameCharacter,
    kTagGameTitle,
    kTagMenu1,
};

@synthesize startMenuItem, howtoMenuItem;
@synthesize creditMenuItem;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MenuLayer *layer = [MenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id) init {
	if( (self=[super init]) ) {
        [self setBackgroundAndTitles];
		bgmusic=[SimpleAudioEngine sharedEngine];		
		[bgmusic playBackgroundMusic:@"bgm_startbg.wav"];
		
        // 메뉴 버튼을 만듭니다.
        // itemFromNormalImage는 버튼이 눌려지기 전에 보여지는 이미지이고,
        // selectedImage는 버튼이 눌려졌을 때 보여지는 이미지입니다.
        // target을 self로 한 것은 버튼이 눌려졌을 때 발생하는 터치 이벤트를 MeneScene에서
        // 처리를 하겠다는 것입니다.
        // @selector를 이용하여 버튼이 눌려졌을 때 어떤 메소드에서 처리를 할 것인지 결정합니다.
        self.startMenuItem     = [CCMenuItemImage itemWithNormalImage:@"btn_start.png"
                                                        selectedImage:@"btn_start_s.png"
                                                               target:self
                                                             selector:@selector(newGameMenuCallback:)];
        
        
        self.howtoMenuItem       = [CCMenuItemImage itemWithNormalImage:@"btn_howto.png"
                                                          selectedImage:@"btn_howto_s.png"
                                                                 target:self
                                                               selector:@selector(howtoMenuCallback:)];
        
		self.startMenuItem.position = ccp(160, 230);
		self.howtoMenuItem.position = ccp(160, 170);
        
        
        self.creditMenuItem = [CCMenuItemImage itemWithNormalImage:@"btn_credit.png"
                                                     selectedImage:@"btn_credit_s.png"
                                                            target:self
                                                          selector:@selector(goCreditScene:)];
		self.creditMenuItem.position = ccp(160,110);
        
        // 각종 메뉴 추가 부분
        // 위에서 만들어지 각각의 메뉴 아이템들을 CCMenu에 넣습니다.
        // CCMenu는 각각의 메뉴 버튼이 눌려졌을 때 발생하는 터치 이벤트를 핸들링하고,
        // 메뉴 버튼들이 어떻게 표시될 것인 지 레이아웃 처리를 담당합니다.
        CCMenu *menu = [CCMenu menuWithItems:
                        self.startMenuItem,
						self.howtoMenuItem,
                        self.creditMenuItem,
						nil];
        menu.position = CGPointZero;
		//menu.position = ccp(160, 240);
        [self addChild:menu z:2100 tag:kTagMenu1];
    }
    
	return self;
}

- (void) setBackgroundAndTitles
{
    // 배경 이미지를 표시하기 위해 Sprite를 이용합니다.
    CCSprite *bgSprite = [CCSprite spriteWithFile:@"bg_menu.png"];
    bgSprite.anchorPoint = CGPointZero;
    [bgSprite setPosition: ccp(0, 0)];
    [self addChild:bgSprite z:0 tag:kTagBackground1];
    
}


// Credit Scene으로 이동
- (void) goCreditScene: (id) sender
{
	[SceneManager goCredit];
}

- (void) howtoMenuCallback: (id) sender
{
	[SceneManager goHowto];
}

// 메뉴 아이템(버튼)을 만들 때 이벤트 핸들러로 등록된 메소드를 만듭니다.
- (void) newGameMenuCallback: (id) sender
{
    [SceneManager goGame];
}


@end
