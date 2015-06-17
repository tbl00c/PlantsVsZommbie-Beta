//
//  GameScene.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-10-30.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "GameScene.h"
#import "RootScene.h"
#import <AVFoundation/AVFoundation.h>

@interface GameScene()
{    
    MenuController *menuController;
    LayerController *layerController;
    SunController *sunController;
    PlantController *plantController;
    BulletController *bulletController;
    ZombieController *zombieController;
    
    Plant *newPlant;
    __weak ShovelMenuItem *shovelMenuItem;
    __weak PlantMenuItem *choosePlantMenuItem;
    
    BOOL gameING;
    AVAudioPlayer *bgMusic;
}

@end


@implementation GameScene
@synthesize background;

- (void) didMoveToView:(SKView *)view
{
    SKSpriteNode *node = [SKSpriteNode spriteNodeWithImageNamed:@"Logo.jpg"];
    node.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    node.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:node];
    
    [self initLS];
    [self showScene];
}

#pragma mark - init

- (void) initLS     // 临时初始化
{
    gameING = NO;
    self.userInteractionEnabled = NO;
    
    // 中介者
    mediator = [[Mediator alloc] init];
    
    // 初始化背景和控制器
    
    // 背景
    background = [Background newBackgroundByValue:(enum BackGroundType)self.backgroundInfo rect:self.frame];
    mediator.background = background;

    // 菜单
    menuController = [MenuController createControllerWithRect:self.frame];
    mediator.menuController = menuController;
    
    [menuController addPlantMenuItemWithType:SunFlowerValue];
    [menuController addPlantMenuItemWithType:PeashooterValue];
    [menuController addPlantMenuItemWithType:WallNutValue];
    [menuController addPlantMenuItemWithType:ThreepeaterValue];
    [menuController addPlantMenuItemWithType:CherryBombValue];
    [menuController addPlantMenuItemWithType:SnowPeaValue];
    
    [menuController createShovelMenuItem];
    [menuController createSunMenuWithSunValue:5000];

 
    // 图层
    layerController = [LayerController createControllerWithRect:self.frame];
    
    // 阳光
    sunController = [SunController createControllerWithRect:self.frame];
    mediator.sunController = sunController;
    
    // 植物
    plantController = [PlantController createControllerWithRect:self.frame];
    mediator.plantController = plantController;
    
    // 子弹
    bulletController = [BulletController createControllerWithRect:self.frame];
    mediator.bulletController = bulletController;
    
    // 僵尸
    zombieController = [ZombieController createControllerWithRect:self.frame];
    zombieController.road = background.road;
    zombieController.startPoint = background.plantStartPoint;
    zombieController.plantSpaceSize = background.plantSpaceSize;
    mediator.zombieController = zombieController;
    
    // 消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(GameOverFailed:) name:@"GameOver_Failed" object:nil];
    
    bgMusic = [LayerController getGameMusic3];
}

- (void) showScene
{
    [self removeAllChildren];
    
    background.zPosition = BACKGROUND_ZPOSITION;
    [self addChild:background];
    
    menuController.zPosition = CONTROLLER_ZPOSITION;
    [self addChild:menuController];

    layerController.zPosition = LAYER_CONTROLLER_ZPOSITION;
    [self addChild:layerController];
    
    sunController.zPosition = SUN_CONTROLLER_ZPOSITION;
    [self addChild:sunController];
    
    plantController.zPosition = CONTROLLER_ZPOSITION;
    [self addChild:plantController];
    
    bulletController.zPosition = BULLET_CONTROLLER_ZPOSITION;
    [self addChild:bulletController];
    
    zombieController.zPosition = ZOMBIE_CONTROLLER_ZPOSITION;
    [self addChild:zombieController];
    
    [self gameStart];
    [bgMusic play];
}

- (void) gameStart
{
    [layerController showPrepareLayer];
    [self runAction:[SKAction waitForDuration:2] completion:^{
        gameING = YES;
        self.userInteractionEnabled = YES;
    }];
}

- (void) addChild:(SKNode *)node
{
    if ([node superclass] == [Bullet class]) {
        [bulletController addChild:node];
        return;
    }
    else if([node class] == [Sun class]){
        [sunController addChild:node];
        return;
    }
    
    [super addChild:node];
}

#pragma mark - controller

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event       // 触摸事件
{
    if (!gameING) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInNode:self];
    NSLog(@"GameScene: %f %f", point.x, point.y);
    
    NSArray *nodes = [self nodesAtPoint:point];
    for (id item in nodes) {
        if ([item class] == [Sun class]){       // 检测阳光
            [menuController addSunValue: ((Sun*)item).sunValue];
            ((Sun*)item).alpha = 0.9;
            [item removeFromParentAndAddScore];
            return;
        }
        else if([item class] == [ShovelMenuItem class]){    // 检测铲子
            if(newPlant != nil){
                newPlant = nil;
                [choosePlantMenuItem giveUpChoose];
            }
            
            shovelMenuItem.zPosition = SHOVELMENUITEM_ZPOSITION;
            shovelMenuItem = (ShovelMenuItem *) item;
            [shovelMenuItem userChoose];
            shovelMenuItem.zPosition = SHOVELMENUITEM_ZPOSITION;
            return;
        }
        else if([item class] == [PlantMenuItem class]){     // 检测植物菜单
            if (![((PlantMenuItem *)item) canPutPlant]) {         // 尚未初始化完毕
                return;
            }
            if (![menuController canSubSunValue: ((PlantMenuItem *)item).sunValue]) {     // 阳光不够，释放
                return;
            }
            if (shovelMenuItem != nil) {
                [shovelMenuItem giveUpChoose];
                shovelMenuItem = nil;
            }
            
            [(PlantMenuItem *)item userChoose];
            newPlant = [PlantController plantByValue:((PlantMenuItem *) item).value];
            choosePlantMenuItem = item;
            newPlant.name = @"Plant";
            newPlant.position = point;
            newPlant.fatherPoint = ((PlantMenuItem *) item).position;
            newPlant.zPosition = 10;
            return;
        }
    }
    
    if(newPlant != nil){            // 新植物
        if ([background canPutPlant:point]) {
            [newPlant removeFromParent];
            newPlant.position = [background putPlantAndGetRightPosition:point];
            [plantController addPlant:newPlant];
            [menuController subSunValue:newPlant.sunValue];
            [choosePlantMenuItem putPlantFinished];
            newPlant.zPosition = 11;
            newPlant = nil;
        }
    }
    else if (shovelMenuItem != nil) {            // 铲子
        if ([background hasPlant:point]){
            point = [background removePlantAndGetRightPosition:point];
            shovelMenuItem.zPosition = 0;
            [plantController removePlantAtPoint:point];
            [shovelMenuItem moveBackAfterActionInPoint: point];
            shovelMenuItem = nil;
        }
        
    }
}

#pragma mark - update

- (void) GameOverFailed: (NSNotification *) notification
{
    [bgMusic stop];
    gameING = NO;
    [layerController showGameOverFailedLayer];
 	   [[NSNotificationCenter defaultCenter] removeObserver:self name:notification.name object:nil];
    [self runAction:[SKAction waitForDuration:2] completion:^{

        RootScene *scene = [RootScene sceneWithSize:self.size];
        [self.view presentScene:scene];
    }];
}

#pragma mark - update

- (void) update:(NSTimeInterval)currentTime
{
    if (gameING) {
        [mediator update: currentTime];
        
        if (! background.Duck) {
            [sunController update: currentTime];
        }
        [plantController update:currentTime];
        
        [bulletController update:currentTime];
        
        [zombieController update:currentTime];
        
        [menuController update:currentTime];
    }
}


@end
