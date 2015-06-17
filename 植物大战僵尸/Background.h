//
//  Background.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Layer.h"
#import "Plant.h"

enum BackGroundType{
    BackgroundNormalValue,
    BackgroundDuckValue,
    BackgroundWithPoolValue,
    BackgroundDuckWithPoolValue,
    BackgroundRoofValue,
    Background0LawnValue,
    Background1Lawn,
    Background3Lawn,
};

#define MAP_X 9
#define MAP_Y 5



@interface Background : SKSpriteNode
{
    int map[MAP_X][MAP_Y];
    int zombie[MAP_Y];
}

@property BOOL Duck;
@property CGPoint plantStartPoint;
@property CGSize plantSpaceSize;
@property int road;

+ (id) newBackgroundByValue: (enum BackGroundType) value rect: (CGRect) rect;
- (void) initMapArray;

- (BOOL) hasPlant: (CGPoint) point;
- (BOOL) canPutPlant: (CGPoint) point;
- (CGPoint) putPlantAndGetRightPosition: (CGPoint) point;
- (CGPoint) removePlantAndGetRightPosition: (CGPoint) point;
- (CGPoint) getRightPosition: (CGPoint) point;

- (BOOL) hasZombie: (CGPoint) point;
- (void) addZombie: (CGPoint) point;
- (void) removeZombie: (CGPoint) point;

@end
