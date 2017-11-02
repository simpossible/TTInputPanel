//
//  TTInputSource.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTInputSourcePage.h"
#import "TTInputPanelDefine.h"

typedef NS_ENUM(NSUInteger, TTIInputSoureFocusState) {
    TTIInputSoureFocusStateNone,
    TTIInputSoureFocusStateFoucus,
};

@class TTInputBarItem;
@class TTInputSource;
@protocol TTInputSourceProtocol  <NSObject>

- (void)toChangeBarHeigth:(CGFloat)height animateTime:(CGFloat)time;

- (void)toChangeSourceHeight:(CGFloat)height time:(CGFloat)time animateOption:(UIViewAnimationOptions)options;


- (void)focusWillChangeForSource:(TTInputSource *)source;
- (void)foucusChangedForSource:(TTInputSource *)soure;

- (void)source:(TTInputSource *)source willChangeStateTo:(TTIInputSoureFocusState)state;

- (BOOL)source:(TTInputSource *)source canChangeStateTo:(TTIInputSoureFocusState)state;

@end



@interface TTInputSource : NSObject {
    @protected
    NSString * _sourceType;
    TTIInputSoureFocusState _focusState;
}

@property (nonatomic, copy, readonly) NSString *sourceType;

/**对source 的tag*/
@property (nonatomic, copy) NSString * tag;

@property (nonatomic, weak) id<TTInputSourceProtocol> delegate;

@property (nonatomic, assign) TTIInputSoureFocusState focusState;

/**sourceView*/
@property (nonatomic, strong) UIView * sourceView;

/**barItem-view*/
@property (nonatomic, strong) UIView * barView;

/**布局优先级*/
@property (nonatomic, assign) TTInputLayoutFlex flex;

@property (nonatomic, assign) UIEdgeInsets barItemMargin;

@property (nonatomic, assign) CGSize barItemSize;

@property (nonatomic, weak) id<TTInputProtocol> datasouce;

/**处于焦点的时候的高度*/
@property (nonatomic, assign) CGFloat foucesHeight;

- (instancetype)initWithSource:(NSDictionary *)dic;

/**处理字典中的字段*/
- (void)dealSourceDic:(NSDictionary *)dic;

+ (TTInputSource *)sourcesFromDic:(NSDictionary *)sourceDic;

+ (TTInputSource *)normalSource;

+ (TTInputSource *)textInputSource;

- (void)disappearSource;




@end
