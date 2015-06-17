//
//  Plant.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-10-31.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "Plant.h"
#import "GameScene.h"       // 仅用于

@implementation Plant

@synthesize fatherPoint;


+ (id) spriteNodeWithImageNamed:(NSString *)name
{
    Plant *newPlant = [super spriteNodeWithImageNamed:name];
    [newPlant setScale:0.7];
    return newPlant;
}

- (void) loadImage:(NSString *)name count:(int)count
{
    NSMutableArray *texture = [[NSMutableArray alloc] init];
    for (int i = 0; i <= count; i ++) {
        NSString *add = [NSString stringWithFormat:@"%@_%d.png", name, i];
        SKTexture *t = [SKTexture textureWithImageNamed:add];
        [texture addObject:t];
    }
    
    [self removeAllActions];
    SKAction *action = [SKAction animateWithTextures:texture timePerFrame:DEFAULT_PLANT_UPDATE_TIME];
    [self runAction:[SKAction repeatActionForever:action]];
}

- (void) removeFromParentWithAnimation
{
    SKAction *move = [SKAction moveTo:fatherPoint duration:0.2];
    SKAction *zoom = [SKAction scaleTo:0.3 duration:0.2];
    SKAction *miss = [SKAction fadeAlphaTo:0.8 duration:0.2];
    SKAction *action = [SKAction group:@[move, zoom, miss]];
    
    [self runAction:action completion:^{
        [super removeFromParent];
    }];
}

- (void) startAnimation {};

- (void) subLife: (float) value
{
    self.lifeValue -= value;
    if (self.lifeValue <= 0) {
        [((GameScene *)self.parent.parent).background removePlantAndGetRightPosition:self.position];
        [self removeFromParent];
    }
}

- (void) update:(NSTimeInterval)currentTime{}

@end
