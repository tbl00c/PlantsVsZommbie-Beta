//
//  plantController.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-10-31.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "Controller.h"
#import "PlantHeader.h"
#import "mainHeader.h"

@interface PlantController : Controller

+ (id) plantByValue: (enum PlantValue) value;
- (void) addPlant: (id) plant;
- (void) removePlantAtPoint: (CGPoint) point;

@end
