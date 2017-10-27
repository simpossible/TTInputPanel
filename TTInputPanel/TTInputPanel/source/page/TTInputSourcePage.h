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

@property (nonatomic, strong) UIView * pageView;

/**每个pagecollectioncell 的margin*/
@property (nonatomic, assign) UIEdgeInsets margin;

/**行间距*/
@property (nonatomic, assign) CGFloat lineSpace;

/**默认的item 大小*/
@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) UIEdgeInsets itemMargin;

- (instancetype)initFromDic:(NSDictionary *)dic;

@end
