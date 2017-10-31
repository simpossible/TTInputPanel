//
//  TTInputBar.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTInputSource.h"

@protocol TTInputBarProtocol <NSObject>


@end

@interface TTInputBar : UIView

@property (nonatomic, strong) NSMutableArray<TTInputSource *> * sources;

@property (nonatomic, assign) TTInputBarLayoutType layoutType;

@property (nonatomic, weak) id<TTInputBarProtocol> delegate;

- (instancetype)initWithSources:(NSArray<TTInputSource *> *)sources;

- (void)setParameterWithJson:(NSDictionary *)json;

- (BOOL)haveFlexItem;

@end
