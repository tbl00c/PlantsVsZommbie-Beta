//
//  Card.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-10-30.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "PlantMenuItem.h"


#define LABEL_FONT              @"Impact"
#define LABEL_FONT_COLOR        [SKColor blackColor]

// PlantMenuItem
#define PLANT_LABEL_FONT_SIZE       15
#define PLANT_LABEL_FONT_POSITION   CGPointMake(15, -10)


@implementation PlantMenuItem
static SKSpriteNode *chooseMenu;

@synthesize value;
@synthesize coolingTime;
@synthesize sunValue;
@synthesize preTime;

+ (id) createItemByValue:(enum PlantValue)value
{
    PlantMenuItem *menu;
    switch (value) {
        case SunFlowerValue:     // 向日葵
            menu = [PlantMenuItem newItemWithImage:@"SunFlower.png" time:SUNFLOWER_COOLING_TIME sunValue:SUNFLOWER_SUNVALUE];
            break;
        case PeashooterValue:     // 豆枪
            menu = [PlantMenuItem newItemWithImage:@"Peashooter.png" time:PEASHOOTER_COOLING_TIME sunValue:PEASHOOTER_SUNVALUE];
            break;
        case WallNutValue:         // 坚果
            menu = [PlantMenuItem newItemWithImage:@"WallNut.png" time:WALLNUT_COOLING_TIME sunValue:WALLNUT_SUNVALUE];
            break;
        case ThreepeaterValue:    // 三个豆枪
            menu = [PlantMenuItem newItemWithImage:@"Threepeater.png" time:THREEPEATER_COOLING_TIME sunValue:THREEPEATER_SUNVALUE];
            break;
        case  CherryBombValue:     // 樱桃炸弹
            menu = [PlantMenuItem newItemWithImage:@"CherryBomb.png" time:CHERRYBOMB_COOLING_TIME sunValue:CHERRYBOMB_SUNVALUE];
            break;
        case SnowPeaValue:        // 冰豌豆
            menu = [PlantMenuItem newItemWithImage:@"SnowPea.png" time:SNOWPEA_COOLING_TIME sunValue:SNOWPEA_SUNVALUE];
            break;
            
        default:
            break;
    }

    menu.name = @"plantMenuItem";
    menu.value = value;             // 类型
    return menu;
}

+ (id) newItemWithImage: (NSString *)image time: (float) time sunValue: (int) sunValue
{
    PlantMenuItem *menu = [PlantMenuItem spriteNodeWithImageNamed:image];
    menu.coolingTime = time;
    menu.sunValue = sunValue;
    
    menu.preTime = 0;
    menu.canProductPlant = NO;

    // 阳光值标签
    SKLabelNode *label = [SKLabelNode labelNodeWithText:[NSString stringWithFormat:@"%d", sunValue]];
    label.fontName = LABEL_FONT;
    label.fontSize = PLANT_LABEL_FONT_SIZE;
    label.fontColor = LABEL_FONT_COLOR;
    label.position = CGPointMake(30,-25);
    label.zPosition = 1;
    [menu addChild:label];
    
    // 冷却进度
    CGSize size = CGSizeMake(menu.size.width, menu.size.height * 5 / 6);
    menu.waitSprite = [SKSpriteNode spriteNodeWithColor:[SKColor grayColor] size:size];
    menu.waitSprite.zPosition = 2;
    menu.waitSprite.position = CGPointMake(0, 0);
    menu.waitSprite.alpha = 0.4;
    [menu addChild:menu.waitSprite];
    
    // 选中标记
    chooseMenu = [SKSpriteNode spriteNodeWithImageNamed:@"chooseMenu.png"];
    chooseMenu.zPosition = 2;
    
    return menu;
}

- (void) userChoose
{
    [chooseMenu removeFromParent];
    chooseMenu.position = CGPointMake(0, 0);
    [self addChild:chooseMenu];
}

- (BOOL) canPutPlant
{
    if (_canProductPlant == NO) {
        // 冷却未完成动画
        SKAction *color1 = [SKAction colorizeWithColor:[SKColor whiteColor] colorBlendFactor:1 duration:0.1];
        SKAction *color2 = [SKAction colorizeWithColor:[SKColor grayColor] colorBlendFactor:1 duration:0.1];
        SKAction *action = [SKAction repeatAction:[SKAction sequence:@[color1, color2]] count:2];
        [self.waitSprite runAction: action];
    }
    
    return _canProductPlant;
}

- (void) putPlantFinished
{
    preTime = 0;
    self.canProductPlant = NO;
    [self giveUpChoose];
}

- (void) giveUpChoose
{
    [chooseMenu removeFromParent];
}

- (void) update: (NSTimeInterval) currentTime
{
    static float height = 0, width;
    
    if(self.canProductPlant == NO){
        if (preTime == 0) {
            preTime = currentTime;
            if (height == 0) {
                height = self.waitSprite.size.height;
                width = self.waitSprite.size.width;
            }
        }
        
        if (currentTime - preTime <= self.coolingTime) {
            // 更新冷却进度
            float t = (currentTime - preTime) / self.coolingTime;
            CGSize size = CGSizeMake(width, height * (1.0 - t));
            CGPoint point = CGPointMake(0, height * t / 2);
            self.waitSprite.position = point;
            self.waitSprite.size = size;
        }
        else{
            self.canProductPlant = YES;
        }
    }
}

@end
