//
//  Zombie.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "Zombie.h"
#import "PlantController.h"     // 仅用于检测植物类型
#import "GameScene.h"

@implementation Zombie

+ (id) spriteNodeWithImageNamed:(NSString *)name
{
    Zombie *newZombie = [super spriteNodeWithImageNamed:name];
    [newZombie setScale:0.8];
    newZombie.eat = NO;
    newZombie.death = NO;
    newZombie.spaceUpdateTime = 0;
    
    return newZombie;
}

#pragma mark - animation

- (NSMutableArray *) loadTexture:(NSString *)name count:(int)count      // 载入纹理
{
    NSMutableArray *texture = [[NSMutableArray alloc] init];
    for (int i = 0; i <= count; i ++) {
        NSString *add = [NSString stringWithFormat:@"%@_%d.png", name, i];
        SKTexture *t = [SKTexture textureWithImageNamed:add];
        [texture addObject:t];
    }
    return texture;
}


- (void) changeAnimation
{
    if(self.death == YES)
        return;
    
    if(self.lifeValue <= 0 && self.textureID != 3){
        self.death = YES;
        [self loadDeathAnimation];
        return;
    }
    
    if(self.eat == NO){
        if(self.lifeValue < 0.2 * defaultLife && self.textureID != 2){
            if (self.textureID != 5) {
                [self loadHeadAnimation];
            }
            [self loadLostHeadAnimation];
        }
        else if(self.lifeValue < 0.6 * defaultLife && self.textureID != 1){
            [self loadInjuredAnimation];
        }
        else if(self.lifeValue >= 0.6 * defaultLife && self.textureID != 0){
            [self loadInitAnimation];
        }
    }
    else{
        if(self.lifeValue < 0.2 * defaultLife && self.textureID != 5){
            if (self.textureID != 2) {
                [self loadHeadAnimation];
            }
            [self loadLostHeadAttackAnimation];
        }
        else if(self.textureID != 4){
            [self loadAttackAnimation];
        }
    }
}

- (void) removeFromParent
{
    [((GameScene *)(self.parent.parent)).background removeZombie:self.position];
    [super removeFromParent];
}

- (void) runAnimation: (NSMutableArray *)texture
{
    [self removeAllActions];
    SKAction *action = [SKAction animateWithTextures:texture timePerFrame:DEFAULT_TEXTURE_UPDATE_TIME];
    [self runAction:action];
}

- (void) runAnimationRepeat: (NSMutableArray *)texture
{
    [self removeAllActions];
    SKAction *action = [SKAction animateWithTextures:texture timePerFrame:DEFAULT_TEXTURE_UPDATE_TIME];
    [self runAction:[SKAction repeatActionForever:action]];
}

#pragma mark - be hit

- (void) subLife: (float) value
{
    self.lifeValue -= value;

    [self changeAnimation];
}

- (void) subSpace:(float)space
{
    if (space == 0) {
        if (self.space != defaultSpace) {
            return;
        }
        // space = 0时不减速，只减血量，闪黄光
        SKAction *light = [SKAction colorizeWithColor:[SKColor yellowColor] colorBlendFactor:0.5 duration:0.01];
        SKAction *wait = [SKAction waitForDuration: 0.1];
        SKAction *removelight = [SKAction colorizeWithColor:[SKColor whiteColor] colorBlendFactor:0 duration:0.01];
        SKAction *tink = [SKAction sequence:@[light, wait, removelight]];
        [self runAction:tink];
        return;
    }
    
    
    // 减速
    self.space = defaultSpace - space;
    self.hitValue = defaultHitValue / 2;
    self.spaceUpdateTime = -1;
}

#pragma mark - update
- (BOOL) canMove
{
    if(self.death)      // 检查有没有死亡
        return NO;
    
    CGPoint point = CGPointMake(self.position.x + 10, self.position.y - self.frame.size.height / 2);
    NSArray *array = [self.parent.parent nodesAtPoint:point];
    for (id sth in array) {
        // 僵尸前面如果有植物层的植物，则停止前进，开始攻击
        if ([sth superclass] == [Plant class] && ([((Plant *)sth).parent class] == [PlantController class])) {
            if (self.eat == NO) {
                self.position = CGPointMake(self.position.x - 5, self.position.y);
                self.eat = YES;
                [self changeAnimation];
            }
            else{
                [(Plant *)sth subLife:self.hitValue];
            }
            return NO;
        }
    }
    if(self.eat == YES){
        self.eat = NO;
        [self changeAnimation];
    }
    return YES;
}

- (void) update:(NSTimeInterval)currentTime
{
    if (tm == 0) {
        tm = currentTime;
        // 第一次更新时设置基本信息
        defaultLife = _lifeValue;
        defaultSpace = _space;
        defaultHitValue = _hitValue;
    }
    else if(currentTime - tm >= DEFAULT_ZOMBIE_UPDATE_TIME){
        if ([self canMove]) {
            float x = self.position.x - self.space;
            self.position = CGPointMake(x , self.position.y);
            if (x <= 130) {         // 游戏失败
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GameOver_Failed" object:nil];
            }
            tm = currentTime;
        }
    }
    
    if (self.spaceUpdateTime == 0) {        // 不减速
        return;
    }
    else if (self.spaceUpdateTime == -1) {              // 减速开始
        self.spaceUpdateTime = currentTime + 5;         // 减速效果持续时间

        SKAction *light = [SKAction colorizeWithColor:[SKColor blueColor] colorBlendFactor:0.5 duration:0.01];
        [self runAction:light];
    }
    else if(self.spaceUpdateTime < currentTime){        // 减速完成
        self.spaceUpdateTime = 0;
        
        SKAction *removelight = [SKAction colorizeWithColor:[SKColor whiteColor] colorBlendFactor:0 duration:0.01];
        [self runAction:removelight completion:^{
            self.space = defaultSpace;
            self.hitValue = defaultHitValue;
        }];
    }
}

@end
