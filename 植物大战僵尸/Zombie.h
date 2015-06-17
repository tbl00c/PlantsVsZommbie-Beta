//
//  Zombie.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//
//  继承此类只需重载创建方法和各种状态动画方法

#import <SpriteKit/SpriteKit.h>

#define DEFAULT_ZOMBIE_UPDATE_TIME      0.025           // 僵尸
#define DEFAULT_TEXTURE_UPDATE_TIME     0.075            // 僵尸纹理切换速度

@protocol ZombiePortocol <NSObject>

@optional
+ (id) newZombie;
- (NSMutableArray *) loadTexture:(NSString *)name count:(int)count;

#pragma mark - 状态动画
- (void) loadInitAnimation;
- (void) loadInjuredAnimation;
- (void) loadLostHeadAnimation;
- (void) loadHeadAnimation;
- (void) loadDeathAnimation;

- (void) loadLostHeadAttackAnimation;
- (void) loadAttackAnimation;

#pragma mark - 随血量改变动画
- (void) changeAnimation;
- (void) runAnimation: (NSMutableArray *)texture;
- (void) runAnimationRepeat:(NSMutableArray *)texture;

#pragma mark - 生命值变化
- (void) subLife: (float) value;
- (void) subSpace: (float) space;

#pragma mark - update
- (BOOL) canMove;
- (void) update:(NSTimeInterval)currentTime;

@end

@interface Zombie : SKSpriteNode <ZombiePortocol>
{
    NSTimeInterval tm;
    float defaultSpace;
    int defaultLife;
    float defaultHitValue;
}

// 状态标记
@property int status;
@property BOOL eat;
@property BOOL death;
@property int textureID;

// 基本信息
@property float space;
@property float hitValue;
@property float lifeValue;

@property NSTimeInterval spaceUpdateTime;





@end
