//
//  ZombieController.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "ZombieController.h"
#import "GameScene.h"

#define DEFAULT_PRODUCT_TIME    5

@implementation ZombieController

+ (id) createControllerWithRect:(CGRect)rect
{
    ZombieController *controller = [ZombieController spriteNodeWithColor:[SKColor clearColor] size:rect.size];
    controller.mainRect = rect;
    
    return controller;
}

- (CGPoint) createPoint
{
    int t = arc4random() % self.road;
    int x = self.mainRect.size.width + zombie.frame.size.width / 2;
    int y = self.startPoint.y + (t + 0.2) * self.plantSpaceSize.height + zombie.frame.size.height / 2;
    
    
    return CGPointMake(x, y);
}

- (id) createZombieByValue: (enum ZombieValue) value
{
    id newZombie;
    switch (value) {
        case ZombieNormalValue:
            newZombie = [ZombieNormal newZombie];
            break;
        default:
            break;
    }
    
    return newZombie;
}

- (void) addChild:(SKNode *)node
{
    [((GameScene *)(self.parent)).background addZombie: node.position];
    [super addChild:node];
}

- (void) update:(NSTimeInterval)currentTime
{
    if (tm == 0) {
        tm = currentTime;
    }
    else if(currentTime - tm >= DEFAULT_PRODUCT_TIME){
        tm = currentTime;

        zombie = [self createZombieByValue:ZombieNormalValue];
        zombie.position = [self createPoint];
        zombie.zPosition = 1000 - zombie.position.y;
        [self addChild:zombie];
    }
    
    for (Zombie *item in [self children]) {
        [item update:currentTime];
    }
}

@end


