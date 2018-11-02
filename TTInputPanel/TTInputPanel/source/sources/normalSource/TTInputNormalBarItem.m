//
//  TTInputNormalBarItem.m
//  TTInputPanel
//
//  Created by simp on 2017/10/31.
//

#import "TTInputNormalBarItem.h"
#import <Masonry/Masonry.h>

@interface TTInputNormalBarItem ()

@property (nonatomic, strong) UIImageView * focusView;

@end

@implementation TTInputNormalBarItem

- (instancetype)init {
    if(self = [super init]) {
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    [self initialFocusView];
}

- (void)initialFocusView {
    self.focusView = [[UIImageView alloc] init];
    [self addSubview:self.focusView];
    
    [self.focusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
}

- (void)setState:(TTIInputSoureFocusState)state {
    UIImage *image;
    if (state == TTIInputSoureFocusStateNone) {
        image = self.unfocusImage;
    }else if(state == TTIInputSoureFocusStateFoucus) {
        image = self.focusImage;
    }
    self.focusView.image = image;
}

@end
