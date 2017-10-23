//
//  TTInputSourceItem.m
//  TTInputPanel
//
//  Created by simp on 2017/10/22.
//

#import "TTInputSourceItem.h"

@interface TTInputSourceItem()
@property (nonatomic, copy) NSString * itemImgName;

@property (nonatomic, assign) NSInteger tag;

@end


@implementation TTInputSourceItem

- (instancetype)initFromDic:(NSDictionary *)dic {
    if (self = [super init]) {
         [self dealpageDic:dic];
    }
    return self;
}

- (void)dealpageDic:(NSDictionary *)dic {
    self.itemImg = [dic objectForKey:@"itemimg"];
    self.tag = [[dic objectForKey:@"tag"] integerValue];
}

@end
