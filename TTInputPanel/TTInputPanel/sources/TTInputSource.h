//
//  TTInputSource.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTInputBarItem.h"

@class TTInputBarItem;

@interface TTInputSource : NSObject

@property (nonatomic, strong) TTInputBarItem * baritem;


+ (TTInputSource *)sourcesFromDic:(NSDictionary *)sourceDic;

@end
