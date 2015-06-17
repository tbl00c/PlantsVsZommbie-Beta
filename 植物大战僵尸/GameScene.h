//
//  GameScene.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-10-30.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "Mediator.h"
#import "Background.h"
#import "ControllerHeader.h"

@interface GameScene : SKScene
{
    Mediator *mediator;
}

@property (nonatomic, strong) Background *background;

@property enum BackGroundType *backgroundInfo;
@property (nonatomic, strong) NSMutableArray *zombiesInfo;

@end
