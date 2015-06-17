//
//  LayerController.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-3.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "Controller.h"
#import "LayerHeader.h"


@interface LayerController : Controller
{
    PrepareGrowPlantsLayer *prepareLayer;
    GameOverFailedLayer *gameOverFailedLayer;
}



- (SKSpriteNode *) getIntroduceLayer;
- (SKSpriteNode *) getWelcomeLayer;
- (SKSpriteNode *) getMainMenuLayer;


- (void) showPrepareLayer;
- (void) showGameOverFailedLayer;

+ (AVAudioPlayer *) getRootSceneMusic;
+ (AVAudioPlayer *) getGameMusic3;

@end
