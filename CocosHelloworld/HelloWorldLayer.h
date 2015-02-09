//
//  HelloWorldLayer.h
//  CocosHelloworld
//
//  Created by Alan on 15-2-5.
//  Copyright Alan 2015年. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayerColor
{
    int _monstersDestroyed;
    CCSprite* _nextProjectile;
    CCSprite *player;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
