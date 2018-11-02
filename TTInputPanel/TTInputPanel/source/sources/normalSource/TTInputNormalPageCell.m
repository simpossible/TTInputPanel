//
//  TTInputNormalPageCell.m
//  TTInputPanel
//
//  Created by simp on 2017/11/1.
//

#import "TTInputNormalPageCell.h"
#import "TTInputSourcePage.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface TTInputNormalPageCell ()<TTInputSourcePageProtocol>

@property (nonatomic, strong) UIImageView * img;

@property (nonatomic, strong) UIView * bgView;


@end

@implementation TTInputNormalPageCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initialUI];
    }
    return self;
}

- (void)initialUI {
    [self initialBgView];
    [self initialImageView];
//    [self initialLines];
    self.backgroundColor = [UIColor clearColor];
}

- (void)initialImageView {
    self.img = [[UIImageView alloc] init];
    [self addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(26);
        make.height.mas_equalTo(26);
    }];
    self.img.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)initialBgView {
    self.bgView = [[UIView alloc] init];
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(36);
    }];
    self.bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.05];
    self.bgView.alpha = 0;
    self.bgView.layer.cornerRadius = 18;
}

- (void)initialLines {
    UIImageView * leftLine = [[UIImageView alloc] init];
    UIImageView * rightLine = [[UIImageView alloc] init];
    
    leftLine.image = [UIImage imageNamed:@"WeChatOutKeypadLineVertical_dark"];
    rightLine.image = [UIImage imageNamed:@"WeChatOutKeypadLineVertical_dark"];
    
    [self addSubview: leftLine];
    [self addSubview:rightLine];
    
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(0.5);
        make.height.equalTo(self.mas_height).multipliedBy(0.8);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(0.5);
        make.height.equalTo(self.mas_height).multipliedBy(0.8);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
}


- (void)setPage:(TTInputSourcePage *)page {
    _page = page;
        

    if (page.pageIcon) {
        self.img.image = page.pageIcon;
    }else if (page.iconUrl.length != 0 && page.iconUrl) {
        [self.img sd_setImageWithURL:[NSURL URLWithString:page.iconUrl]];
    }
    
    if (page.iconImgSize.width * page.iconImgSize.height != 0) {
        [self.img mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(page.iconImgSize.width);
            make.height.mas_equalTo(page.iconImgSize.height);
        }];
    }
    
    [self pageSelectedChanged];    
    page.delegate = self;
}

- (void)pageSelectedChanged {
    if (self.page.selected) {
//        self.backgroundColor = [UIColor colorWithRed:246.0f/255 green:246.0f/255 blue:248.0f/255 alpha:1];
        self.bgView.alpha = 1;
    }else {
//        self.backgroundColor = [UIColor whiteColor];
        self.bgView.alpha = 0;
    }
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];    
    
}

@end
