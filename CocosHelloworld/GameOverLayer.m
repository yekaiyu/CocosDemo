//
//  GameOverLayer.m
//
//
//  Created by Alan on 15-2-5.
//  Copyright 2015年 Alan. All rights reserved.
//

#import "GameOverLayer.h"
#import "HelloWorldLayer.h"

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
    if(self = [super initWithColor:ccc4(255, 255, 255, 255)]){
        NSString* message;
        
        if(won==1){
            message = @"您保卫了露露小妞，抱娶美人归！";
        }else if(won==2){
            message = @"美丽的露露小妞挂掉了!";
        }else {
              message = @"您的飞镖用完了，闯关失败!";
        }
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF* label = [CCLabelTTF labelWithString:message fontName:@"Arial" fontSize:32];
        
        label.color = ccc3(0,0,0);
        
        label.position = ccp(winSize.width/2,winSize.height/2);
        
        [self addChild:label];
        
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:3], [CCCallBlock actionWithBlock:^{
            [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
        }], nil]];
    }
    return self;
    
}

@end
