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

FOUNDATION_EXTERN NSString * const TTInputName;

FOUNDATION_EXTERN NSString * const TTInputSources;




@interface TTInput : UIView

@property (nonatomic, strong) TTInputBar * inpurtBar;

@property (nonatomic, strong, readonly) NSMutableArray<TTInputSource *> * sources;

/**当前的焦点*/
@property (nonatomic, strong) TTInputSource * focusSource;

/**代理*/
@property (nonatomic, weak) id<TTInputProtocol> dataSource;

@property (nonatomic, assign) CGFloat barHeight;

- (instancetype)intiialFromJsonData:(NSData *)data;

+ (instancetype)inputFromJsonData:(NSData *)data;

- (instancetype)initWithDataSource:(id<TTInputProtocol>)dataSource;

- (void)landingPanel;

@end
