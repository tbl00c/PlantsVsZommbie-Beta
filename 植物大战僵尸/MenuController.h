//
//  MenuController.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-3.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "Controller.h"
#import "PlantController.h"

#import "ShovelMenuItem.h"
#import "SunMenuItem.h"
#import "PlantMenuItem.h"


@interface MenuController : Controller
{    
    PlantMenuItem *plantMenuItem;
    SunMenuItem *sunMenuItem;
    ShovelMenuItem *shovelMenuItem;
}

@property (nonatomic, strong) NSMutableArray *plantsMenu;

- (void) addPlantMenuItemWithType: (enum PlantValue) value;
- (void) createSunMenuWithSunValue: (int) sunValue;
- (void) createShovelMenuItem;

- (void) addSunValue: (int) sunValue;
- (BOOL) canSubSunValue: (int) sunValue;
- (void) subSunValue: (int) sunValue;


@end
