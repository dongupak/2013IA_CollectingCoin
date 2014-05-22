//
//  GameLayer.m
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 6..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"


@implementation GameLayer

@synthesize coinSprites;
@synthesize starSprites;
@synthesize fakeSprites;
@synthesize billSprites;
@synthesize bugSprites;
@synthesize scoreLabel,lifeLabel;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameLayer *layer = [GameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

float createRandomNumber(int min, int max)
{
	int t = arc4random()%(max-min);
	
	return (t+min)*1.0f; // 실수로 바꾸어서 반환함
}

#define createTimes   (2)
#define removeTimes   (2)
#define collisionTimes (0.1)

- (id) init {
	if( (self=[super init]) ) {
		self.isTouchEnabled = YES;
		
		winSize = [CCDirector sharedDirector].winSize;
		
		
        appDelegate = (AppController *)[[UIApplication sharedApplication] delegate];
        appDelegate.gameScore = 0;
		appDelegate.gameLife = 3;
        
        coinSprites = [NSMutableArray new];
		starSprites = [NSMutableArray new];
		fakeSprites = [NSMutableArray new];
		billSprites = [NSMutableArray new];
		bugSprites = [NSMutableArray new];
		removeSprites = [NSMutableArray new]; 
        
		// audio engine
		music=[SimpleAudioEngine sharedEngine];
		bgMusic=[SimpleAudioEngine sharedEngine];
		
		[bgMusic playBackgroundMusic:@"bgm_background.wav"];
		
		message = [[MessageNode alloc]init];
		[self addChild:message z:30];
		
		[self setBackgroundAndTitles];
		[self makingLabel];
		
		CCMenuItem *pmenu = [CCMenuItemImage itemWithNormalImage:@"btn_pause.png"
                                                   selectedImage:@"btn_pause.png"
                                                          target:self
                                                        selector:@selector(click1)];
        pause = [CCMenu menuWithItems:pmenu, nil];
        [pause alignItemsVertically];
        pause.position = ccp(160, 440);
        pause.opacity = 150;
        [self addChild:pause z:2100];
        
        
        bug = [CCSprite spriteWithFile:@"collision_bug.png"];
        bug.position = ccp(160, 240);
        bug.opacity = 0;
        [self addChild:bug z:1];
		
		
		[self createCharacter];
		
		[self schedule:@selector(createSprite) interval:createTimes];
		
		[self schedule:@selector(scheduleCollisionCoin) interval:collisionTimes];
		[self schedule:@selector(scheduleCollisionStar) interval:collisionTimes];
		[self schedule:@selector(scheduleCollisionFake) interval:collisionTimes];
		[self schedule:@selector(scheduleCollisionBill) interval:collisionTimes];
		[self schedule:@selector(scheduleCollisionBug) interval:collisionTimes];
		
		[self schedule:@selector(sendRemoveSprites) interval:removeTimes];
		[self schedule:@selector(removeAllSprites) interval:removeTimes];
    }
    
	return self;
}

#pragma mark Create

- (void) setBackgroundAndTitles
{
    // 배경 이미지를 표시하기 위해 Sprite를 이용합니다.
    CCSprite *bgSprite = [CCSprite spriteWithFile:@"background.jpg"];
    bgSprite.anchorPoint = CGPointZero;
    [bgSprite setPosition: ccp(0, 0)];
    [self addChild:bgSprite z:0 tag:6000];
    
}


-(void)makingLabel{
    CGSize size = [[CCDirector sharedDirector] winSize];
	
	scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Score \n %d", appDelegate.gameScore] fontName:@"Dgyoung" fontSize:30];
	scoreLabel.color = ccBLACK;
	scoreLabel.position = ccp(size.width*2/ 8.0, size.height * 22.0 / 24.0);
	[self addChild:scoreLabel z:200];
	
	lifeLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Life : %d", appDelegate.gameLife] fontName:@"Dgyoung" fontSize:30];
	lifeLabel.color = ccBLACK;
	lifeLabel.position = ccp(size.width*6.0/ 8.0, size.height * 22.5 / 24.0);
	[self addChild:lifeLabel z:200];
	
}

-(void)createCharacter //main character 배치
{
    character = [[CCSprite alloc] initWithFile:@"character_main.png"];
    character.position = ccp(160,50);
    [self addChild:character];
    
}

#define coinTag 1000
#define starTag 1001
#define fakeTag 1002
#define billTag 1003
#define bugTag 1004

- (void) createSprite {
	
	CCSprite *item = nil;
	
	int itemRandom = arc4random() % 12;
	switch (itemRandom) {
		case 0:
		case 1:
			item = [CCSprite spriteWithFile:@"coin1.png"];
			item.tag = coinTag;
			[coinSprites addObject:item];
			break;
		case 2:
		case 3:
			item = [CCSprite spriteWithFile:@"coin2.png"];
			item.tag = coinTag;
			[coinSprites addObject:item];
			break;
		case 4:
		case 5:
			item = [CCSprite spriteWithFile:@"star.png"];
			item.tag = starTag;
			[starSprites addObject:item];
			break;
		case 6:
		case 7:
			item = [CCSprite spriteWithFile:@"bill.png"];
			item.tag = billTag;
			[billSprites addObject:item];
			break;
		case 8:
		case 9:
			item = [CCSprite spriteWithFile:@"fake.png"];
			item.tag = fakeTag;
			[fakeSprites addObject:item];
			break;
		case 10:
		case 11:
		case 12:
			item = [CCSprite spriteWithFile:@"bug.png"];
			item.tag = bugTag;
			[bugSprites addObject:item];
			break;

		default:
			break;
	}
	
	int halfOfItemWidth = item.contentSize.width/2;
	int itemHeight = item.contentSize.height;
	int pointX = createRandomNumber(halfOfItemWidth, winSize.width - halfOfItemWidth);
	float pointY = -itemHeight;
	float timeDuration = createRandomNumber(100, 400)/60.0f; //default time duration
	
	item.position = ccp(pointX, winSize.height + halfOfItemWidth);
	
	[self addChild:item];
	
	id actionMove = [CCMoveTo actionWithDuration:timeDuration position:ccp(item.position.x, pointY)];
	[item runAction:actionMove];
}


#pragma mark Logic

- (void)click1
{
    [self removeChild:pause cleanup:YES];
    [[CCDirector sharedDirector] pause];
    
    CCMenuItem *pmenu = [CCMenuItemImage itemWithNormalImage:@"btn_play.png"
                                               selectedImage:@"btn_play.png"
                                                      target:self
                                                    selector:@selector(click2)];
    play = [CCMenu menuWithItems:pmenu, nil];
    [play alignItemsVertically];
    play.position = ccp(160, 440);
    play.opacity = 200;
    [self addChild:play z:2100];
}
- (void)click2
{
    [self removeChild:play cleanup:YES];
    [[CCDirector sharedDirector] resume];
    CCMenuItem *pmenu = [CCMenuItemImage itemWithNormalImage:@"btn_pause.png"
                                               selectedImage:@"btn_pause.png"
                                                      target:self
                                                    selector:@selector(click1)];
    pause = [CCMenu menuWithItems:pmenu, nil];
    [pause alignItemsVertically];
    pause.position = ccp(160, 440);
    pause.opacity = 150;
    [self addChild:pause z:2100];
	
}
- (void) scheduleCollisionCoin {
	[self checkCollision:coinSprites];
}

- (void) scheduleCollisionStar {
	[self checkCollision:starSprites];
}

- (void) scheduleCollisionFake {
	[self checkCollision:fakeSprites];
}
- (void) scheduleCollisionBill {
	[self checkCollision:billSprites];
}
- (void) scheduleCollisionBug {
	[self checkCollision:bugSprites];
}
-(void) sendRemoveSprites {
	for (CCSprite *sp in coinSprites) {
		if (sp.position.y < 0) {
			[coinSprites removeObject:sp];
			appDelegate.gameScore -=1;
			[removeSprites addObject:sp];
			break;
		}
	}
	for (CCSprite *sp in starSprites) {
		if (sp.position.y < 0) {
			[starSprites removeObject:sp];
			appDelegate.gameScore -=1;
			[removeSprites addObject:sp];
			break;
		}
	}
	for (CCSprite *sp in fakeSprites) {
		if (sp.position.y < 0) {
			[fakeSprites removeObject:sp];
			appDelegate.gameScore +=1;
			[removeSprites addObject:sp];
			break;
		}
	}
	for (CCSprite *sp in billSprites) {
		if (sp.position.y < 0) {
			[billSprites removeObject:sp];
			appDelegate.gameScore -=1;
			[removeSprites addObject:sp];
			break;
		}
	}
	for (CCSprite *sp in bugSprites) {
		if (sp.position.y < 0) {
			[bugSprites removeObject:sp];
			appDelegate.gameScore +=1;
			[removeSprites addObject:sp];
			break;
		}
	}

}
-(void) removeAllSprites {
	for (CCSprite *sp in removeSprites) {
		[self removeChild:sp cleanup:YES];
		
	}
}
-(void) checkCollision : (NSMutableArray*) array
{
	for (CCSprite *object in array) {
		if (CGRectIntersectsRect(object.boundingBox, character.boundingBox)) {
			id fadeOut = [CCFadeOut actionWithDuration:0.1];
			[object stopAllActions];
			[object runAction:fadeOut];
			[array removeObject:object];
			[removeSprites addObject:object];
						
            if (object.tag == coinTag) {
                appDelegate.gameScore += 1;
				[message showMessage:SCOREONE_MESSAGE];
				[music playEffect:@"bgm_coin.mp3"];
            }
            else if (object.tag == starTag)
			{
				[message showMessage:LIFEPLUS_MESSAGE];
				[music playEffect:@"bgm_star.wav"];
				[self increaseLife];
            }
            else if (object.tag == fakeTag)
			{
				[message showMessage:LIFEMINUS_MESSAGE];
				[music playEffect:@"bgm_coin.mp3"];
				[self decreaseLife];
            }
			else if (object.tag == billTag)
			{
				appDelegate.gameScore += 10;
				[message showMessage:SCORETEN_MESSAGE];
				[music playEffect:@"bgm_coin.mp3"];
            }
			else if (object.tag == bugTag)
			{
				[self collisionBug];
				[music playEffect:@"bgm_laugh.wav"];
            }

			if(gameScore < 0) gameScore = 0; // 점수가 마이너스가 되는것을 방지
			
			[self updateScore];
			                      
			NSLog(@"score : %d, life : %d", appDelegate.gameScore, appDelegate.gameLife);
            
			break;
			
		}
	}
}
-(void) decreaseLife{
	appDelegate.gameLife -= 1;
	
	if (appDelegate.gameLife <=0)
		[self performSelector:@selector(GameOver)withObject:nil afterDelay:0.1];
	
	[self updateLifeLabel];
}
-(void) increaseLife{
	if (appDelegate.gameLife <3) {
		appDelegate.gameLife += 1;
	}
	else{
		appDelegate.gameLife +=0;
	}
	
	[self updateLifeLabel];
	
	
}
-(void) collisionBug{
	
	id action1 = [CCScaleTo actionWithDuration:2.0 scale:10.0];
	id action2 = [CCDelayTime actionWithDuration:1.0];
	id action3 = [CCScaleTo actionWithDuration:2.0 scale:1.0];
    id action4 = [CCFadeIn actionWithDuration:0.5];
    id action5 = [CCFadeOut actionWithDuration:0.5];
	id totalAction = [CCSequence actions:action4,action1,action2,action3,action5, nil];
	
	[bug runAction:totalAction];
    [self runAction:[CCSequence actions: [CCCallFuncN actionWithTarget:self selector:@selector(noTouch)],[CCDelayTime actionWithDuration:6.0],[CCCallFuncN actionWithTarget:self selector:@selector(yesTouch)], nil]];
}

-(void) noTouch {
    self.isTouchEnabled = NO;
}

-(void) yesTouch {
    NSLog(@"yesTouch");
    if (self.isTouchEnabled == NO) {
        self.isTouchEnabled = YES;
    }
}

-(void)updateScore
{
    // 점수가 - 가 되면 안되요..
    if( appDelegate.gameScore < 0 )  appDelegate.gameScore = 0;
	
    NSString *str1 = [NSString stringWithFormat:@"Score \n %d", appDelegate.gameScore];
    [scoreLabel setString:str1];
	
	id scaleAction = [CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1],
					  [CCScaleTo actionWithDuration:0.1 scale:1.0], nil];
	[self.scoreLabel runAction:scaleAction];
}
-(void)updateLifeLabel
{
	// 라이프가 - 가 되면 안되요..
	if (appDelegate.gameLife < 0)     appDelegate.gameLife = 0;
	NSString *str = [NSString stringWithFormat:@"Life : %d", appDelegate.gameLife];
	[lifeLabel setString:str];
	
	id scaleAction = [CCSequence actions:[CCScaleTo actionWithDuration:0.1 scale:1.1],
					  [CCScaleTo actionWithDuration:0.1 scale:1.0], nil];
	[self.lifeLabel runAction:scaleAction];
    
}
-(void)goBack{
    [SceneManager goMenu];
}

- (void) closeMenuCallback: (id) sender
{
    //  장면에서 빠져나올적에는 iAD를 removeChild 시키자
	[SceneManager goMenu];
}
-(void) gotoGameOverLayer{
	[SceneManager goGameOver];
}

#pragma mark Touch

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"Touch");
  	UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    CGPoint convertedLocation = [[CCDirector sharedDirector] convertToGL:location];
        
    if ( !CGRectContainsPoint(character.boundingBox, convertedLocation)) {
        isCharacterTouched = NO;
    }
    else {
        isCharacterTouched = YES;
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if (isCharacterTouched) {
		//        NSLog(@"character touched move");
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInView:[touch view]];
        CGPoint convertedLocation = [[CCDirector sharedDirector]
                                     convertToGL:location];
        
		if ( convertedLocation.x < 40 ) {
            convertedLocation.x = 40;
        }
        if (convertedLocation.x > 280) {
            convertedLocation.x = 280;
        }
				
        CGPoint newLocation = ccp(convertedLocation.x,character.position.y);
        character.position = newLocation;		
	}
}

#pragma mark GameOver
-(void) GameOver
{
	[character setVisible:NO]; //게임이 끝나서 메인 캐릭터는 보이지 않음.

	// 사용 중인 schdule을 모두 끕니다.
	[self unschedule:@selector(createSprite)];
	[self unschedule:@selector(scheduleCollisionCoin)];
    [self unschedule:@selector(scheduleCollisionStar)];
	[self unschedule:@selector(scheduleCollisionFake)];
	
	// 배경음악 종료
	[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
	
    // 더 이상 사용되지않는 그래픽 캐시를 지웁니다.
	[[CCTextureCache sharedTextureCache] removeUnusedTextures];
	
	NSLog(@"OF Score: %d", appDelegate.gameScore);
	
	[self performSelector:@selector(gotoGameOverLayer) withObject:nil afterDelay:0.1];
}


@end
