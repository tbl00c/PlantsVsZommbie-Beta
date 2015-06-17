//
//  Background.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "Background.h"

@implementation Background
@synthesize plantStartPoint = startPoint;


+ (id) newBackgroundByValue: (enum BackGroundType) value rect:(CGRect)rect
{
    Background *bg;
    switch (value) {
        case BackgroundNormalValue:
            bg = [Background spriteNodeWithImageNamed: @"background1.jpg"];
            
            bg.plantStartPoint = CGPointMake(165, 20);
            bg.plantSpaceSize = CGSizeMake(PLANT_WEIDTH, PLANT_HEIGHT);
            bg.road = 5;
            
            bg.Duck = NO;
            [bg initMapArray];
            break;
        default:
            break;
    }
    
    bg.name = @"Background";
    bg.size = CGSizeMake(rect.size.width + 260, rect.size.height);
    bg.position = CGPointMake(CGRectGetMidX(rect) + 130, CGRectGetMidY(rect));
    
    return bg;
}


- (void) initMapArray
{
    memset(map, 0, sizeof(map));
    memset(zombie, 0, sizeof(zombie));
}

- (int) getRow:(CGPoint)point
{
    return (int)(point.y - startPoint.y) / PLANT_HEIGHT;
}

- (BOOL) hasPlant: (CGPoint) point
{
    int x = (int)(point.x - startPoint.x) / PLANT_WEIDTH;
    int y = (int)(point.y - startPoint.y) / PLANT_HEIGHT;
    
    if (x >= 0 && x < MAP_X && y >= 0 && y < MAP_Y) {
        if (map[x][y] == 0) {
            return NO;
        }
        else{
            return YES;
        }
    }
    
    return NO;
}

- (BOOL) canPutPlant: (CGPoint) point
{
    int x = (int)(point.x - startPoint.x) / PLANT_WEIDTH;
    int y = (int)(point.y - startPoint.y) / PLANT_HEIGHT;
    
    if (x >= 0 && x < MAP_X && y >= 0 && y < MAP_Y) {
        if (map[x][y] == 0) {
            return YES;
        }
    }
    
    return NO;
}

- (CGPoint) putPlantAndGetRightPosition: (CGPoint) point
{
    int x = (int)(point.x - startPoint.x) / PLANT_WEIDTH;
    int y = (int)(point.y - startPoint.y) / PLANT_HEIGHT;
    
    map[x][y] += 1;
    
    x = x * PLANT_WEIDTH + startPoint.x + 0.5 * PLANT_WEIDTH;
    y = y * PLANT_HEIGHT + startPoint.y + 0.5 * PLANT_HEIGHT;
    
    return CGPointMake(x, y);
}

- (CGPoint) removePlantAndGetRightPosition: (CGPoint) point
{
    int x = (int)(point.x - startPoint.x) / PLANT_WEIDTH;
    int y = (int)(point.y - startPoint.y) / PLANT_HEIGHT;
    
    map[x][y] -= 1;
    
    x = x * PLANT_WEIDTH + startPoint.x + 0.5 * PLANT_WEIDTH;
    y = y * PLANT_HEIGHT + startPoint.y + 0.5 * PLANT_HEIGHT;
    
    return CGPointMake(x, y);
}

- (CGPoint) getRightPosition:(CGPoint)point
{
    int x = (int)(point.x - startPoint.x) / PLANT_WEIDTH;
    int y = (int)(point.y - startPoint.y) / PLANT_HEIGHT;
    
    x = x * PLANT_WEIDTH + startPoint.x + 0.5 * PLANT_WEIDTH;
    y = y * PLANT_HEIGHT + startPoint.y + 0.5 * PLANT_HEIGHT;
    
    return CGPointMake(x, y);
}

- (BOOL) hasZombie:(CGPoint) point
{
#warning 只能具体到行
    int y = (int)(point.y - startPoint.y) / PLANT_HEIGHT;
    if (zombie[y] == 0) {
        return NO;
    }
    return YES;
}

- (void) addZombie:(CGPoint)point
{
    int y = (int)(point.y - startPoint.y) / PLANT_HEIGHT;
    
    zombie[y] ++;
}

- (void) removeZombie:(CGPoint)point
{
    int y = (int)(point.y - startPoint.y) / PLANT_HEIGHT;

    zombie[y] --;
}


@end
