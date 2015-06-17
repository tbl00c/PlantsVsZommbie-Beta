//
//  plantController.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-10-31.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "PlantController.h"

@implementation PlantController


+ (id) createControllerWithRect:(CGRect)rect
{
    PlantController *controller = [PlantController spriteNodeWithColor:[SKColor clearColor] size:rect.size];
    controller.mainRect = rect;
    
    return controller;
}

+ (id) plantByValue:(enum PlantValue)value
{
    id plant;
    switch (value) {
        case SunFlowerValue:     // 向日葵
            plant = [SunFlower newPlant];
            break;
        case PeashooterValue:     // 豆枪
            plant = [Peashooter newPlant];
            break;
        case WallNutValue:         // 坚果
            plant = [WallNut newPlant];
            break;
        case ThreepeaterValue:    // 三个豆枪
            plant = [Threepeater newPlant];
            break;
        case  CherryBombValue:     // 樱桃炸弹
            plant = [CherryBomb newPlant];
            break;
        case SnowPeaValue:        // 冰豌豆
            plant = [SnowPea newPlant];
            break;
            
        default:
            break;
    }
    
    return plant;
}

- (void) addPlant:(id)plant
{
    [self addChild:plant];
    [plant startAnimation];
}

- (void) removePlantAtPoint:(CGPoint)point
{
    NSArray *node = [self nodesAtPoint:point];
    for (id item in node) {         // 挖掉植物
        if ([item superclass] == [Plant class]){
            SKAction *wait = [SKAction waitForDuration:0.9];
            SKAction *action = [SKAction moveBy:CGVectorMake(0, 12) duration:0.2];
            SKAction *miss = [SKAction fadeOutWithDuration:0.2];
            
            [item runAction:[SKAction sequence:@[wait, action, miss]] completion:^{
                [item removeFromParent];
            }];
            break;
        }
    }
}

- (void) update:(NSTimeInterval)currentTime
{
    for (id item in [self children]) {
        [item update:currentTime];
    }
}

@end


