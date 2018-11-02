//
//  TTInputCusEditItem.h
//  TT
//
//  Created by simp on 2018/10/20.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTInputCusSourceItem.h"

@protocol TTInputCusEditItemProtocol <NSObject>

- (void)editStateChanged;

@end

@interface TTInputCusEditItem : TTInputCusSourceItem

@property (nonatomic, weak) id<TTInputCusEditItemProtocol> editDelegate;

/**编辑*/
@property (nonatomic, assign) BOOL selected;

@end
