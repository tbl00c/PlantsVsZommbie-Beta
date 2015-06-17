//
//  P_SunFlower.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-10-31.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "SunFlower.h"
#import "Sun.h"

@implementation SunFlower

+ (id) newPlant
{
    SunFlower *plant = [SunFlower spriteNodeWithImageNamed:@"SunFlower_0.png"];
    
    plant.updateInterval = SUNFLOWER_UPDATA_INTERVAL;
    plant.lifeValue = SUNFLOWER_LIFEVALUE;
    plant.sunValue = SUNFLOWER_SUNVALUE;
    
    plant.childValue = SUNFLOWER_SONVALUE;

    
    return plant;
}

- (void) startAnimation
{
    [self loadImage:@"SunFlower" count:17];
    tm = 0;
}

- (void) update: (NSTimeInterval)currentTime
{
    if (tm == 0) {
        tm = currentTime;
    }
    else if(currentTime - tm >= self.updateInterval){
        tm = currentTime;
        
        Sun *sun = [Sun newSunAt:CGPointMake(self.position.x + 15, self.position.y - 15)];
        [sun setSunValue:self.childValue];
        sun.zPosition = SUN_ZPOSITION;
        
        // 产生阳光前自身闪光
        SKAction *light = [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:0.5 duration:0.6];
        SKAction *removelight = [SKAction colorizeWithColor:[SKColor whiteColor] colorBlendFactor:0.5 duration:0.6];
        SKAction *tink = [SKAction sequence:@[light, removelight]];
        [self runAction:[SKAction repeatAction:tink count:2] completion:^{      // 产生阳光前闪红光
            [self.parent.parent addChild:sun];
            SKAction *zoom = [SKAction scaleXTo:0.7 y:0.7 duration:0.3];
            SKAction *show = [SKAction fadeInWithDuration:0.2];
            [sun runAction:[SKAction group:@[zoom, show]] completion:^{
                [sun waitAndMiss];
            }];
        }];
    }
}


@end
