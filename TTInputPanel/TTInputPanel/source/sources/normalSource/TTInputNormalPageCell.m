//
//  TTInputNormalPageCell.m
//  TTInputPanel
//
//  Created by simp on 2017/11/1.
//

#import "TTInputNormalPageCell.h"

@interface TTInputNormalPageCell ()<TTInputSourcePageProtocol>

@property (nonatomic, strong) UIImageView * img;

@end

@implementation TTInputNormalPageCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    self.img = [[UIImageView alloc] init];
    [self addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
    }];
}


- (void)setPage:(TTInputSourcePage *)page {
    _page = page;
    self.img.image = page.pageIcon;
    
    [self pageSelectedChanged];    
    page.delegate = self;
}

- (void)pageSelectedChanged {
    if (self.page.selected) {
        self.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:248.0f/255 alpha:1];
    }else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

@end
