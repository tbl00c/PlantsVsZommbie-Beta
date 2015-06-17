//
//  LAButton.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-16.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "ButtonProtocol.h"
@interface LAButton : SKLabelNode

@property (nonatomic, strong) id <ButtonProtocol> delegate;

+ (id) newButtonWithButtonWithName:(NSString *)name title: (NSString *) title;
@end
