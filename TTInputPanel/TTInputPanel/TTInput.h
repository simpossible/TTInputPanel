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

FOUNDATION_EXTERN NSString * const TTInputName;

FOUNDATION_EXTERN NSString * const TTInputSources;

@protocol TTInputProtocol <NSObject>


@end

@interface TTInput : UIView

@property (nonatomic, strong) TTInputBar * inpurtBar;

@property (nonatomic, strong) NSMutableArray<TTInputSource *> * sources;

/**当前的焦点*/
@property (nonatomic, strong) TTInputSource * focusSource;

/**代理*/
@property (nonatomic, weak) id<TTInputProtocol> delegate;

@property (nonatomic, assign) CGFloat barHeight;

- (instancetype)intiialFromJsonData:(NSData *)data;

+ (instancetype)inputFromJsonData:(NSData *)data;


@end
