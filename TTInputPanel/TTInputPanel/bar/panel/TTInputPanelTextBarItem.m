//
//  TTInputPanelTextBarItem.m
//  TTInputPanel
//
//  Created by simp on 2017/9/26.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelTextBarItem.h"

@interface TTInputPanelTextBarItem ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView * textView;

@end

@implementation TTInputPanelTextBarItem


- (instancetype)initWithInputItem:(TTInputBarItem *)item {
    if (self = [super initWithInputItem:item]) {
        [self initialUI];
        [self becomeListener];
    }
    return self;
}

- (void)initialUI {
    [self initialTextView];
}

- (void)initialTextView {
    self.textView = [[UITextView alloc] init];
    [self addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.textView.delegate = self;
    self.textView.keyboardType = UIKeyboardTypeASCIICapable;
}

- (void)becomeListener {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShowing:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHidding:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)resignListenr {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardShowing:(NSNotification *)notifi {
    CGRect endFrame = [[notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    UIViewAnimationCurve animationCurve = [notifi.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSInteger animationCurveOption = (animationCurve << 16);
    
    double animationDuration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGFloat sHeight = [[UIScreen mainScreen] bounds].size.height;
    
    if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {
        [self.delegate toChangeSourceHeight:endFrame.size.height time:animationDuration animateOption:animationCurveOption];
    }
    
}

- (void)keyboardHidding:(NSNotification *)notifi {
    
    CGRect endFrame = [[notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
    
    UIViewAnimationCurve animationCurve = [notifi.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSInteger animationCurveOption = (animationCurve << 16);
    
    double animationDuration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {
        [self.delegate toChangeSourceHeight:0 time:animationDuration animateOption:animationCurveOption];
    }
}


- (void)dealloc {
    [self resignListenr];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    [self.textView resignFirstResponder];
    return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
