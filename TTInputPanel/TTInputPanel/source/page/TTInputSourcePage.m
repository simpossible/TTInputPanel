//
//  TTInputSourcePage.m
//  TTInputPanel
//
//  Created by simp on 2017/10/22.
//

#import "TTInputSourcePage.h"
#import "TTInputSourceItem.h"

@implementation TTInputSourcePage

- (instancetype)initFromDic:(NSDictionary *)dic {
    if(self = [super init]) {
        [self dealpageDic:dic];
    }
    return self;
}

- (void)dealpageDic:(NSDictionary *)dic {
    NSArray *items = [dic objectForKey:@"items"];

    NSMutableArray *ttItems = [NSMutableArray array];
    for (NSDictionary *itemDic in items) {
        TTInputSourceItem *sItem = [[TTInputSourceItem alloc] initFromDic:itemDic];
        [ttItems addObject:sItem];
    }
    self.sourceItems = ttItems;
}

@end
