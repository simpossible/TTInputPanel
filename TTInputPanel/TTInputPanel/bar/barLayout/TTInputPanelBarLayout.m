//
//  TTInputPanelBarLayout.m
//  TTInputPanel
//
//  Created by simp on 2017/9/29.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelBarLayout.h"
#import "TTInputPanelBarSpaceLayout.h"

@implementation TTInputPanelBarLayout

- (void)layoutItems:(NSArray<TTInputBarItem *> *)items inBar:(TTInputPanelBar *)bar {
    
}


+ (instancetype)layoutForType:(TTInputBarLayoutType)type {
    switch (type) {
        case TTInputBarLayoutTypeSpace:
        return [[TTInputPanelBarSpaceLayout alloc] init];
        break;
        
        default:
        break;
    }
    return nil;
}

@end