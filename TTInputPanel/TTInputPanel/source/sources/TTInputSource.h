//
//  TTInputSource.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTInputBarItem.h"
#import "TTInputSourcePage.h"

@class TTInputBarItem;
@class TTInputSource;
@protocol TTInputSourceProtocol  <NSObject>

- (void)toChangeBarHeigth:(CGFloat)height animateTime:(CGFloat)time;


- (void)focusWillChangeForSource:(TTInputSource *)source;
- (void)foucusChangedForSource:(TTInputSource *)soure;

@end

typedef NS_ENUM(NSUInteger, TTIInputSoureFocusState) {
    TTIInputSoureFocusStateNone,
    TTIInputSoureFocusStateFoucus,
};

@interface TTInputSource : NSObject {
    @protected
    NSString * _sourceType;
    TTIInputSoureFocusState _focusState;
}

@property (nonatomic, copy, readonly) NSString *sourceType;

@property (nonatomic, strong) TTInputBarItem * baritem;

@property (nonatomic, strong) NSArray<TTInputSourcePage *> * pages;

@property (nonatomic, weak) id<TTInputSourceProtocol> delegate;

@property (nonatomic, assign) TTIInputSoureFocusState focusState;

/**sourceView*/
@property (nonatomic, strong) UIView * sourceView;

/**处于焦点的时候的高度*/
@property (nonatomic, assign) CGFloat foucesHeight;

- (instancetype)initWithSource:(NSDictionary *)dic;

/**处理字典中的字段*/
- (void)dealSourceDic:(NSDictionary *)dic;

+ (TTInputSource *)sourcesFromDic:(NSDictionary *)sourceDic;

@end
