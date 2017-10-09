//
//  TTInputPanel.m
//  TTInputPanel
//
//  Created by simp on 2017/9/20.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanel.h"
#import "TTInputPanelBarItem.h"

@interface TTInputPanel ()<TTInputPanelBarItemProtocol>

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
    
    [self initialContainerViewWithHeight:0];
    [self initialBar];
    self.panelBar.backgroundColor = [UIColor yellowColor];
}

- (void)initialBar {
    if (!self.panelBar) {
        self.panelBar = [[TTInputPanelBar alloc] initWithBar:self.input.inpurtBar];
        [self addSubview:self.panelBar];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.panelBar.mas_top);
        }];
    }
    
    [self.panelBar mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.height.mas_equalTo(self.input.inpurtBar.barHeight);
        make.bottom.equalTo(self.sourceContainerView.mas_top);
    }];
    
    self.panelBar.itemDelegate = self;
}

- (void)initialContainerViewWithHeight:(CGFloat)height {
    if (!self.sourceContainerView) {
        self.sourceContainerView = [[UIView alloc] init];
        [self addSubview:self.sourceContainerView];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.sourceContainerView.mas_bottom);
        }];
    }
    [self.sourceContainerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
    }];
 
    
    self.sourceContainerView.backgroundColor = [UIColor blueColor];
}


- (void)toChangeSourceHeight:(CGFloat)height time:(CGFloat)time animateOption:(UIViewAnimationOptions)options {
    
        [UIView animateWithDuration:time delay:0.0 options:0 animations:^{
            [self  initialContainerViewWithHeight:height];
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    
  
}


- (void)landingPanel {
        
}

@end
