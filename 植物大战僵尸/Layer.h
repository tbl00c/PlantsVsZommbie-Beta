//
//  Layer.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-7.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol LayerProtocal <NSObject>

@optional
+ (id) newLayerScene: (CGRect) rect;
- (void) showAction;

@end

@interface Layer : SKSpriteNode <LayerProtocal>



@end
