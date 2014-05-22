//
//  SceneManager.h
//  Collecting_Coin
//
//  Created by Dasom Oh on 13. 5. 19.
//
//

#import <Foundation/Foundation.h>

// 게임에서 사용되는 레이어를 추가하거나 불필요한 레이어는 삭제한다
#import "MenuLayer.h"
#import "GameLayer.h"
#import "IntroLayer.h"
#import "CreditLayer.h"
#import "GameOverLayer.h"
#import "HowtoLayer.h"

@interface SceneManager : NSObject {
    
}

// 각 레이어로 이동하는 정적 메소드임
+(void) goIntro;
+(void) goMenu;
+(void) goGame;
+(void) goGameOver;
+(void) goCredit;
+(void) goHowto;

// 레이어간 이동에서 사용되는 트랜지션 효과와 효과에 사용되는 시간
+(void) go:(CCLayer *)layer withTransition:(NSString *)transitionString ofDelay:(float)t;
+(void) go:(CCLayer *)layer withTransition:(NSString *)transitionString;
+(void) go:(CCLayer *)layer;

@end
