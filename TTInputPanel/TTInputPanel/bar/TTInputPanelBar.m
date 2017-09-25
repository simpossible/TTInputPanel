//
//  TTInputPanelBar.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelBar.h"
#import "TTInputPanelBarlItem.h"

@interface TTInputPanelBar()

@property (nonatomic, strong) TTInputBar * bar;

@end

@implementation TTInputPanelBar

- (instancetype)initWithBar:(TTInputBar *)bar {
    if (self = [super init]) {
        self.bar = bar;
        [self initialItems];
    }
    return self;
}


- (void)initialUI {
    [self initialItems];
}

- (void)initialItems {
    TTInputPanelBarlItem *lastPanelItem = nil;
    TTInputBarItem *lastInputItem = nil;
    for (TTInputBarItem *item in self.bar.items) {
        TTInputPanelBarlItem *panelItem = [[TTInputPanelBarlItem alloc] initWithInputItem:item];
        [self addSubview:panelItem];
        [panelItem mas_makeConstraints:^(MASConstraintMaker *make) {
            lastInputItem == nil?make.left.equalTo(self.mas_left).offset(item.margin.left):make.left.equalTo(lastPanelItem.mas_right).offset(item.margin.left+lastInputItem.margin.right);
            make.top.equalTo(self.mas_top).offset(item.margin.top);
            make.height.mas_equalTo(item.height);
            make.width.mas_equalTo(item.width);
        }];
        lastPanelItem = panelItem;
        lastInputItem = item;
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
