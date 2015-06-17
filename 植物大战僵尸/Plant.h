//
//  Plant.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-10-31.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PlantInfoHeader.h"
#import "mainHeader.h"

// Plants
#define PLANT_WEIDTH    54
#define PLANT_HEIGHT    61
#define DEFAULT_PLANT_UPDATE_TIME     0.1            // 植物纹理切换速度


@protocol PlantProtocal <NSObject>

@optional
- (void) startAnimation;

- (void) subLife: (float) value;
- (void) removeFromParentWithAnimation;

- (void) update: (NSTimeInterval)currentTime;
+ (id) newPlant;
- (void) loadImage:(NSString *)name count:(int)count;

@end

@interface Plant : SKSpriteNode <PlantProtocal>
{
    NSTimeInterval tm;
}

@property CGPoint fatherPoint;      // 父节点（button）坐标
@property int status;

@property float default_lifeValue;
@property float lifeValue;          // 生命值
@property int sunValue;             // 花销
@property float updateInterval;     // 更新间隔

@property BOOL hit;
@property float hitValue;
@property float hitRange;

@property float childValue;


@end
