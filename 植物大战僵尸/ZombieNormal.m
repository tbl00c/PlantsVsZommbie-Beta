//
//  ZombieNormal.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "ZombieNormal.h"


@implementation ZombieNormal

+ (id) newZombie
{
    ZombieNormal *zombie = [ZombieNormal spriteNodeWithImageNamed:@"Zombie_2.png"];
    [zombie loadInitAnimation];
    
    zombie.status = 0;
    zombie.lifeValue = 200;
    zombie.hitValue = 2;
    zombie.space = 0.7;
    
    return zombie;
}

- (void) loadInitAnimation
{
    NSMutableArray *texture = [self loadTexture:@"Zombie" count:21];
    self.textureID = 0;
    
    [self runAnimationRepeat:texture];
}

- (void) loadInjuredAnimation
{
    NSMutableArray *texture = [self loadTexture:@"Zombie3" count:17];
    self.textureID = 1;
    
    [self runAnimationRepeat:texture];
}

- (void) loadHeadAnimation
{
    self.textureID = 2;
    NSMutableArray *texture = [self loadTexture:@"ZombieHead" count:11];                    // 添加头部动画
    SKSpriteNode *head = [SKSpriteNode spriteNodeWithImageNamed:@"ZombieHead_0.png"];
    head.position = CGPointMake(self.position.x + self.frame.size.width, self.position.y);
    head.zPosition = self.zPosition + 10;
    [head setScale:0.8];
    if (self.space != defaultSpace) {           // 减速时，蓝色
        SKAction *light = [SKAction colorizeWithColor:[SKColor blueColor] colorBlendFactor:0.5 duration:0.001];
        [head runAction:light];
    }
    [self.parent.parent addChild:head];
    
    SKAction *animation = [SKAction animateWithTextures:texture timePerFrame:0.1];
    SKAction *fade = [SKAction fadeOutWithDuration:1];
    SKAction *miss = [SKAction removeFromParent];
    [head runAction:[SKAction sequence:@[animation, fade, miss]]];
}

- (void) loadLostHeadAnimation
{
    NSMutableArray *texture = [self loadTexture:@"ZombieLostHead" count:17];
    [self runAnimationRepeat:texture];
    
    float t = (self.lifeValue / 8 + 1) * 1;
    SKAction *wait = [SKAction waitForDuration:t];          // 减血
    [self runAction:wait completion:^{
        [self subLife:self.lifeValue];
    }];
}


- (void) loadDeathAnimation
{
    self.textureID = 3;
    self.death = YES;
    [self removeAllActions];
    
    NSMutableArray *texture = [self loadTexture:@"ZombieDie" count:9];
    
    
    SKAction *action = [SKAction animateWithTextures:texture timePerFrame:DEFAULT_TEXTURE_UPDATE_TIME];
    SKAction *fade = [SKAction fadeOutWithDuration:1];
    SKAction *miss = [SKAction removeFromParent];
    [self runAction:[SKAction sequence:@[action, fade, miss]]];
}

- (void) loadAttackAnimation
{
    self.textureID = 4;
    NSMutableArray *texture = [self loadTexture:@"ZombieAttack" count:20];
    
    [self runAnimationRepeat:texture];
}

- (void) loadLostHeadAttackAnimation
{
    self.textureID = 5;
    NSMutableArray *texture = [self loadTexture:@"ZombieLostHeadAttack" count:10];
    
    [self runAnimationRepeat:texture];
}




@end
