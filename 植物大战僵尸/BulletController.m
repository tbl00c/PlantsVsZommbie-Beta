//
//  BulletController.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "BulletController.h"
#import "Zombie.h"          // 用于碰撞检测

@implementation BulletController

+ (id) createControllerWithRect:(CGRect)rect
{
    BulletController *controller = [BulletController spriteNodeWithColor:[SKColor clearColor] size:rect.size];
    controller.mainRect = rect;
    
    return controller;
}

+ (BulletController *) bulletByValue: (enum BulletValue) value position: (CGPoint) point
{
    id bullet;
    switch (value) {
        case BulletNormalValue:
            bullet = [BulletNormal createBullerAtPoint:point];
            break;
        case BulletICEValue:
            bullet = [BulletICE createBullerAtPoint:point];
            break;
        default:
            break;
    }
    
    return bullet;
}



- (void) update:(NSTimeInterval)currentTime
{
    for (Bullet *item in [self children]) {
        if (item.canMove) {
            item.position = CGPointMake(item.position.x + BULLET_SPACE, item.position.y);
            if (item.position.x > self.mainRect.size.width) {
                [item removeFromParent];
            }
            
            for (id sth in [self.parent nodesAtPoint:item.position]) {
                if ([sth superclass] == [Zombie class]) {
                    item.canMove = NO;
                    [(Zombie *)sth subLife:item.hitValue];
                    [(Zombie *)sth subSpace:item.subSpace];
                    
                    [item Bomb];
                    break;
                }
            }            
        }
    }
}

@end
