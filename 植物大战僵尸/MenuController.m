//
//  MenuController.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-3.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "MenuController.h"

#define PLANT_MENU_ITEM_START_Y     CGRectGetMaxY(self.mainRect) - 10

#define SUN_MENU_ITEM_POSSITION     CGPointMake(61, 358)
#define SUN_PRODUCT_RANGE           CGRectMake(157, 40, 380, 350)

#define SHOVEL_MENU_ITEM_POSSITION  CGPointMake(630, 352)

static int menu_i = 0;

@implementation MenuController

+ (id) createControllerWithRect:(CGRect)rect
{
    MenuController *controller = [MenuController spriteNodeWithColor:[SKColor clearColor] size:rect.size];
    controller.mainRect = rect;
    controller.plantsMenu = [[NSMutableArray alloc] init];
    menu_i = 0;
    
    return controller;
}

#pragma mark - showMenuItem
- (void) addPlantMenuItemWithType:(enum PlantValue)value
{
    int startY = PLANT_MENU_ITEM_START_Y;
    PlantMenuItem *item = [PlantMenuItem createItemByValue:value];
    item.name = @"PlantMenuItem";
    [item setScale:0.74];
    item.position = CGPointMake(item.frame.size.width / 2 + 2, startY - item.frame.size.height * (1.2 + menu_i) );
    item.zPosition = MENUITEM_ZPOSITION;
    
    [_plantsMenu addObject:item];
    [self addChild:item];
    menu_i ++;
}

- (void) createShovelMenuItem
{
    shovelMenuItem = [ShovelMenuItem createShovelMenuItemWithPoint: SHOVEL_MENU_ITEM_POSSITION];
    shovelMenuItem.zPosition = SHOVELMENUITEM_ZPOSITION;
    shovelMenuItem.name = @"ShovelMenuItem";
    
    [self addChild:shovelMenuItem];
}

- (void) createSunMenuWithSunValue:(int)sunValue
{
    sunMenuItem = [SunMenuItem createSunMenuItemWithPoint:SUN_MENU_ITEM_POSSITION];
    sunMenuItem.sunValue = sunValue;
    sunMenuItem.zPosition = MENUITEM_ZPOSITION;
    sunMenuItem.name = @"SunMenuItem";
    
    [self addChild:sunMenuItem];
}

#pragma mark - Score
- (void) addSunValue: (int) sunValue
{
    [sunMenuItem addScore:sunValue];
}

- (BOOL) canSubSunValue:(int)sunValue
{
    return [sunMenuItem canSubScore:sunValue];
}

- (void) subSunValue:(int)sunValue
{
    [sunMenuItem subScore:sunValue];
}


#pragma mark - Touch


- (void) update:(NSTimeInterval)currentTime
{
    for (PlantMenuItem *item in _plantsMenu) {
        [item update:currentTime];
    }
}

@end
