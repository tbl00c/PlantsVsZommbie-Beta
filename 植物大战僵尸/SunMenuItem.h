//
//  SunMenuItem.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SunMenuItem : SKSpriteNode

@property (nonatomic) int sunValue;
@property (nonatomic, strong) SKLabelNode *label;

+ (id) createSunMenuItemWithPoint: (CGPoint) point;
- (void) addScore: (int) score;
- (void) subScore: (int) score;
- (BOOL) canSubScore: (int) score;

@end
