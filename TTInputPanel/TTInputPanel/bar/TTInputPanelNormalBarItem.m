//
//  TTInputPanelNormalBarItem.m
//  TTInputPanel
//
//  Created by simp on 2017/9/26.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelNormalBarItem.h"

@interface TTInputPanelNormalBarItem ()
@property (nonatomic, strong) UIImageView * icon;
@end

@implementation TTInputPanelNormalBarItem

- (void)initialUI {
    self.icon = [[UIImageView alloc] init];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    
//    if (self.inputItem.imgName) {
//        self.iconImage = [UIImage imageNamed:self.inputItem.imgName];
//        [self.icon setImage:self.iconImage];
//    }else {
//        if (self.inputItem.imgUrl) {
//        }
//    }
    
}

@end
