//
//  TTInputPanelTextBarItem.m
//  TTInputPanel
//
//  Created by simp on 2017/9/26.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelTextBarItem.h"

@interface TTInputPanelTextBarItem ()

@property (nonatomic, strong) UITextView * textView;

@end

@implementation TTInputPanelTextBarItem


- (instancetype)initWithInputItem:(TTInputBarItem *)item {
    if (self = [super initWithInputItem:item]) {
        [self initialUI];
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
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
