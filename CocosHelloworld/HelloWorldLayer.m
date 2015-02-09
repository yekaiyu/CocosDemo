//
//  HelloWorldLayer.m
//  CocosHelloworld
//
//  Created by Alan on 15-2-5.
//  Copyright Alan 2015年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import "SimpleAudioEngine.h"
#import "GameOverLayer.h"
#import "PlayerSprite.h"
#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer{
    NSMutableArray* _monsters;
    NSMutableArray* _projectiles;
    NSMutableArray* _says;
    //CCSprite *player;
    CCSprite* say1;
    NSArray* _monstersNames;
    NSInteger countProjectiles;
    NSInteger fireMonsters;
    CCLabelTTF* labelPros;
    CCLabelTTF* labelMonsters;
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (void) addMonster{
    CCSprite* monster;
    
    NSInteger i = arc4random()%5;
    
    monster = [CCSprite spriteWithFile:[_monstersNames objectAtIndex:i]];
    
    CGSize winSize = [CCDirector sharedDirector].winSize;
    
    int minY = monster.contentSize.height/2;
    
    int maxY = winSize.height -monster.contentSize.height/2;
    
    int rangeY = maxY - minY;
    
    int actualY = (arc4random()%rangeY) + minY;
    
    monster.position = ccp(winSize.width+monster.contentSize.width/2, actualY);
    monster.tag = 1;

    
    [_monsters addObject:monster];
  
    
    [self addChild:monster];
    
    int minDuration = 2.0;
    int maxDuration = 4.0;
    
    int rangeDuration = maxDuration - minDuration;
    int actualDuration = (arc4random()%rangeDuration)+minDuration;
    
    CCMoveTo* actionMove = [CCMoveTo actionWithDuration:actualDuration position:ccp(-monster.contentSize.width/2, actualY)];
    
    CCCallBlockN* actionMoveDone = [CCCallBlockN actionWithBlock:^(CCNode *node) {
        [node removeFromParentAndCleanup:YES];
        
        CCScene* gameOver = [GameOverLayer sceneWithWon:2];
        
        [[CCDirector sharedDirector] replaceScene:gameOver];
        
        [_monsters removeObject:node];
    }];
    
    [monster runAction:[CCSequence actions:actionMove,actionMoveDone,nil]];
    
    
}

-(void)gameLogic:(ccTime)dt{
    [self addMonster];
}

-(void)removeSay1:(ccTime)dt{
    NSLog(@"remove says!!!");
    [self removeChild:say1 cleanup:YES];
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super initWithColor:ccc4(255,255,255,255)]) ) {
        _monsters = [[NSMutableArray alloc] init];
        _projectiles = [[NSMutableArray alloc] init];
        _says = [[NSMutableArray alloc] init];
        _monstersNames = [[NSArray alloc] initWithObjects:@"guai3_.png",@"guai4_.png",
                          @"guai5_.png",@"guai2_.png",@"guai1_.png",nil];
        
        
        [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"background-music-aac.caf"];
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        CCSprite* background = [CCSprite spriteWithFile:@"bg.jpg"];
        
        background.position = ccp(winSize.width/2,winSize.height/2);
        
        [self addChild:background];
        
        
        player = [PlayerSprite player];
        
        player.position = ccp(player.contentSize.width/2,winSize.height/2);
        
        
        labelPros = [CCLabelTTF labelWithString:@"剩余飞镖:50" fontName:@"Arial" fontSize:20];
        labelPros.color = ccc3(255,0,0);
        labelPros.position = ccp(winSize.width-60,25);
        [self addChild:labelPros];
        labelMonsters = [CCLabelTTF labelWithString:@"消灭:0" fontName:@"Arial" fontSize:20];
        labelMonsters.color = ccc3(255,0,0);
        labelMonsters.position = ccp(winSize.width-150,25);
        [self addChild:labelMonsters];
        
        
        [self addChild:player];
        [self schedule:@selector(gameLogic:) interval:1.0];
        
        [self setIsTouchEnabled:YES];
        [self schedule:@selector(update:)];
        [self schedule:@selector(removeSays:) interval:1.0];
        
        [self schedule:@selector(playerMove:) interval:3.0];
        
        [self schedule:@selector(projectilesRotate:)];

	}
	return self;
}

-(void)projectilesRotate:(ccTime) dt {
    
    if([_projectiles count]<=0) return;
    
    for(CCSprite* projectiles in _projectiles){
        [projectiles runAction:[CCRotateBy actionWithDuration:1 angle:360]];
    }
    
    
}

-(void)playerMove:(ccTime)dt {
    
    //CCEaseBounceOut*ease=[CCEaseBounceOut actionWithAction:[CCMoveBy actionWithDuration:3 position:ccp(50,0)]];
    CCJumpBy *jump=[CCJumpBy actionWithDuration:3 position:ccp(0,0) height:50 jumps:3];
    CCSequence *sequence=[CCSequence actions:jump,nil];
    [player runAction:sequence];
    
}



-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    countProjectiles++;
    if(countProjectiles>50){
        
        CCScene* gameOver = [GameOverLayer sceneWithWon:3];
        
        [[CCDirector sharedDirector] replaceScene:gameOver];
    }
    
    [self removeChild:labelPros cleanup:YES];
    
    labelPros = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"剩余飞镖:%d",50-countProjectiles] fontName:@"Arial" fontSize:20];
    labelPros.color = ccc3(255,0,0);
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    labelPros.position = ccp(winSize.width-60,25);
    
    [self addChild:labelPros];
    
    if (_nextProjectile != nil) return;

    // Choose one of the touches to work with
    UITouch *touch = [touches anyObject];
    CGPoint location = [self convertTouchToNodeSpace:touch];

    // Set up initial location of projectile

    _nextProjectile = [[CCSprite spriteWithFile:@"bb_.png"] retain];
    _nextProjectile.position = ccp(20, winSize.height/2);

    // Determine offset of location to projectile
    CGPoint offset = ccpSub(location, _nextProjectile.position);

// Bail out if you are shooting down or backwards
    if (offset.x <= 0) return;

    // Determine where you wish to shoot the projectile to
    int realX = winSize.width + (_nextProjectile.contentSize.width/2);
    float ratio = (float) offset.y / (float) offset.x;
    int realY = (realX * ratio) + _nextProjectile.position.y;
    CGPoint realDest = ccp(realX, realY);

    // Determine the length of how far you're shooting
    int offRealX = realX - _nextProjectile.position.x;
    int offRealY = realY - _nextProjectile.position.y;
    float length = sqrtf((offRealX*offRealX)+(offRealY*offRealY));
    float velocity = 480/1; // 480pixels/1sec
    float realMoveDuration = length/velocity;

    // Determine angle to face
    float angleRadians = atanf((float)offRealY / (float)offRealX);
    float angleDegrees = CC_RADIANS_TO_DEGREES(angleRadians);
    float cocosAngle = -1 * angleDegrees;
    float rotateDegreesPerSecond = 180 / 0.5; // Would take 0.5 seconds to rotate 180 degrees, or half a circle
    float degreesDiff = player.rotation - cocosAngle;
    float rotateDuration = fabs(degreesDiff / rotateDegreesPerSecond);
    [player runAction:
     [CCSequence actions:
      [CCRotateTo actionWithDuration:rotateDuration angle:cocosAngle],
      [CCCallBlock actionWithBlock:^{
         // OK to add now - rotation is finished!
         [self addChild:_nextProjectile];
         [_projectiles addObject:_nextProjectile];

         // Release
         [_nextProjectile release];
         _nextProjectile = nil;
     }],
      nil]];

    // Move projectile to actual endpoint
    [_nextProjectile runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:realMoveDuration position:realDest],
      [CCCallBlockN actionWithBlock:^(CCNode *node) {
         [_projectiles removeObject:node];
         [node removeFromParentAndCleanup:YES];
    }],
      nil]];

    _nextProjectile.tag = 2;

    [[SimpleAudioEngine sharedEngine] playEffect:@"pew-pew-lei.caf"];

    
    //NSLog(@"fire!!!!!!!!");
    
}

- (void)update:(ccTime)dt {
    
    if(50-countProjectiles>0){
        
    }
    
    NSMutableArray *projectilesToDelete = [[NSMutableArray alloc] init];
    for (CCSprite *projectile in _projectiles) {

        NSMutableArray *monstersToDelete = [[NSMutableArray alloc] init];
        for (CCSprite *monster in _monsters) {

            if (CGRectIntersectsRect(projectile.boundingBox, monster.boundingBox)) {
                [monstersToDelete addObject:monster];
            }
        }

        for (CCSprite *monster in monstersToDelete) {
            //[monster runAction:[CCFadeTo actionWithDuration:1.0 opacity:0]];
            [_monsters removeObject:monster];
            [self removeChild:monster cleanup:YES];
        }
        
        if (monstersToDelete.count > 0) {
            [projectilesToDelete addObject:projectile];
            
            _monstersDestroyed++;
            
            [self removeChild:labelMonsters cleanup:YES];
            labelMonsters = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"消灭:%d",_monstersDestroyed] fontName:@"Arial" fontSize:20];
            labelMonsters.color = ccc3(255,0,0);
            CGSize winSize = [[CCDirector sharedDirector] winSize];
            labelMonsters.position = ccp(winSize.width-150,25);
            
            [self addChild:labelMonsters];
            if(_monstersDestroyed > 30){
                CCScene* gameOver = [GameOverLayer sceneWithWon:1];
                [[CCDirector sharedDirector] replaceScene:gameOver];
            }
        }
        
        
        [monstersToDelete release];
    }

    for (CCSprite *projectile in projectilesToDelete) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite* say2 = [CCSprite spriteWithFile:@"youxi.png"];
        say2.position = ccp(120,(player.contentSize.height*1.5 + winSize.height)/2);
        [self addChild:say2];
        [_says addObject:say2];
        [_projectiles removeObject:projectile];
        [self removeChild:projectile cleanup:YES];
    }
    [projectilesToDelete release];
}

- (void)removeSays:(ccTime)dt{
    if([_says count]>0){
        NSMutableArray* removesays = [[NSMutableArray alloc]init];
        for(CCSprite* say in _says){
            [self removeChild:say cleanup:YES];
            [removesays addObject:say];
        }
        
        [removesays release];
        
    }
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}
@end
