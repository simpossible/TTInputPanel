//
//  TTInputPanel.m
//  TTInputPanel
//
//  Created by simp on 2017/9/20.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanel.h"


@interface TTInputPanel ()

@property (nonatomic, strong) TTInput * input;

@property (nonatomic, strong) TTInputPanelBar * panelBar;

@property (nonatomic, strong) UIView * sourceContainerView;

@end

@implementation TTInputPanel

- (instancetype)initWithInput:(TTInput *)input {
    if (self = [super init]) {
        self.input = input;
    }
    [self initialUI];
    return self;
}


- (void)initialUI {
    [self initialBar];
    [self initialContainerView];
    self.backgroundColor = [UIColor yellowColor];
}

- (void)initialBar {
    self.panelBar = [[TTInputPanelBar alloc] initWithBar:self.input.inpurtBar];
    [self addSubview:self.panelBar];
    
    [self.panelBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(self.input.inpurtBar.barHeight);
    }];

//    [self mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.panelBar.mas_top);
//    }];
}

- (void)initialContainerView {
    self.sourceContainerView = [[UIView alloc] init];
    [self addSubview:self.sourceContainerView];
    
    [self.sourceContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.panelBar.mas_bottom);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.sourceContainerView.mas_bottom);
    }];
}

- (void)addToView:(UIView *)view {
    [self initialUI];
}

@end
