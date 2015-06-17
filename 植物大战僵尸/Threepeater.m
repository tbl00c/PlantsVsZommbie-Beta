//
//  P_Threepeater.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "Threepeater.h"

@implementation Threepeater

+ (id) newPlant
{
    Threepeater *plant = [Threepeater spriteNodeWithImageNamed:@"Threepeater_0.png"];
    plant.sunValue = THREEPEATER_SUNVALUE;
    plant.lifeValue = THREEPEATER_LIFEVALUE;

    
    return plant;
}

- (void) startAnimation
{
    [self loadImage:@"Threepeater" count:15];
}

@end
