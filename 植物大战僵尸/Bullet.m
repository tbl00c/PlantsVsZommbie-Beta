//
//  Bullet.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

+ (id) spriteNodeWithImageNamed:(NSString *)name
{
    Bullet *bullet = [super spriteNodeWithImageNamed:name];
    bullet.canMove = YES;
    bullet.name = @"Bullet";
    bullet.zPosition = 9999;
    [bullet setScale:0.75];
    return bullet;
}

@end
