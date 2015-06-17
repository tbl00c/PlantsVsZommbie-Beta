//
//  ShovelMenuItem.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ShovelMenuItem : SKSpriteNode

@property CGPoint startPoint;
@property BOOL move;

+ (id) createShovelMenuItemWithPoint: (CGPoint) point;
- (void) moveBackAfterActionInPoint: (CGPoint) point;

- (void) userChoose;
- (void) giveUpChoose;

@end
