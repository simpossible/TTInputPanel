//
//  TTInputPanel.m
//  TTInputPanel
//
//  Created by simp on 2017/9/20.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanel.h"
#import "TTInputPanelBarItem.h"
#import "TTInputBarItem.h"
#import "TTInputTextSource.h"

@interface TTInputPanel ()<TTInputProtocol>

@property (nonatomic, strong) TTInput * input;

@property (nonatomic, strong) TTInputPanelBar * panelBar;

@property (nonatomic, strong) UIView * sourceContainerView;

@end

@implementation TTInputPanel

- (instancetype)initWithInput:(TTInput *)input {
    if (self = [super init]) {
        self.input = input;
        self.input.delegate = self;
    }
    [self initialUI];
    [self becomeListener];
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
#pragma mark - 设置代理

- (void)becomeListener {
  
}

#pragma mark - 高度变化
- (void)toChangeSourceHeight:(CGFloat)height time:(CGFloat)time animateOption:(UIViewAnimationOptions)options {
    
    __weak typeof(self)wself = self;
    [UIView animateWithDuration:time animations:^{
        [self  initialContainerViewWithHeight:height];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [wself showSourceView];
    }];
//    [UIView animateWithDuration:time delay:0.0 options:options animations:^{
//
//    } completion:^(BOOL finished) {
//
//    }];
    
}

#pragma mark - sourceview show

- (void)showSourceView {
    UIView *sourceView = self.input.focusSource.sourceView;
    if (sourceView) {
        [self.sourceContainerView addSubview:sourceView];
        [sourceView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.sourceContainerView.mas_bottom);
            make.left.equalTo(self.sourceContainerView.mas_left);
            make.right.equalTo(self.sourceContainerView.mas_right);
            make.height.equalTo(self.sourceContainerView.mas_height);
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.5 animations:^{
                [sourceView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(UIEdgeInsetsZero);
                }];
                [sourceView layoutIfNeeded];
            }];
        });
        
    }

}

- (void)toChangeBarHeigth:(CGFloat)height animateTime:(CGFloat)time {
    [UIView animateWithDuration:time delay:time options:0 animations:^{
        [self  initialContainerViewWithHeight:height];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)sourceToBecomeFocus:(id)source {
    
}

- (void)landingPanel {
        
}

#pragma mark - panelbaritemProtocol

- (void)itemFoucusChanged {
    
}

@end
