//
//  TTInputBarItem.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTInputPanelDefine.h"

FOUNDATION_EXTERN NSString * const TTInputBarFlex;

FOUNDATION_EXTERN NSString * const TTInputBarName;

FOUNDATION_EXTERN NSString * const TTInputBarMargin;

FOUNDATION_EXTERN NSString * const TTInputBarMarginLeft;

FOUNDATION_EXTERN NSString * const TTInputBarMarginRight;

FOUNDATION_EXTERN NSString * const TTInputBarMarginTop;

FOUNDATION_EXTERN NSString * const TTInputBarMarginBottom;



@interface TTInputBarItem : NSObject

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) UIEdgeInsets margin;

@property (nonatomic, copy) NSString * name;

/**布局优先级*/
@property (nonatomic, assign) TTInputLayoutFlex flex;


+ (instancetype)barItemWithJson:(NSDictionary *)json;

@end
