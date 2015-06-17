//
//  Sun.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#define SUN_SURVIVE_TIME  8

#define SUN_FATHER_POSITION CGPointMake(15, 358)

@interface Sun : SKSpriteNode

@property int sunValue;

+ (id) newSunAt:(CGPoint)position;

- (void) moveTo: (CGPoint)point;
- (void) removeFromParentAndAddScore;
- (void) waitAndMiss;

@end
