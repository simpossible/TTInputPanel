//
//  TTInputBar.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTInputBarItem.h"

@interface TTInputBar : NSObject

@property (nonatomic, strong) NSMutableArray<TTInputBarItem *> * items;

@property (nonatomic, assign) CGFloat barHeight;

- (instancetype)initWithBarItems:(NSArray *)array;

- (void)setParameterWithJson:(NSDictionary *)json;

@end
