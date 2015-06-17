//
//  LAButton.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-16.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "LAButton.h"

@interface LAButton()

@end

@implementation LAButton

+ (id) newButtonWithButtonWithName:(NSString *)name title: (NSString *) title
{
    LAButton *button = [LAButton labelNodeWithText:title];
    button.name = name;
    button.userInteractionEnabled = YES;
    return button;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.fontColor = [SKColor blueColor];
    [self.delegate LAButtonDown: self];
}

@end
