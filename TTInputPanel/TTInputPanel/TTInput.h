//
//  TTInput.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTInputBar.h"
#import "TTInputSource.h"
#import "TTInputPanelDefine.h"
#import "TTinputMenuItem.h"


FOUNDATION_EXTERN NSString * const TTInputName;

FOUNDATION_EXTERN NSString * const TTInputSources;




@interface TTInput : UIView

@property (nonatomic, strong) TTInputBar * inpurtBar;

@property (nonatomic, strong, readonly) NSMutableArray<TTInputSource *> * sources;

/**当前的焦点*/
@property (nonatomic, strong) TTInputSource * focusSource;

/**代理*/
@property (nonatomic, weak) id<TTInputProtocol> dataSource;

/**是否需要监听高度变化事件*/
@property (nonatomic, assign) BOOL shouldObserveHeightChange;

@property (nonatomic, assign) CGFloat barHeight;

/**是否已经收起*/
@property (nonatomic, assign, readonly) BOOL islanded;

/**从json 初始化的功能 先放弃。可配置性太高*/
- (instancetype)intiialFromJsonData:(NSData *)data;

+ (instancetype)inputFromJsonData:(NSData *)data;

- (instancetype)initWithDataSource:(id<TTInputProtocol>)dataSource;

- (void)landingPanel;

- (CGFloat)realBarHeight;

@end
