//
//  TTInputTextSource.m
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInputTextSource.h"

@interface TTInputTextSource()<UITextViewDelegate>

@property (nonatomic, strong) UIView * barView;

@property (nonatomic, strong) UIButton * placeHolderButton;

@property (nonatomic, strong) UITextView * textView;

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
       
    }
    return self;
}

- (void)dealSourceDic:(NSDictionary *)dic {
    [super dealSourceDic:dic];
}

- (void)initialUI {
    [super initialUI];
    [self becomeListener];
}

- (void)genrateBarView {
    
    UIView * barView = [[UIView alloc] init];
    
    self.barView = barView;
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor whiteColor];
    textView.delegate = self;
    self.textView = textView;
    
    [barView addSubview:textView];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    self.placeHolderButton = [[UIButton alloc] init];
    [self.barView addSubview:self.placeHolderButton];
    
    self.placeHolderButton.backgroundColor = [UIColor colorWithRed:0.65 green:0.65 blue:0.65 alpha:1];

    [self.placeHolderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    [self.placeHolderButton setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
    [self.placeHolderButton setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisVertical];
    
    [self.placeHolderButton setTitle:@"请输入消息…" forState:UIControlStateNormal];
    self.placeHolderButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    self.barView.layer.cornerRadius = 4;
    [self.placeHolderButton addTarget:self action:@selector(placeHolderButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.barView.layer.masksToBounds = YES;
}

- (void)placeHolderButtonClicked:(id)sender {
    BOOL shouldBegin =  [self textViewShouldBeginEditing:self.textView];
    if (shouldBegin) {
        [self.textView becomeFirstResponder];
    }
    [self.textView becomeFirstResponder];
//    self.placeHolderButton.hidden = YES;
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
        if (realHeight == 0) {
            _focusState = TTIInputSoureFocusStateNone;
        }
    }
  
}

- (void)setFocusState:(TTIInputSoureFocusState)focusState {

   
    if (focusState == TTIInputSoureFocusStateNone) {
        [self.textView resignFirstResponder];
    }else {
    }
    if (self.textView.text.length == 0) {
        self.placeHolderButton.hidden = (focusState == TTIInputSoureFocusStateFoucus);
    }else {
        self.placeHolderButton.hidden = YES;
    }
       _focusState = focusState;
    
}

- (void)disappearSource {
    self.focusState = TTIInputSoureFocusStateNone;
}

- (void)dealloc {
    [self resignListenr];
}


#pragma mark - item event

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (self.focusState != TTIInputSoureFocusStateFoucus) {
        BOOL canBeFocus = NO;
        if ([self.delegate respondsToSelector:@selector(source:canChangeStateTo:)]) {
            canBeFocus = [self.delegate source:self canChangeStateTo:(self.focusState + 1)%2];
            if (canBeFocus) {
                self.focusState = (self.focusState + 1)%2;
            }
        }
    }
    return  YES;
}

@end
