//
//  Mediator.m
//  植物大战僵尸
//
//  Created by h1r0 on 14-11-3.
//  Copyright (c) 2014年 QDU. All rights reserved.
//

#import "Mediator.h"
#import "mainHeader.h"

static NSTimeInterval tm = 0;

@implementation Mediator

- (void) update: (NSTimeInterval)currentTime
{
    if (currentTime - tm >= MEDIATOR_UPDATE_TIME) {
        tm = currentTime;
        
    }
}

@end
