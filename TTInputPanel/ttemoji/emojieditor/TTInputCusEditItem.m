//
//  TTInputCusEditItem.m
//  TT
//
//  Created by simp on 2018/10/20.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTInputCusEditItem.h"

@implementation TTInputCusEditItem

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if ([self.editDelegate respondsToSelector:@selector(editStateChanged)]) {
        [self.editDelegate editStateChanged];
    }
}

- (void)loadItemImage {
    
}

@end
