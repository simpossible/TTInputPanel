//
//  TTinputMenuItem.m
//  TTInputPanel
//
//  Created by simp on 2017/11/1.
//

#import "TTinputMenuItem.h"
#import <Masonry/Masonry.h>

@interface TTinputMenuItem ()

@property (nonatomic, strong) UIView * contenView;

@end

@implementation TTinputMenuItem


- (instancetype)initWithWidth:(CGFloat)width flex:(TTInputLayoutFlex)flex content:(UIView *)contentView {
    if(self = [super init]) {
        self.width = width;
        self.flex =flex;
        self.contenView = contentView;
        [self initialUI];
    }
    return self;
}

- (instancetype)init {
    if(self = [super init]) {
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    [self initialContentView];
}

- (void)initialContentView {

    if (self.contenView) {
        [self addSubview:self.contenView];        
        [self.contenView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
}

- (void)reload {
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
