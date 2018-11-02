//
//  TTInputTextSource.m
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInputTextSource.h"
#import <Masonry/Masonry.h>
#import "UIColor+TTColor_Generated.h"
#import "UITextView+Placeholder.h"

@interface TTInputTextSource()<UITextViewDelegate>

@property (nonatomic, strong) UIView * barView;

@property (nonatomic, strong) UIButton * placeHolderButton;

@property (nonatomic, strong) UITextView * textView;

@property (nonatomic, weak) id<TTInputTextSourceProtocol> datasouce;

@property (nonatomic, assign) CGFloat lastHeight;

@property (nonatomic, strong) UIView * backgroundview;

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
    self.lastHeight = self.barItemSize.height;
    [super initialUI];
    [self becomeListener];
}

- (void)genrateBarView {
    
    UIView * barView = [[UIView alloc] init];
    
    self.barView = barView;
    UITextView *textView = [[UITextView alloc] init];
    textView.backgroundColor = [UIColor whiteColor];
    textView.delegate = self;
    [self.barView addSubview:textView];
    textView.backgroundColor = [UIColor TTGray4];
    self.textView = textView;
    self.textView.font = [UIFont systemFontOfSize:16];
    textView.placeholder = @"请输入消息...";
    
    self.textView.backgroundColor = [UIColor TTGray4];
    self.textView.layer.cornerRadius = 4;
    self.textView.layer.masksToBounds = YES;
    [self.barView addSubview:self.backgroundview];
    
    
    [self.textView setContentCompressionResistancePriority:249 forAxis:UILayoutConstraintAxisVertical];

    textView.textContainerInset = UIEdgeInsetsMake(8, 8, 5, 8);
    textView.scrollIndicatorInsets = UIEdgeInsetsMake(8, 8, 5, 8);
    textView.scrollsToTop = NO;
    textView.returnKeyType = UIReturnKeySend;
    self.textView = textView;
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
    
//    self.placeHolderButton = [[UIButton alloc] init];
//    [self.barView addSubview:self.placeHolderButton];
//
//
//    self.placeHolderButton.backgroundColor = [UIColor TTGray4];
//
//    [self.placeHolderButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(UIEdgeInsetsZero);
//    }];
//    [self.placeHolderButton setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisHorizontal];
//    [self.placeHolderButton setContentHuggingPriority:249 forAxis:UILayoutConstraintAxisVertical];
//
//    [self.placeHolderButton setTitle:@"请输入消息…" forState:UIControlStateNormal];
//    self.placeHolderButton.titleLabel.font = [UIFont systemFontOfSize:16];
//    self.placeHolderButton.titleLabel.textAlignment = NSTextAlignmentLeft;
//    [self.placeHolderButton setTitleColor:[UIColor TTGray2] forState:UIControlStateNormal];
//
//    self.barView.layer.cornerRadius = 4;
//    [self.placeHolderButton addTarget:self action:@selector(placeHolderButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
//    self.barView.layer.masksToBounds = YES;
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
    [self.textView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
    [self.textView addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:NULL];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShowing:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHidding:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)resignListenr {
     [self.textView removeObserver:self forKeyPath:@"contentSize"];
    [self.textView removeObserver:self forKeyPath:@"bounds"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardShowing:(NSNotification *)notifi {
    CGFloat iphonexBottomHeight = 0;
    if ([self.datasouce respondsToSelector:@selector(iphonexBottomView)]) {
        UIView *view = [self.datasouce iphonexBottomView];
        iphonexBottomHeight = CGRectGetHeight(view.bounds);
    }
    
    if (self.focusState == TTIInputSoureFocusStateFoucus) {
        CGRect endFrame = [[notifi.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue];
        
        UIViewAnimationCurve animationCurve = [notifi.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
        NSInteger animationCurveOption = (animationCurve << 16);
        
        double animationDuration = [notifi.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        if ([self.delegate respondsToSelector:@selector(toChangeSourceHeight:time:animateOption:)]) {
            [self.delegate toChangeSourceHeight:endFrame.size.height-iphonexBottomHeight time:animationDuration animateOption:animationCurveOption];
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

   
    _focusState = focusState;
    [self textViewDidChanged];
    if (focusState == TTIInputSoureFocusStateNone) {
        [self.textView resignFirstResponder];
    }else {
    }
    if (self.textView.text.length == 0) {
        self.backgroundview.hidden = (focusState == TTIInputSoureFocusStateFoucus);
    }else {
        self.backgroundview.hidden = YES;
    }
    
}

- (void)disappearSource {
    [self.textView resignFirstResponder];
//    self.focusState = TTIInputSoureFocusStateNone;    
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



- (void)textViewDidChange:(UITextView *)textView {
    if (textView.attributedText.length != 0) {
        self.placeHolderButton.hidden = YES;
    }
    [self dealForTextSizeChange:textView];
}

- (void)textViewDidChanged {
    [self textViewDidChange:self.textView];
}

- (void)dealForTextSizeChange:(UITextView *)textView {
    CGSize contetnSize = textView.contentSize;
    CGFloat height = contetnSize.height;
    if (height < self.barItemSize.height) {
        height = self.barItemSize.height;
    }
    if (height > 84) {
        height = 84;
    }
    if (self.lastHeight != height) {

        [self reportHeight:height from:self.lastHeight];
        self.lastHeight = height;
        [self.barView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        [self.barView.superview layoutIfNeeded];
        self.textView.attributedText = self.textView.attributedText;
//        [self scrollInputTextViewToBottom];
    }
   
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
   

    if ([text isEqualToString:@"\n"]) {
        
        //在这里做控制
        if ([self.datasouce respondsToSelector:@selector(textSourceEndEdit:)]) {
            [self.datasouce textSourceEndEdit:self];
        }
        return NO;
        
    }else {
        
        if ([self.datasouce respondsToSelector:@selector(textView:willTextInRange:replacementText:)]) {
            [self.datasouce textView:textView willTextInRange:range replacementText:text];
        }
        if (text.length != 0) {
            self.placeHolderButton.hidden = YES;
        }
        
    }
    
    return YES;
    return YES;
}

- (void)dissMissPlaceHolder {
    self.placeHolderButton.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
  
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField

{
    return YES;
    
}

- (void)becomeFoucus {
    BOOL canBeFocus = NO;
    if ([self.delegate respondsToSelector:@selector(source:canChangeStateTo:)]) {
        canBeFocus = [self.delegate source:self canChangeStateTo:TTIInputSoureFocusStateFoucus];
        if (canBeFocus) {
            self.focusState = TTIInputSoureFocusStateFoucus;
        }
    }
    [self.textView becomeFirstResponder];
}

- (void)barItemToDefault {
    [self reportHeight:self.barItemSize.height from:self.lastHeight];
    [self.barView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.barItemSize.height);
    }];
}

- (void)reportHeight:(CGFloat)height from:(CGFloat)old {
    if ([self.delegate respondsToSelector:@selector(barHeightWillChangeTo:from:)]) {
        [self.delegate barHeightWillChangeTo:height from:old];
    }
}

- (void)barItemRecover {
    [self reportHeight:self.lastHeight from:CGRectGetHeight(self.barView.bounds)];
    [self.barView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.lastHeight);
    }];
}

- (void)scrollInputTextViewToBottom {
    UITextView *textView = self.textView;
    CGPoint contentOffsetToShowLastLine = CGPointMake(0.0f, textView.contentSize.height - CGRectGetHeight(textView.bounds));
    //    NSLog(@"scrollInputTextViewToBottom %f", contentOffsetToShowLastLine.y);
    if (contentOffsetToShowLastLine.y > 0) {
        textView.contentOffset = contentOffsetToShowLastLine;
    } else {
        textView.contentOffset = CGPointMake(0, 0);
    }
//    [UIView animateWithDuration:0.3
//                          delay:0.0
//                        options:UIViewAnimationOptionCurveEaseInOut
//                     animations:^{
//
//                     } completion:NULL];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
#define MAX_INPUTVIEW_HEIGHT 100
    
    
    // 注意此回调有时执行很诡异，有时size其实没变但是会连续给两个这个回调，一次变小一次变大最终抵消（通常是中文输入法delete候选拼音的时候）
    // 导致下面代码有些特殊处理
    
    // 注意回调这里的时候，self.inputTextView.contentSize这个值已经是new的值
    if (object == self.textView && [keyPath isEqualToString:@"bounds"]) {
             
        [self scrollInputTextViewToBottom];
    }
}


@end
