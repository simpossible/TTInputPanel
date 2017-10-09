//
//  TTInputPanelBarlItem.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputBarItem.h"

@protocol TTInputPanelBarItemProtocol <NSObject>

- (void)toChangeBarHeigth:(CGFloat)height;

- (void)toChangeSourceHeight:(CGFloat)height;

- (void)toChangeSourceHeight:(CGFloat)height time:(CGFloat)time animateOption:(UIViewAnimationOptions)options;

@end


@interface TTInputPanelBarItem : UIControl

/**界面高度的各种变化事件*/
@property (nonatomic, weak) id<TTInputPanelBarItemProtocol> delegate;

@property (nonatomic, strong) TTInputBarItem *barItem;

- (instancetype)initWithInputItem:(TTInputBarItem *)item;

+ (instancetype)panelItemWithBarItem:(TTInputBarItem *)item;

@end
