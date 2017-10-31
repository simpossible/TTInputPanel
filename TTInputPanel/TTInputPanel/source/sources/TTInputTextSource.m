//
//  TTInputTextSource.m
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInputTextSource.h"

@interface TTInputTextSource()

@end

@implementation TTInputTextSource

- (instancetype)initWithSource:(NSDictionary *)dic {
    if (self = [super initWithSource:dic]) {
        _sourceType = TTINPUTSOURCETYPETEXTINPUT;
        self.flex = TTInputLayoutFlexGreater;
        [self becomeListener];
    }
    return self;
}

- (void)dealSourceDic:(NSDictionary *)dic {
    [super dealSourceDic:dic];
}

- (void)genrateBarView {
       
    self.barView = [[UITextView alloc] init];
    self.barView.backgroundColor = [UIColor whiteColor];
}


- (void)becomeListener {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShowing:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHidding:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)resignListenr {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardShowing:(NSNotification *)notifi {
    
//    CGRect endFrame = [[notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
//
//    UIViewAnimationCurve animationCurve = [notifi.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
//    NSInteger animationCurveOption = (animationCurve << 16);
//
//    double animationDuration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//
//    if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {
//        [self.delegate toChangeSourceHeight:endFrame.size.height time:animationDuration animateOption:animationCurveOption];
//    }
}

- (void)keyboardHidding:(NSNotification *)notifi {
//
//    CGRect endFrame = [[notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
//
//    UIViewAnimationCurve animationCurve = [notifi.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
//    NSInteger animationCurveOption = (animationCurve << 16);
//
//    double animationDuration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
//    if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {
//        [self.delegate toChangeSourceHeight:endFrame.size.height time:animationDuration animateOption:animationCurveOption];
//    }
}


- (void)dealloc {
    [self resignListenr];
}

@end
