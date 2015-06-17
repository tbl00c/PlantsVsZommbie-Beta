//
//  ZombieController.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "Controller.h"
#import "ZombieHeader.h"

@interface ZombieController : Controller
{
    Zombie *zombie;
}


@property CGPoint startPoint;
@property CGSize plantSpaceSize;
@property int road;

- (id) createZombieByValue: (enum ZombieValue) value;

@end
