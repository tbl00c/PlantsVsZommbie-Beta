//
//  ShovelMenuItem.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "ShovelMenuItem.h"

#define SHOVEL_ZROTSTION            0.25 * M_PI

@implementation ShovelMenuItem

@synthesize startPoint;

+ (id) createShovelMenuItemWithPoint:(CGPoint)point
{
    ShovelMenuItem *item = [ShovelMenuItem spriteNodeWithImageNamed:@"Shovel.png"];
    [item setScale:0.72];
    item.name = @"Shovel";
    item.zPosition = 10000;
    item.position = point;
    item.startPoint = point;
    
    return item;
}

- (void) userChoose
{
    SKAction *a = [SKAction rotateByAngle:0.1 * M_PI duration:0.01];
    SKAction *b = [SKAction rotateByAngle:-0.1 * M_PI duration:0.02];
    SKAction *c = [SKAction rotateByAngle:0 duration:0.01];
    SKAction *d = [SKAction waitForDuration:1];
    SKAction *all = [SKAction sequence:@[a, b, c, a, b, c, d]];
    [self runAction:[SKAction repeatActionForever:all]];
}

- (void) giveUpChoose
{
    [self removeAllActions];
}


- (void) moveBackAfterActionInPoint:(CGPoint)point
{
    [self giveUpChoose];
    
    self.zRotation = 0.15 * M_PI;

    self.move = NO;
    int x = point.x + 30;
    int y = point.y + 20;
    
    CGPoint nPoint = CGPointMake(x, y);
    
    // 铲除植物动画
    SKAction *oneFirst = [SKAction moveTo:nPoint duration:0.2];
    SKAction *oneWith = [SKAction rotateByAngle: SHOVEL_ZROTSTION duration:0.5];
    SKAction *one = [SKAction group:@[oneFirst, oneWith]];
    
    y -= 30;
    SKAction *twoFirst = [SKAction moveTo:CGPointMake(x, y) duration:0.5];
    SKAction *twoWith = [SKAction rotateToAngle:SHOVEL_ZROTSTION *0.7 duration:0.5];
    SKAction *two = [SKAction group:@[twoFirst, twoWith]];
    
    SKAction *wait = [SKAction waitForDuration:0.25];
    SKAction *move = [SKAction moveTo:startPoint duration:0.3];
    
    
    SKAction *all = [SKAction sequence:@[one, two, wait, move]];
        
    [self runAction:all completion:^{
        self.zRotation = 0;
    }];
}

@end
