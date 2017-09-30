//
//  TTInputPanelBarLayout.h
//  TTInputPanel
//
//  Created by simp on 2017/9/29.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTInputBarItem.h"
#import "TTInputPanelBar.h"

@interface TTInputPanelBarLayout : NSObject

- (void)layoutItems:(NSArray<TTInputBarItem *> *)items inBar:(TTInputPanelBar *)bar;


+ (instancetype)layoutForType:(TTInputBarLayoutType)type;

@end
