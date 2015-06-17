//
//  controllerHeader.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-3.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#ifndef _______mainHeader_h
#define _______mainHeader_h

enum PlantValue{
    SunFlowerValue,      // 向日葵
    PeashooterValue,     // 豆枪
    WallNutValue,        // 坚果
    ThreepeaterValue,    // 三个豆枪
    CherryBombValue,     // 樱桃炸弹
    SnowPeaValue,        // 冰豌豆
};

#define MEDIATOR_UPDATE_TIME        0.05

// Z_POSITION

#define BACKGROUND_ZPOSITION        0
#define CONTROLLER_ZPOSITION        0
#define MENUITEM_ZPOSITION          1

#define PLANT_START_ZPOSITION       100             // 植物
#define SHOVELMENUITEM_ZPOSITION    110             // 铲子菜单

#define BULLET_CONTROLLER_ZPOSITION 200             // 子弹层
#define ZOMBIE_CONTROLLER_ZPOSITION 201             // 僵尸层
#define SUN_CONTROLLER_ZPOSITION    202             // 阳光层


#define SUN_ZPOSITION               10001
#define LAYER_CONTROLLER_ZPOSITION  10002

#endif
