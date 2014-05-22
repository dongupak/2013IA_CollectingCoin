//
//  GameOverLayer.m
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 7..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "GameOverLayer.h"
#import "SceneManager.h"

@implementation GameOverLayer

@synthesize goMenuItem,gameStartMenuItem;

-(id)init{
    if( (self = [super init]) ){
		
		CCSprite *bgSprite = [CCSprite spriteWithFile:@"bg_gameover.png"];
		bgSprite.anchorPoint = CGPointZero;
		[bgSprite setPosition: ccp(0, 0)];
		[self addChild:bgSprite z:kTagBackground tag:kTagBackground];
		
		music=[SimpleAudioEngine sharedEngine];
		[music playBackgroundMusic:@"bgm_gameover.mp3"];

		
        appDelegate = (AppController *)[[UIApplication sharedApplication] delegate];
        
        totalScore = appDelegate.gameScore;
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
		
		NSString *str = [[NSString alloc] initWithFormat:@"%5d",totalScore];
		
        CCLabelTTF *score = [CCLabelTTF labelWithString:str
                                               fontName:@"Arial"
                                               fontSize:30];
		score.color = ccc3(0,0,0);
		score.anchorPoint = CGPointZero;
        score.position = ccp(70, 205);
        [self addChild:score z:1000];
        
		self.goMenuItem     = [CCMenuItemImage itemWithNormalImage:@"btn_remenu.png"
                                                        selectedImage:@"btn_remenu.png"
                                                               target:self
                                                             selector:@selector(goMenuScene:)];
        
        
        self.gameStartMenuItem       = [CCMenuItemImage itemWithNormalImage:@"btn_restart.png"
                                                          selectedImage:@"btn_restart.png"
                                                                 target:self
                                                               selector:@selector(newGameMenuCallback:)];
        
		self.goMenuItem.position = ccp(size.width*2.0/8.0, size.height*2.0/24.0);
		self.gameStartMenuItem.position = ccp(size.width*6.0/8.0,size.height*2.0/24.0);
		
		CCMenu *menu = [CCMenu menuWithItems:self.goMenuItem,self.gameStartMenuItem,nil];
        menu.position = CGPointZero;
		menu.position = ccp(160, 70);
		[menu alignItemsHorizontally];
        [self addChild:menu z:2100 tag:kTagMenu];

    }
    
    return self;
}
- (void) goMenuScene: (id) sender
{
	[SceneManager goMenu];
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

// 메뉴 아이템(버튼)을 만들 때 이벤트 핸들러로 등록된 메소드를 만듭니다.
- (void) newGameMenuCallback: (id) sender
{
    [SceneManager goGame];
}


+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameOverLayer *layer = [GameOverLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}@end
