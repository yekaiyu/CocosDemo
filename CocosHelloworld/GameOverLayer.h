//
//  GameOverLayer.h
//  CocosHelloworld
//
//  Created by Alan on 15-2-5.
//  Copyright 2015年 Alan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameOverLayer : CCLayerColor {
    
}

+(CCScene*)sceneWithWon:(NSInteger)won;

- (id)initWithWon:(NSInteger)won;
    

@end
