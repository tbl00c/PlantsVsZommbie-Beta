//
//  PrepareGrowPlants.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "PrepareGrowPlantsLayer.h"

@implementation PrepareGrowPlantsLayer

+ (id) newLayerScene: (CGRect) rect
{
    PrepareGrowPlantsLayer *p = [PrepareGrowPlantsLayer spriteNodeWithImageNamed:@"PrepareGrowPlants_0.png"];
    p.count = 2;
    p.position = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
    
    return p;
}

- (void) showAction
{
    NSMutableArray *texture = [[NSMutableArray alloc] init];
    for (int i = 0; i <= _count; i ++) {
        NSString *add = [NSString stringWithFormat:@"PrepareGrowPlants_%d.png", i];
        SKTexture *t = [SKTexture textureWithImageNamed:add];
        [texture addObject:t];
    }
    
    [self removeAllActions];
    SKAction *action = [SKAction animateWithTextures:texture timePerFrame:0.7];
    SKAction *miss = [SKAction removeFromParent];
    [self runAction: [SKAction sequence:@[action, miss]]];
}

@end
