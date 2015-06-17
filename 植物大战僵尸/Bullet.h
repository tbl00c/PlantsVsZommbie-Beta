//
//  Bullet.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol BulletProtocol

@optional
+ (id) createBullerAtPoint: (CGPoint) point;
- (void) Bomb;

@end


@interface Bullet : SKSpriteNode <BulletProtocol>

@property BOOL canMove;
@property float hitValue;
@property float subSpace;

@end
