//
//  Mediator.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-3.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Background.h"
#import "ControllerHeader.h"

@interface Mediator : NSObject
    
@property (weak) Background *background;
@property (weak) MenuController *menuController;
@property (weak) SunController *sunController;
@property (weak) PlantController *plantController;
@property (weak) BulletController *bulletController;
@property (weak) ZombieController *zombieController;

- (void) update: (NSTimeInterval)currentTime;

@end
