//
//  MessageNode.m
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 15..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "MessageNode.h"
#import "GameLayer.h"


@implementation MessageNode


int const SCORETEN_MESSAGE = 0;
int const SCOREONE_MESSAGE = 1;
int const LIFEPLUS_MESSAGE = 2;
int const LIFEMINUS_MESSAGE = 3;


@synthesize scoreten,scoreone,lifeminus,lifeplus;

-(id) init
{
	self = [super init];
	
	if (self)
	{
		// 현재 노드에 damage, chance, correct 스프라이트 노드를 자식 노드로 추가
		CCSprite *m = [[CCSprite alloc] initWithFile:@"scoreten.png"];
		//[m setAnchorPoint:ccp(0,0)];
		self.scoreten = m;
		[m release];
		[self addChild:scoreten];
		
		CCSprite *p = [[CCSprite alloc] initWithFile:@"scoreone.png"];
		//[p setAnchorPoint:ccp(0,0)];
		self.scoreone = p;
		[p release];
		[self addChild:scoreone];
		
		CCSprite *lp = [[CCSprite alloc] initWithFile:@"lifeplus.png"];
		//[c setAnchorPoint:ccp(0,0)];
		self.lifeplus = lp;
		[lp release];
		[self addChild:lifeplus];
		
		CCSprite *lm = [[CCSprite alloc] initWithFile:@"lifeminus.png"];
		//[c setAnchorPoint:ccp(0,0)];
		self.lifeminus = lm;
		[lm release];
		[self addChild:lifeminus];
		
		
		// 각각의 노드에 대한 위치는 화면의 중앙 상단으로 한다
		scoreten.position = ccp(160, 400);
		scoreone.position = ccp(160, 400);
		lifeplus.position = ccp(160, 400);
		lifeminus.position = ccp(160, 400);
		
		
		[scoreten runAction:[CCFadeOut actionWithDuration:0.0]];
		[scoreone runAction:[CCFadeOut actionWithDuration:0.0]];
		[lifeplus runAction:[CCFadeOut actionWithDuration:0.0]];
		[lifeminus runAction:[CCFadeOut actionWithDuration:0.0]];
	}
	
	return self;
}

// showMessage 메소드는 int를 매개변수로 받아서 각 스프라이트를 지역변수 sprite에 할당함.
- (void) showMessage:(int) message
{
	CCSprite *sprite;
	
	if(message == SCORETEN_MESSAGE)
	{
		sprite = scoreten;
		scoretenVisible = YES;
	}else if(message == SCOREONE_MESSAGE)
	{
		sprite = scoreone;
		scoreoneVisible = YES;
	}else if(message == LIFEPLUS_MESSAGE)
	{
		sprite = lifeplus;
		lifeplusVisible = YES;
	}else if (message == LIFEMINUS_MESSAGE)
	{
		sprite = lifeminus;
		lifeminusVisible = YES;
	}
	
	// 짧은 순간에 opacity값을 0으로 만들어서 투명한 스피라이트를 만든다
	[sprite runAction:[CCFadeTo actionWithDuration:0.01 opacity:0]];
	// 순차적인 액션을 보여줌
	[sprite runAction:[CCSequence actions:
					   [CCFadeTo actionWithDuration:0.1 opacity:250],
					   [CCDelayTime actionWithDuration:0.2],
					   [CCFadeTo actionWithDuration:0.1 opacity:0],
					   nil]];
}

- (void) dealloc
{
	[scoreten release];
	[scoreone release];
	[lifeplus release];
	[lifeminus release];
	[super dealloc];
}

@end