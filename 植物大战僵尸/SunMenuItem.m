//
//  SunMenuItem.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-1.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "SunMenuItem.h"

#define LABEL_FONT              @"Impact"
#define LABEL_FONT_COLOR        [SKColor blackColor]

#define SUN_LABEL_FONT_CHANGED_COLOR        [SKColor redColor]
#define SUN_LABEL_FONT_SIZE         25
#define SUN_LABEL_FONT_POSITION     CGPointMake(15, -10)
#define SUNMENUITEM_ZPOSITION       1

@implementation SunMenuItem
@synthesize sunValue;


+ (id) createSunMenuItemWithPoint: (CGPoint) point
{
    SunMenuItem *item = [SunMenuItem spriteNodeWithImageNamed:@"SunBack.png"];
    item.name = @"SunMenuItem";
    item.position = point;
    
    return item;
}

- (SKLabelNode *)label
{
    if (_label == nil) {
        _label = [SKLabelNode labelNodeWithFontNamed:LABEL_FONT];
        _label.fontColor = LABEL_FONT_COLOR;
        _label.fontSize = SUN_LABEL_FONT_SIZE;
        _label.position = SUN_LABEL_FONT_POSITION;
        _label.zPosition = SUNMENUITEM_ZPOSITION;
        [self addChild:_label];
    }
    
    return _label;
}

- (void) setSunValue:(int)value
{
    sunValue = value;
    [self.label setText:[NSString stringWithFormat:@"%d", sunValue]];
}

- (void) addScore: (int) score
{
    sunValue += score;
    [self.label setText:[NSString stringWithFormat:@"%d", sunValue]];
}

- (BOOL) canSubScore: (int) score
{
    if(sunValue - score >= 0)
        return YES;
    
    self.label.fontColor = SUN_LABEL_FONT_CHANGED_COLOR;
    SKAction *move1 = [SKAction moveBy:CGVectorMake(10, 0) duration:0.06];
    SKAction *move2 = [SKAction moveBy:CGVectorMake(-20, 0) duration:0.12];
    SKAction *move3 = [SKAction moveBy:CGVectorMake(10, 0) duration:0.06];
    SKAction *move = [SKAction sequence:@[move1, move2, move3]];
    [self.label runAction:[SKAction repeatAction:move count:2] completion:^{
        self.label.fontColor = [SKColor blackColor];
    }];
    return NO;
}

- (void) subScore:(int)score
{
    sunValue -= score;
    [self.label setText:[NSString stringWithFormat:@"%d", sunValue]];
}

@end
