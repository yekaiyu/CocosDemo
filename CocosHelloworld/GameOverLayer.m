//
//  GameOverLayer.m
//
//
//  Created by Alan on 15-2-5.
//  Copyright 2015年 Alan. All rights reserved.
//

#import "GameOverLayer.h"
#import "HelloWorldLayer.h"
#import "SelfSprite_10.h"

@implementation GameOverLayer

+(CCScene*)sceneWithWon:(NSInteger)won
{
    CCScene* scene = [CCScene node];
    GameOverLayer* layer = [[[GameOverLayer alloc] initWithWon:won]autorelease];
    [scene addChild:layer];
    
    return scene;
    
}

-(id)initWithWon:(NSInteger)won
{
    if(self = [super initWithColor:ccc4(255, 0, 0, 255)]){
        NSString* message;
        CCSprite* sprite;
        
        if(won==1){
            message = @"您保卫了露露小妞！";
        }else if(won==2){
            message = @"美丽的露露小妞挂掉了!";
        }else {
              message = @"您的飞镖用完了，失败!";
        }
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF* label = [CCLabelTTF labelWithString:message fontName:@"Arial" fontSize:25];
        
        label.color = ccc3(0,255,255);
        
        label.position = ccp(winSize.width/2,winSize.height/2);
        
        sprite = [SelfSprite_10 player];
        
        sprite.position = ccp((winSize.width + label.contentSize.width)/2+30,
                              (winSize.height+label.contentSize.height)/2);
        
        
        
        [self addChild:label];
        
        [self addChild:sprite];
        
        //[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:3], [CCCallBlock actionWithBlock:^{
        //    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
        //}], nil]];
    }
    return self;
    
}

@end
