//
//  PlantInfoHeader.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-2.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#ifndef _______PlantInfoHeader_h
#define _______PlantInfoHeader_h

// SunFlower
#define SUNFLOWER_SUNVALUE          50         // 价值 (菜单)
#define SUNFLOWER_COOLING_TIME      7.5        // 冷却时间（菜单）

#define SUNFLOWER_LIFEVALUE         300        // 生命值
#define SUNFLOWER_UPDATA_INTERVAL   24         // 更新间隔
#define SUNFLOWER_SONVALUE          25         // 产物属性


// Peashooter
#define PEASHOOTER_LIFEVALUE        300
#define PEASHOOTER_SUNVALUE         100
#define PEASHOOTER_UPDATA_INTERVAL  0.9
#define PEASHOOTER_COOLING_TIME     7.5



#define PEASHOOTER_BULLET_POSITION   CGPointMake(self.position.x + 16, self.position.y + 13)

// Wall-Nut
#define WALLNUT_LIFEVALUE           4000
#define WALLNUT_SUNVALUE            50
#define WALLNUT_COOLING_TIME        30


// SnowPea
#define SNOWPEA_SUNVALUE            175
#define SNOWPEA_LIFEVALUE           300
#define SNOWPEA_UPDATA_INTERVAL     0.9
#define SNOWPEA_COOLING_TIME        7.5


// CherryBomb
#define CHERRYBOMB_SUNVALUE         150
#define CHERRYBOMB_LIFEVALUE        300
#define CHERRYBOMB_HITVALUE         1800
#define CHERRYBOMB_HITRANGE         1.5
#define CHERRYBOMB_COOLING_TIME     30
#define CHERRYBOOM_UPDATA_INTERVAL  1

// THREEPEATER
#define THREEPEATER_SUNVALUE        325
#define THREEPEATER_LIFEVALUE       300
#define THREEPEATER_COOLING_TIME    7.5
#define THREEPEATER_UPDATA_INTERVAL 1.4


#define SNOWPEA_BULLET_POSITION      CGPointMake(self.position.x + 16, self.position.y + 12)

#endif
