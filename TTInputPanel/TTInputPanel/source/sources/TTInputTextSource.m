//
//  TTInputTextSource.m
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInputTextSource.h"

@interface TTInputTextSource()<UITextViewDelegate>

@property (nonatomic, strong) UITextView * barView;

@end

@implementation TTInputTextSource

@synthesize barView = _barView;

- (instancetype)initWithSource:(NSDictionary *)dic {
    if (self = [super initWithSource:dic]) {
       
        [self becomeListener];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        _sourceType = TTINPUTSOURCETYPETEXTINPUT;
        self.flex = TTInputLayoutFlexGreater;
        [self genrateBarView];
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
    
    self.barView.delegate = self;
}


- (void)becomeListener {
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShowing:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHidding:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)resignListenr {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardShowing:(NSNotification *)notifi {
    if (self.focusState == TTIInputSoureFocusStateFoucus) {
        CGRect endFrame = [[notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
        
        UIViewAnimationCurve animationCurve = [notifi.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        NSInteger animationCurveOption = (animationCurve << 16);
        
        double animationDuration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {
            [self.delegate toChangeSourceHeight:endFrame.size.height time:animationDuration animateOption:animationCurveOption];
        }
    }
}

- (void)keyboardHidding:(NSNotification *)notifi {
    
    if (self.focusState == TTIInputSoureFocusStateFoucus) {
        CGRect endFrame = [[notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
        
        UIViewAnimationCurve animationCurve = [notifi.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        NSInteger animationCurveOption = (animationCurve << 16);
        
        CGFloat sheight = [[UIScreen mainScreen] bounds].size.height;
        CGFloat realHeight = sheight - endFrame.origin.y;
        
        double animationDuration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
         if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {
            [self.delegate toChangeSourceHeight:realHeight time:animationDuration animateOption:animationCurveOption];
        }
        if (endFrame.size.height == 0) {
            _focusState = TTIInputSoureFocusStateNone;
        }
    }
  
}

- (void)setFocusState:(TTIInputSoureFocusState)focusState {

    if ([self.delegate respondsToSelector:@selector(source:willChangeStateTo:)]) {
        [self.delegate source:self willChangeStateTo:focusState];
    }
    if (_focusState != focusState) {
      
        if (focusState == TTIInputSoureFocusStateNone) {
           
        }else if(focusState == TTIInputSoureFocusStateFoucus) {
            [super setFocusState:focusState];
            [self.barView becomeFirstResponder];
        }        
    }
}

- (void)disappearSource {
   [self.barView resignFirstResponder];
}

- (void)dealloc {
    [self resignListenr];
}


#pragma mark - item event

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.focusState = TTIInputSoureFocusStateFoucus;
    return  YES;
}
@end
