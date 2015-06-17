//
//  ButtonProtocol.h
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-14.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ButtonProtocol <NSObject>

- (void) IMButtonDown: (id) button;
- (void) LAButtonDown: (id) button;
@end
