//
//  GameViewController.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-10-30.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "GameViewController.h"
#import "RootScene.h"

@implementation GameViewController

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;

    skView.ignoresSiblingOrder = YES;
    RootScene *scene =  [RootScene sceneWithSize:self.view.frame.size];
    scene.scaleMode = SKSceneScaleModeAspectFit;

    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
