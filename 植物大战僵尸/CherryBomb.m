//
//  P_CherryBomb.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "CherryBomb.h"

@implementation CherryBomb

+ (id) newPlant
{
    CherryBomb *plant = [CherryBomb spriteNodeWithImageNamed:@"CherryBomb_0.png"];
    plant.lifeValue = CHERRYBOMB_LIFEVALUE;
    plant.sunValue = CHERRYBOMB_SUNVALUE;

    
    return plant;
}

- (void) startAnimation
{
    [self loadImage:@"CherryBomb" count:6];
}

- (void) bomb
{
    [self loadImage:@"Boom" count:0];
}

@end
