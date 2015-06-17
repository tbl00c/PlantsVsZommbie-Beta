//
//  IMButton.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-14.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "IMButton.h"

@implementation IMButton

+ (id) newButtonWithButtonName: (NSString *)name imageName:(NSString *)image
{
    IMButton *button = [IMButton spriteNodeWithImageNamed:image];
    button.name = name;
    button.userInteractionEnabled = YES;
    return button;    
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate IMButtonDown: self];
}

@end
