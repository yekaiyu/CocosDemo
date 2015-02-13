//
//  SelfSprite.m
//  CocosHelloworld
//
//  Created by yekaiyu on 15/2/10.
//  Copyright 2015年 Alan. All rights reserved.
//

#import "SelfSprite.h"


@implementation SelfSprite

+(id)player:(NSString *)fileName withCount:(NSInteger)count{
    
    return [[self alloc] initWithCGImage:fileName withCount:count];
    
}

-(id)initWithCGImage:(NSString*)fileName withCount:(NSInteger)count{
    
    if(self =[super initWithFile:[NSString stringWithFormat:@"%@1.png",fileName]]){
        
        NSMutableArray* frames = [NSMutableArray arrayWithCapacity:2];
        
        for(int i=1;i<count+1;i++){
            
            NSString* pngFile = [NSString stringWithFormat:@"%@%d.png",fileName,i];
            NSLog(@"filename : %@",pngFile);
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
