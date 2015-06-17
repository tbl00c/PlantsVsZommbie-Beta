//
//  P_WallNut.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "WallNut.h"
#import "GameScene.h"       // 仅用于

@implementation WallNut

+ (id) newPlant
{
    WallNut *plant = [WallNut spriteNodeWithImageNamed:@"WallNut_0.png"];

    plant.default_lifeValue = plant.lifeValue = WALLNUT_LIFEVALUE;
    plant.sunValue = WALLNUT_SUNVALUE;
    
    return plant;
}

- (void) startAnimation
{
    [self loadImage:@"WallNut" count:15];
    self.status = 0;
}

- (void) changeAction1
{
    [self loadImage:@"Wallnut_cracked1" count:10];
}

- (void) changeAction2
{
    [self loadImage:@"Wallnut_cracked2" count:14];
}

- (void) subLife: (float) value
{
    self.lifeValue -= value;
    if (self.lifeValue <= 0 && self.status < 3) {
        [((GameScene *)self.parent.parent).background removePlantAndGetRightPosition:self.position];
        [self removeFromParent];
        self.status = 3;
        return;
    }
    else if(self.lifeValue < 0.33 * self.default_lifeValue && self.status < 2){
        [self changeAction2];
        self.status = 2;
        return;
    }
    else if(self.lifeValue < 0.66 * self.default_lifeValue && self.status < 1){
        [self changeAction1];
        self.status = 1;
        return;
    }
}

@end
