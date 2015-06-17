//
//  BulletController.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "Controller.h"
#import "BulletHeader.h"

@interface BulletController : Controller

+ (id) bulletByValue: (enum BulletValue) value position: (CGPoint) point;

@end
