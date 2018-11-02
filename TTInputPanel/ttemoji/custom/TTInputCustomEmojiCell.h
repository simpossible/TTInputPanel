//
//  TTInputCustomEmojiCell.h
//  TT
//
//  Created by simp on 2018/10/19.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTInputNomalCell.h"

@interface TTInputCustomEmojiCell : TTInputNomalCell

@property (nonatomic, strong, readonly) UIActivityIndicatorView * indicataor;

- (void)initialIndicator;

@end
