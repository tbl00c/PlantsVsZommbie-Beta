//
//  RootScene.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-10-30.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "RootScene.h"
#import "GameScene.h"
#import "LayerController.h"

@interface RootScene ()

@property (nonatomic, strong) LayerController *layer;

@end


@implementation RootScene

static AVAudioPlayer *music;

- (LayerController *) layer
{
    if (_layer == nil) {
        _layer = [LayerController createControllerWithRect:CGRectMake(0, 0, 667, 375)];
    }
    return _layer;
}

- (void) didMoveToView:(SKView *)view{
    [self removeAllChildren];
    self.backgroundColor = [UIColor blackColor];
    if (music == nil) {
        self.size = CGSizeMake(667, 375);
        
        SKSpriteNode *layer = [self.layer getIntroduceLayer];
        layer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        layer.zPosition = 100;
        [self addChild:layer];

        [self runAction:[SKAction waitForDuration:3] completion:^{
            [self showWelcomeLayer];
        }];
        
        return;
    }
    
    [self runAction:[SKAction runBlock:^{
        music = [LayerController getRootSceneMusic];
        [music play];
    }]];
    [self showMainMenuLayer];
}

- (void) showWelcomeLayer
{
    [self removeAllChildren];
    [self runAction:[SKAction runBlock:^{
        music = [LayerController getRootSceneMusic];
        [music play];
    }]];
    
    
    SKSpriteNode *layer = [self.layer getWelcomeLayer];
    layer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    layer.zPosition = 100;
    [self addChild:layer];
        
    [self runAction:[SKAction waitForDuration:5] completion:^{
        LAButton *button = [LAButton newButtonWithButtonWithName:@"start" title:@"Click To Start Game"];
        button.position = CGPointMake(0,-158);
        button.delegate = self;
        button.zPosition = 10;
        button.fontColor = [SKColor yellowColor];
        button.fontName = @"Gabriola";
        button.fontSize = 20;
        button.alpha = 0;
        [layer addChild:button];
        [button runAction:[SKAction fadeInWithDuration:1]];
    }];
}

- (void) showMainMenuLayer
{
    [self removeAllChildren];
    SKSpriteNode *layer = [self.layer getMainMenuLayer];
    layer.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
  
// 花瓶选项
    LAButton *options = [LAButton newButtonWithButtonWithName:@"options" title:@"选项"];
    options.position = CGPointMake(170, -135);
    options.delegate = self;
    options.fontColor = [SKColor blackColor];
    options.fontSize = 18;
    [layer addChild:options];
    
    LAButton *help = [LAButton newButtonWithButtonWithName:@"help" title:@"帮助"];
    help.position = CGPointMake(228, -152);
    help.delegate = self;
    help.fontColor = [SKColor blackColor];
    help.fontSize = 18;
    [layer addChild:help];
    
    
    LAButton *exit = [LAButton newButtonWithButtonWithName:@"exit" title:@"退出"];
    exit.position = CGPointMake(285, -148);
    exit.delegate = self;
    exit.fontColor = [SKColor blackColor];
    exit.fontSize = 18;
    [layer addChild:exit];
    
// 墓碑选项
    IMButton *first = [IMButton newButtonWithButtonName:@"first" imageName:@"select10.png"];
    first.size = CGSizeMake(275, 80);
    first.position = CGPointMake(145, 105);
    first.delegate = self;
    [layer addChild:first];
    
    IMButton *second = [IMButton newButtonWithButtonName:@"second" imageName:@"select20.png"];
    second.size = CGSizeMake(261, 75);
    second.position = CGPointMake(137, 46);
    second.delegate = self;
    [layer addChild:second];
    
    IMButton *third = [IMButton newButtonWithButtonName:@"third" imageName:@"select30.png"];
    third.size = CGSizeMake(242, 78);
    third.position = CGPointMake(132, -5);
    third.delegate = self;
    [layer addChild:third];
    
    IMButton *fourth = [IMButton newButtonWithButtonName:@"fourth" imageName:@"select40.png"];
    fourth.size = CGSizeMake(225, 80);
    fourth.position = CGPointMake(125, -52);
    fourth.delegate = self;
    [layer addChild:fourth];

// 标识牌信息
    IMButton *one = [IMButton newButtonWithButtonName:@"one" imageName:@"PlayerScreen"];
    one.size = CGSizeMake(200, 100);
    one.speed = 0.5;
    one.position = CGPointMake(-205, 250);
    [layer addChild:one];
    SKAction *cp = [SKAction speedTo:5 duration:1];
    SKAction *move = [SKAction moveTo:CGPointMake(-205, 145) duration:0.8];
    [one runAction:[SKAction group:@[cp, move]]];
    
    IMButton *two = [IMButton newButtonWithButtonName:@"two" imageName:@"changePlayer1"];
    two.size = CGSizeMake(195, 35);
    two.position = CGPointMake(-205, 250);
    two.speed = 0.5;
    two.delegate = self;
    [layer addChild:two];
    SKAction *move2 = [SKAction moveTo:CGPointMake(-205, 83) duration:0.9];
    [two runAction:[SKAction group:@[cp, move2]]];
    
    IMButton *three = [IMButton newButtonWithButtonName:@"three" imageName:@"ps.png"];
    three.size = CGSizeMake(200, 40);
    three.position = CGPointMake(-210, 250);
    three.speed = 0.5;
    [layer addChild:three];
    SKAction *move3 = [SKAction moveTo:CGPointMake(-210, 55) duration:1.1];
    [three runAction:[SKAction group:@[cp, move3]]];
    
    [self addChild: layer];
}


- (void) showGameView
{
    CGSize size = self.size;
    GameScene *scene = [[GameScene alloc] initWithSize:size];
    scene.backgroundInfo = BackgroundNormalValue;
    
    [music stop];
    [self.view presentScene:scene];
}

- (void) LAButtonDown: (id) button
{
    NSString *name = ((LAButton *)button).name;
    if ([name compare:@"start"] == 0) {
        [self runAction:[SKAction waitForDuration:0.05] completion:^{
            [self showMainMenuLayer];
        }];
    }
    else if ([name compare:@"options"] == 0) {
        [self waitingForDevelop];
        [self runAction:[SKAction waitForDuration:0.1] completion:^{
            ((LAButton *)button).fontColor = [SKColor blackColor];
        }];
    }
    else if ([name compare:@"help"] == 0) {
        [self waitingForDevelop];
        [self runAction:[SKAction waitForDuration:0.1] completion:^{
            ((LAButton *)button).fontColor = [SKColor blackColor];
        }];
    }
    else if([name compare:@"exit"] == 0){
        exit(0);
    }
    else{
        [self waitingForDevelop];
        [self runAction:[SKAction waitForDuration:0.1] completion:^{
            ((LAButton *)button).fontColor = [SKColor blackColor];
        }];
    }
}

- (void) IMButtonDown:(id)button
{
    NSString *name = ((IMButton *) button).name;
    if ([name compare:@"two"] == 0) {
        [((IMButton *)button) setTexture:[SKTexture textureWithImageNamed:@"changePlayer2.png"]];
        [self runAction:[SKAction waitForDuration:0.1] completion:^{
            [self waitingForDevelop];
            [((IMButton *)button) setTexture:[SKTexture textureWithImageNamed:@"changePlayer1.png"]];
        }];
    }
    else if ([name compare:@"first"] == 0) {
        [((IMButton *)button) setTexture:[SKTexture textureWithImageNamed:@"select11.png"]];
        [self runAction:[SKAction waitForDuration:0.1] completion:^{
            [self showGameView];
        }];
    }
    else{
        [self waitingForDevelop];
    }
}

- (void) waitingForDevelop
{
    SKLabelNode *node = [SKLabelNode labelNodeWithText:@"Waiting For Develop!"];
    node.color = [SKColor blackColor];
    node.fontColor = [SKColor whiteColor];
    node.fontSize = 30;
    node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
    [self addChild:node];
    SKAction *wait = [SKAction waitForDuration:1];
    SKAction *miss = [SKAction removeFromParent];
    [node runAction:[SKAction sequence:@[wait, miss]]];
}

@end
