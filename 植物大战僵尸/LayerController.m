//
//  LayerController.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-3.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "LayerController.h"

@interface LayerController ()
@property (nonatomic, strong) SKSpriteNode *introduceLayer;
@property (nonatomic, strong) SKSpriteNode *welcomeLayer;
@property (nonatomic, strong) SKSpriteNode *mainMenuLayer;
@end

@implementation LayerController

+ (id) createControllerWithRect:(CGRect)rect
{
    LayerController *controller = [LayerController spriteNodeWithColor:[SKColor clearColor] size:rect.size];
    controller.mainRect = rect;
    
    return controller;
}

- (SKSpriteNode *) getIntroduceLayer
{
    if(_introduceLayer == nil){
        _introduceLayer = [SKSpriteNode spriteNodeWithColor:[SKColor blackColor] size:self.size];
        
        SKSpriteNode *image = [SKSpriteNode spriteNodeWithImageNamed:@"1.jpg"];
        image.position= CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        image.size = self.frame.size;
        [_introduceLayer addChild:image];
        
        
        SKLabelNode *title = [SKLabelNode labelNodeWithText:@"坤哥出品，必属精品！"];
        title.fontName = @"娃娃体—简体";
        title.fontSize = 12;
        title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) + 15);
        [_introduceLayer addChild:title];
    }
    
    _introduceLayer.alpha = 0;
    SKAction *wait0 = [SKAction waitForDuration:0.2];
    SKAction *show = [SKAction fadeInWithDuration:0.6];
    SKAction *wait = [SKAction waitForDuration:1.5];
    SKAction *miss = [SKAction fadeOutWithDuration:0.6];
    [_introduceLayer runAction:[SKAction sequence:@[wait0, show, wait, miss]]];
    return _introduceLayer;
}

- (SKSpriteNode *) getWelcomeLayer
{
    if (_welcomeLayer == nil) {
        _welcomeLayer = [SKSpriteNode spriteNodeWithImageNamed:@"titlescreen.png"];         // 背景
        _welcomeLayer.size = self.size;
        
        
        SKSpriteNode *title = [SKSpriteNode spriteNodeWithImageNamed:@"pvz_logo.png"];     // 标题
        title.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMaxY(self.frame));
        title.zPosition = 1;
        [_welcomeLayer addChild:title];
        title.speed = 0.5;
        
        SKSpriteNode *down = [SKSpriteNode spriteNodeWithImageNamed:@"down.png"];          // 土地
        down.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMinY(self.frame) - 20);
        down.zPosition = 1;
        [_welcomeLayer addChild:down];
        down.speed = 0.5;
        
        SKAction *wait = [SKAction waitForDuration:0.15];   // 标题
        SKAction *move = [SKAction moveTo:CGPointMake(self.position.x, CGRectGetMaxY(self.frame) - 50) duration:0.4];
        SKAction *addSpeed = [SKAction speedTo:5 duration:0.5];
        SKAction *titleAction = [SKAction sequence:@[wait, [SKAction group:@[move, addSpeed]]]];
        [title runAction: titleAction
              completion:^{         // 土地
            SKAction *downMove = [SKAction moveTo:CGPointMake(self.position.x, CGRectGetMinY(self.frame) + 35) duration:0.4];
            SKAction *downAction = [SKAction sequence:@[wait, [SKAction group:@[addSpeed, downMove]]]];
            [down runAction:downAction
                 completion:^{        // 草
                     [self tempo];
            }];
        }];
    }
    
    return _welcomeLayer;
}

- (void) tempo          // 初始化进度条
{
    SKSpriteNode *roll = [SKSpriteNode spriteNodeWithImageNamed:@"SodRollCap.png"];
    roll.position = CGPointMake(self.position.x - 160, -105);
    roll.zPosition = 2;
    [roll setScale:0.8];
    [_welcomeLayer addChild:roll];
    
    SKAction *rotate = [SKAction rotateByAngle:- M_PI duration:1];
    [roll runAction:[SKAction repeatAction:rotate count:3]];
    
    SKAction *move = [SKAction moveTo:CGPointMake(self.position.x + 138, -126) duration:3];
    SKAction *scale = [SKAction scaleTo:0.32 duration:3];
    
    SKAction *group = [SKAction group:@[move, scale]];
    SKAction *miss = [SKAction removeFromParent];
    [roll runAction:[SKAction sequence:@[group, miss]]];
    
    SKSpriteNode *grass = [SKSpriteNode spriteNodeWithImageNamed:@"grass.png"];        // 草丛
    grass.zPosition = 2;
    float w = grass.size.width;
    grass.position = CGPointMake(self.position.x - 160, -124);
    grass.size = CGSizeMake(1, grass.frame.size.height);
    [_welcomeLayer addChild:grass];
    
    SKAction *resize = [SKAction resizeToWidth:w duration:3];
    SKAction *move2 = [SKAction moveTo:CGPointMake(self.position.x - 6, -124) duration:3];
    [grass runAction:[SKAction group:@[resize, move2]]];
}

- (SKSpriteNode *) getMainMenuLayer
{
    if (_mainMenuLayer == nil) {
        _mainMenuLayer = [SKSpriteNode spriteNodeWithImageNamed:@"main_background.png"];
        _mainMenuLayer.size = self.frame.size;
    }
    
    return _mainMenuLayer;
}


- (void) showPrepareLayer
{
    if (prepareLayer == nil) {
        prepareLayer = [PrepareGrowPlantsLayer newLayerScene:self.frame];
        prepareLayer.position = CGPointMake(CGRectGetMidX(self.mainRect), CGRectGetMidY(self.mainRect));
    }
    [self addChild: prepareLayer];
    [prepareLayer showAction];
}

- (void) showGameOverFailedLayer
{
    if (gameOverFailedLayer == nil) {
        gameOverFailedLayer = [GameOverFailedLayer newLayerScene:self.frame];
        gameOverFailedLayer.position = CGPointMake(CGRectGetMidX(self.mainRect), CGRectGetMidY(self.mainRect));
        gameOverFailedLayer.zPosition = 10000;
    }
    [self addChild:gameOverFailedLayer];
    [gameOverFailedLayer showAction];
}


+ (AVAudioPlayer *) getRootSceneMusic
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"rootScene" withExtension:@"mp3"];
    AVAudioPlayer *music = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:Nil];
    music.numberOfLoops = -1;
    [music prepareToPlay];
    
    return music;
}

+ (AVAudioPlayer *) getGameMusic3
{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"game3" withExtension:@"mp3"];
    AVAudioPlayer *music = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:Nil];
    music.numberOfLoops = -1;
    [music prepareToPlay];
    
    return music;
}

@end
