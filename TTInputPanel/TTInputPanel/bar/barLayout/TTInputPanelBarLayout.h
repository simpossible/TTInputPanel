//
//  TTInputPanelBarLayout.h
//  TTInputPanel
//
//  Created by simp on 2017/9/29.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTInputBar.h"

@interface TTInputPanelBarLayout : NSObject

- (void)layoutItemForSources:(NSArray<TTInputSource *> *)sources inBar:(TTInputBar *)bar;


+ (instancetype)layoutForType:(TTInputBarLayoutType)type;

@end
