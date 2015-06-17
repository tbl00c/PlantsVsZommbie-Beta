//
//  BulletNormal.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "BulletNormal.h"

@implementation BulletNormal

+ (id) createBullerAtPoint: (CGPoint) point
{
    BulletNormal *bullet = [BulletNormal spriteNodeWithImageNamed:@"PB0_R.png"];
    bullet.position = point;
    bullet.hitValue = 20;
    bullet.subSpace = 0;
    
    return bullet;
}

- (void) Bomb
{
    self.position = CGPointMake(self.position.x + 10, self.position.y);
    
    SKTexture *texture = [SKTexture textureWithImageNamed:@"PB0_H.png"];
    SKAction *setTexture = [SKAction setTexture:texture];
    SKAction *wait = [SKAction waitForDuration:0.1];
    SKAction *one = [SKAction sequence:@[setTexture, wait]];
    
    SKAction *move = [SKAction moveTo:CGPointMake(self.position.x, self.position.y - 20) duration:1];
    SKAction *fade = [SKAction fadeOutWithDuration:1];
    SKAction *two = [SKAction group:@[move, fade]];
    
    SKAction *miss = [SKAction removeFromParent];
    
    SKAction *all = [SKAction sequence:@[one, two, miss]];
    [self runAction:all];
    
}

@end
