//
//  Sun.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "Sun.h"

@implementation Sun

static int count = 20;

+ (id) newSunAt:(CGPoint)position
{
    Sun *sun = [Sun spriteNodeWithImageNamed:@"Sun_0.png"];
    sun.position = position;
    sun.name = @"Sun";
    [sun setAlpha:0.95];
    [sun addAction];
    
    return sun;
}

- (void) addAction
{
    NSMutableArray *texture = [[NSMutableArray alloc] init];
    for (int i = 0; i <= count; i ++) {
        NSString *add = [NSString stringWithFormat:@"Sun_%d.png", i];
        SKTexture *t = [SKTexture textureWithImageNamed:add];
        [texture addObject:t];
    }
    [self removeAllActions];
    SKAction *action = [SKAction animateWithTextures:texture timePerFrame:0.1];
    [self runAction:[SKAction repeatActionForever:action]];
}

- (void) waitAndMiss
{
    SKAction *wait = [SKAction waitForDuration:SUN_SURVIVE_TIME];
    SKAction *miss = [SKAction removeFromParent];
    [self runAction: [SKAction sequence:@[wait, miss]]];
}

- (void) moveTo:(CGPoint)point
{
    SKAction *move = [SKAction moveTo:point duration:8];
    [self runAction:move completion:^{
        [self waitAndMiss];
    }];
}

- (void) removeFromParentAndAddScore
{
    [self removeAllActions];
    
    SKAction *move = [SKAction moveTo:SUN_FATHER_POSITION duration:0.4];
    SKAction *zoom1 = [SKAction scaleTo:0.8 duration:0.3];
    SKAction *zoom2 = [SKAction scaleTo:1.0 duration:0.1];
    SKAction *zoom3 = [SKAction scaleTo:0.3 duration:0.15];
    SKAction *zoom = [SKAction sequence:@[zoom1, zoom2, zoom3]];
    SKAction *action = [SKAction group:@[move, zoom]];
    
    [self runAction:action completion:^{
        [super removeFromParent];
    }];
}

- (void) removeFromParent
{
    SKAction *miss = [SKAction fadeOutWithDuration:1.5];
    
    [self runAction:miss completion:^{
        [super removeFromParent];
    }];
}

@end
