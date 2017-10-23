//
//  TTInputPanelBar.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelBar.h"
#import "TTInputPanelBarItem.h"
#import "TTInputPanelBarLayout.h"
#import "TTInputPanelBarSpaceLayout.h"

@interface TTInputPanelBar()

@property (nonatomic, strong) TTInputBar * bar;

@property (nonatomic, strong) TTInputPanelBarLayout * layout;

@end

@implementation TTInputPanelBar

- (instancetype)initWithBar:(TTInputBar *)bar {
    if (self = [super init]) {
        self.bar = bar;
        self.panelItems = [NSMutableArray array];
    }
    return self;
}


- (void)initialUI {
    [self generateLayout];
    [self initialItems];
    self.backgroundColor = [UIColor yellowColor];
}


- (void)generateLayout {
    self.layout = [TTInputPanelBarLayout layoutForType:self.bar.layoutType];
}

- (void)initialItems {
    [self.layout layoutItemForSources:self.bar.sources inBar:self];
}


- (void)drawRect:(CGRect)rect {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self initialUI];
    });
}

- (void)addSubview:(UIView *)view {
    [super addSubview:view];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
