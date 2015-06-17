//
//  SunController.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "SunController.h"

@implementation SunController

+ (id) createControllerWithRect:(CGRect)rect
{
    SunController *controller = [SunController spriteNodeWithColor:[SKColor clearColor] size:rect.size];
    
    int x = rect.origin.x + rect.size.width / 4;
    int y = rect.origin.y + rect.size.height / 9;
    int widht = (rect.size.width - x) * 7 / 8;
    int height = rect.size.height - y;
    controller.mainRect = CGRectMake(x, y, widht, height);
    
    return controller;
}

- (void) ProductSun
{
    CGPoint startPoint = [self createPoint];
    Sun *newSun = [Sun newSunAt:startPoint];
    newSun.sunValue = 25;
    [newSun setScale:0.73];
    [newSun moveTo:CGPointMake(startPoint.x, self.mainRect.origin.y)];
    newSun.zPosition = SUN_ZPOSITION;
    [self addChild:newSun];
}

- (CGPoint) createPoint
{
    int x = self.mainRect.origin.x + arc4random() % (int)(self.mainRect.size.width);
    int y = self.mainRect.origin.y + self.mainRect.size.height;
    
    return CGPointMake(x, y);
}

- (void) update: (NSTimeInterval)currentTime
{
    if (tm == 0) {
        tm = currentTime - 14;
    }
    else if (currentTime - tm >= SUN_PRODUCT_TIME) {
        [self ProductSun];
        tm = currentTime;
    }
    
}

@end
