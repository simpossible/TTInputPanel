//
//  UITextView+Placeholder.h
//  TT
//
//  Created by wangyilong on 15/8/3.
//  Copyright (c) 2015年 yiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Placeholder)

@property (nonatomic, readonly) UILabel *placeholderLabel;

@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic, strong) UIColor *placeholderColor;

+ (UIColor *)defaultPlaceholderColor;

@end