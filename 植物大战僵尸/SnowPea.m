//
//  P_SnowPea.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "SnowPea.h"
#import "BulletController.h"
#import "GameScene.h"

@implementation SnowPea

+ (id) newPlant
{
    SnowPea *plant = [SnowPea spriteNodeWithImageNamed:@"SnowPea_0.png"];
    plant.lifeValue = PEASHOOTER_LIFEVALUE;
    plant.sunValue = PEASHOOTER_SUNVALUE;
    plant.updateInterval = PEASHOOTER_UPDATA_INTERVAL;
    
    
    
    return plant;
}

- (void) startAnimation
{
    [self loadImage:@"SnowPea" count:14];
    tm = 0;
}

- (BOOL) canDo
{
    return [((GameScene *)self.parent.parent).background hasZombie:self.position];
}


- (void) update:(NSTimeInterval)currentTime
{
    if ([self canDo]) {
        if (tm == 0) {
            tm = currentTime;
        }
        else if(currentTime - tm >= self.updateInterval){
            tm = currentTime;
            id bullet = [BulletController bulletByValue:BulletICEValue position:PEASHOOTER_BULLET_POSITION];
            [self.parent.parent addChild:bullet];
        }
    }
    else{
        tm = currentTime;
    }
}

@end
