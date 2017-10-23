//
//  TTInputSourcePage.h
//  TTInputPanel
//
//  Created by simp on 2017/10/22.
//

#import <Foundation/Foundation.h>
#import "TTInputSourceItem.h"

@interface TTInputSourcePage : NSObject

@property (nonatomic, strong) NSArray<TTInputSourceItem *> *sourceItems;

- (instancetype)initFromDic:(NSDictionary *)dic;

@end
