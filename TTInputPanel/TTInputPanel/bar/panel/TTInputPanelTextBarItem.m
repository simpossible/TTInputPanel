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


- (instancetype)initWithSource:(TTInputSource *)source {
    if (self = [super initWithSource:source]) {
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    [self initialTextView];
}

- (void)initialTextView {
    self.textView = [[UITextView alloc] init];
    self.textView.delegate = self;
    [self addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    self.textView.delegate = self;
    self.textView.keyboardType = UIKeyboardTypeASCIICapable;
}



- (void)dealloc {
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return YES;
}


#pragma mark - operation

- (void)landing {
    [self.textView resignFirstResponder];
}

/**状态改变的情况下不用降落，收起键盘就行*/
- (void)itemFoucusWillChange {
        [self.textView resignFirstResponder];
}



#pragma mark textView-
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
