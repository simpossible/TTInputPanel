//
//  TTInputNomalCell.m
//  Masonry
//
//  Created by simp on 2017/10/27.
//

#import "TTInputNomalCell.h"
#import "Masonry.h"

@interface TTInputNomalCell ()

@property (nonatomic, strong) UIImageView * img;

@end

@implementation TTInputNomalCell

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    [self initialImgView];
}

- (void)initialImgView {
    self.img = [[UIImageView alloc] init];
    [self.contentView addSubview:self.img];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
}

- (void)setItem:(TTInputSourceItem *)item {
    _item = item;
    self.img.image = item.itemImg;
}

@end
