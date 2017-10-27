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



@protocol TTInputBarItemProtocol <NSObject>

- (void)itemFoucusChanged:(TTInputBarItem *)item;
- (void)itemFoucusWillChange;

@end


@interface TTInputBarItem : NSObject

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) UIEdgeInsets margin;

@property (nonatomic, copy) NSString * name;

/**是否是当前显示的焦点*/
@property (nonatomic, assign) BOOL isFoucus;

/**布局优先级*/
@property (nonatomic, assign) TTInputLayoutFlex flex;

@property (nonatomic, weak) id<TTInputBarItemProtocol> delegate;

- (instancetype)initWithJson:(NSDictionary *)json;

+ (instancetype)barItemWithJson:(NSDictionary *)json;

/**根据sourceType 生成barItem*/
+ (instancetype)barItemWithJson:(NSDictionary *)json andSourceType:(NSString *)type;


- (void)dealJson:(NSDictionary *)json;

@end
