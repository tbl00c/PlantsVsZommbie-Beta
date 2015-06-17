//
//  GameOverFailedLayer.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-7.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "GameOverFailedLayer.h"

@implementation GameOverFailedLayer

+ (id) newLayerScene: (CGRect) rect
{
    GameOverFailedLayer *p = [GameOverFailedLayer spriteNodeWithImageNamed:@"ZombiesWon.png"];
    p.position = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    return p;
}

- (void) showAction
{
    SKAction *white = [SKAction colorizeWithColor:[SKColor whiteColor] colorBlendFactor:1.0 duration:0.5];
    SKAction *green = [SKAction colorizeWithColor:[SKColor greenColor] colorBlendFactor:1.0 duration:0.5];
    SKAction *white2 = [SKAction colorizeWithColor:[SKColor whiteColor] colorBlendFactor:0 duration:0.5];
    SKAction *color = [SKAction sequence:@[white, green, white2]];
    [self runAction: [SKAction repeatAction:color count:2]];
    
}

@end
