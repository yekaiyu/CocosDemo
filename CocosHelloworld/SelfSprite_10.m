//
//  SelfSprite_10.m
//  CocosHelloworld
//
//  Created by yekaiyu on 15/2/10.
//  Copyright 2015年 Alan. All rights reserved.
//

#import "SelfSprite_10.h"


@implementation SelfSprite_10
+(id)player{
    
    return [[self alloc] initWithCGImage];
    
}

-(id)initWithCGImage{
    
    if(self =[super initWithFile:@"self_10_1.png"]){
        
        NSMutableArray* frames = [NSMutableArray arrayWithCapacity:2];
        
        for(int i=1;i<11;i++){
            
            NSString* pngFile = [NSString stringWithFormat:@"self_10_%d.png",i];
            
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
