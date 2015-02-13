//
//  SelfSprite_1.m
//  CocosHelloworld
//
//  Created by yekaiyu on 15/2/10.
//  Copyright 2015年 Alan. All rights reserved.
//

#import "SelfSprite_1.h"


@implementation SelfSprite_1
+(id)player{
    
    return [[self alloc] initWithCGImage];
    
}

-(id)initWithCGImage{
    
    if(self =[super initWithFile:@"self_1_1.png"]){
        
        NSMutableArray* frames = [NSMutableArray arrayWithCapacity:2];
        
        for(int i=1;i<4;i++){
            
            NSString* pngFile = [NSString stringWithFormat:@"self_1_%d.png",i];
            
            CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:pngFile];
            
            CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:texture rect:CGRectMake(0, 0, texture.contentSize.width, texture.contentSize.height)];
            
            [frames addObject:frame];
            
            
        }
        
        CCAnimation* animation = [CCAnimation animationWithSpriteFrames:frames delay:0.3];
        
        CCAnimate* animate = [CCAnimate actionWithAnimation:animation];
        
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:animate];
        
        [self runAction:repeat];
    }
    
    return self;
    
}

@end
