//
//  MessageNode.h
//  Collecting_Coin_2
//
//  Created by 51310 on 13. 6. 15..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MessageNode : CCNode
{
	// 각각의 정보를 보여주기 위한 스프라이트 노드의 사용
	CCSprite *scoreten;
	CCSprite *scoreone;
	CCSprite *lifeplus;
	CCSprite *lifeminus;
	
	BOOL scoretenVisible;
	BOOL scoreoneVisible;
	BOOL lifeplusVisible;
	BOOL lifeminusVisible;
}

// 각 메시지 정보의 상수선언
extern int const SCORETEN_MESSAGE;
extern int const SCOREONE_MESSAGE;
extern int const LIFEPLUS_MESSAGE;
extern int const LIFEMINUS_MESSAGE;

@property (nonatomic, retain) CCSprite *scoreten;
@property (nonatomic, retain) CCSprite *scoreone;
@property (nonatomic, retain) CCSprite *lifeplus;
@property (nonatomic, retain) CCSprite *lifeminus;

-(void)showMessage:(int) message;
@end
