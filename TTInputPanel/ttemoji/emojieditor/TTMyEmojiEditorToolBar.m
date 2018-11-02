//
//  TTMyEmojiEditorToolBar.m
//  TT
//
//  Created by simp on 2018/10/20.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTMyEmojiEditorToolBar.h"
#import <Masonry/Masonry.h>
#import "UIColor+TTColor_Generated.h"

@interface TTMyEmojiEditorToolBar()

@property (nonatomic, strong) UIControl * allSelectControl;

@property (nonatomic, strong) UIButton * deleteButton;

@property (nonatomic, strong) UIImageView * pointView;

@property (nonatomic, strong) UILabel * desLabel;

@end

@implementation TTMyEmojiEditorToolBar

- (instancetype)init {
    if (self = [super init]) {
        [self initialUI];
        self.backgroundColor = [UIColor TTGray5];
    }
    return self;
}


- (void)initialUI {
    [self initialAllSelectControl];
    [self initialDeleteButton];
}

- (void)initialAllSelectControl {
    self.allSelectControl = [[UIControl alloc] init];
    [self addSubview:self.allSelectControl];
    
    UIImageView * pointView = [[UIImageView alloc] init];
    [self.allSelectControl addSubview:pointView];
    
    [pointView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.allSelectControl.mas_left);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
        make.centerY.equalTo(self.allSelectControl.mas_centerY);
    }];
    pointView.backgroundColor = [UIColor TTWhite1];
    pointView.layer.cornerRadius = 9;
    self.pointView = pointView;
    
    UILabel * nameLabel = [[UILabel alloc] init];
    [self.allSelectControl addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(pointView.mas_right).offset(8);
        make.centerY.equalTo(self.allSelectControl.mas_centerY);
        make.height.mas_equalTo(20);
    }];
    self.desLabel = nameLabel;
    
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor TTGray2];
    
    [self.allSelectControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(16);
        make.height.mas_equalTo(28);
        make.right.equalTo(nameLabel.mas_right);
    }];
    nameLabel.text = @"全选";
    
    [self.allSelectControl addTarget:self action:@selector(allselectClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initialDeleteButton {
    self.deleteButton = [[UIButton alloc] init];
    [self addSubview:self.deleteButton];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-16);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(28);
    }];
    
    [self.deleteButton setTitle:@"删除已选表情" forState:UIControlStateNormal];
    [self.deleteButton setBackgroundColor:[UIColor TTRedMain]];
    self.deleteButton.layer.cornerRadius = 14;
    self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.deleteButton setContentEdgeInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    [self.deleteButton addTarget:self  action:@selector(toDelete) forControlEvents:UIControlEventTouchUpInside];
     self.deleteButton.alpha = 0.4;
}

- (void)allselectClicked:(id)sender {
    self.allselect = !self.allselect;
    if ([self.delegate respondsToSelector:@selector(barToSelectAll:)]) {
        [self.delegate barToSelectAll:self.allselect];
    }
}

- (void)setAllselect:(BOOL)allselect {
    _allselect = allselect;
    
    self.pointView.backgroundColor = [UIColor TTWhite1];
    self.pointView.image = allselect?[UIImage imageNamed:@"ic_emoji_selected"]:nil;
}

- (void)toDelete {
    if (self.deleteButton.alpha != 1) {
        return;
    }
    __weak typeof(self)wself = self;
//    TTAlertView *alertView = [[TTAlertView alloc] initWithTitle:nil message:@"确定删除所选表情?"];
//    [alertView addButtonWithTitle:@"取消" block:NULL];
//    [alertView addButtonWithTitle:@"确定" block:^{
//        if ([wself.delegate respondsToSelector:@selector(barToDelete)]) {
//            [wself.delegate barToDelete];
//        }
//    }];
//    [alertView show];
}

- (void)setDeleteCount:(NSInteger)count {
    if (count == 0) {
        [self.deleteButton setEnabled:NO];
        self.deleteButton.userInteractionEnabled = NO;
        self.deleteButton.alpha = 0.4;
        [self.deleteButton setTitle:@"删除已选表情" forState:UIControlStateNormal];
    }else {
        self.deleteButton.alpha = 1;
        self.deleteButton.userInteractionEnabled = YES;
        [self.deleteButton setEnabled:YES];
        [self.deleteButton setTitle:[NSString stringWithFormat:@"删除已选表情(%ld)",count] forState:UIControlStateNormal];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)addToView:(UIView *)view {
    [view addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left);
        make.right.equalTo(view.mas_right);
        make.height.mas_equalTo(48);
        make.top.equalTo(view.mas_bottom);
    }];
    
    self.alpha = 0;
}

- (void)show {
    UIView *view = self.superview;
    [UIView animateWithDuration:0.3 animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom).offset(-48);
        }];
        self.alpha = 1;
        [self.superview layoutIfNeeded];
    }];
}

- (void)dissmiss {
    UIView *view = self.superview;
    [UIView animateWithDuration:0.3 animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom);
        }];
        self.alpha = 0;
        [self.superview layoutIfNeeded];
    }];
}



@end
