//
//  IMButton.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-14.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ButtonProtocol.h"

@interface IMButton : SKSpriteNode

@property (nonatomic, strong) id <ButtonProtocol> delegate;

+ (id) newButtonWithButtonName: (NSString *)name imageName:(NSString *)image;

@end
