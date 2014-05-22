//
//  GameLayer.h
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 6..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "SimpleAudioEngine.h"
#import "AppDelegate.h"
#import "MessageNode.h"
#import "SceneManager.h"

@interface GameLayer : CCLayer {
    CGSize winSize;
    
	NSMutableArray *starSprites;
	NSMutableArray *coinSprites;
	NSMutableArray *fakeSprites;
	NSMutableArray *billSprites;
	NSMutableArray *bugSprites;
	NSMutableArray *removeSprites;
	
	
    AppController *appDelegate;
    
    CCLabelTTF *scoreLabel;        // 점수와 라이프를 보여주는 레이블
    CCLabelTTF *lifeLabel;
	
    CCSprite *character; //character 삽입
	CCMenu *pause;
    CCMenu *play;
    
    CCSprite *bug;
	
    NSInteger gameScore;     // 게임 점수와 life 개수
	NSInteger gameLife;
	
	MessageNode *message;
	
	SimpleAudioEngine *music;
	SimpleAudioEngine *bgMusic;
	
	
	BOOL isCharacterTouched;
		
}

@property (retain,nonatomic) NSMutableArray *starSprites;
@property (retain,nonatomic) NSMutableArray *coinSprites;
@property (retain,nonatomic) NSMutableArray *fakeSprites;
@property (retain,nonatomic) NSMutableArray *billSprites;
@property (retain,nonatomic) NSMutableArray *bugSprites;

@property (nonatomic, retain) CCLabelTTF *scoreLabel;
@property (nonatomic, retain) CCLabelTTF *lifeLabel;
+(CCScene *) scene;

- (void) setBackgroundAndTitles;
- (void)makingLabel;
- (void)createCharacter;
- (void) createSprite;
- (void) scheduleCollisionCoin;
- (void) scheduleCollisionStar;
- (void) scheduleCollisionFake;
- (void) scheduleCollisionBill;
- (void) scheduleCollisionBug;
- (void) sendRemoveSprites;
- (void) removeAllSprites;
- (void) checkCollision : (NSMutableArray*) array;
- (void) collisionBug;
- (void) increaseLife;
- (void) decreaseLife;
- (void) updateScore;
- (void) goBack;
- (void) closeMenuCallback: (id) sender;
- (void) gotoGameOverLayer;
- (void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) GameOver;

@end
