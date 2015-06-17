//
//  Card.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-10-30.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "PlantHeader.h"
#import "mainHeader.h"

@interface PlantMenuItem : SKSpriteNode

@property enum PlantValue value;        // 类型
@property float coolingTime;            // 冷却时间
@property int sunValue;                 // 生产花销

@property float preTime;                // 冷却开始时间
@property (nonatomic, strong) SKSpriteNode *waitSprite;     // 冷却进度
@property BOOL canProductPlant;         // 冷却完成标志

//@property (nonatomic, strong) SKSpriteNode *chooseMenu;

+ (id) createItemByValue: (enum PlantValue) value;
+ (id) newItemWithImage: (NSString *)image time: (float) time sunValue: (int) sunValue;

- (void) userChoose;
- (void) giveUpChoose;
- (void) update: (NSTimeInterval) currentTime;
- (BOOL) canPutPlant;
- (void) putPlantFinished;

@end
