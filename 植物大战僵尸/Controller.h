//
//  Controller.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-3.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "mainHeader.h"

@protocol ControllerProtocol

@optional;
+ (id) createControllerWithRect: (CGRect) rect;
- (void) update:(NSTimeInterval)currentTime;

@end




@interface Controller: SKSpriteNode <ControllerProtocol>
{
    NSTimeInterval tm;
    int touchMark;
}

@property CGRect mainRect;



@end
