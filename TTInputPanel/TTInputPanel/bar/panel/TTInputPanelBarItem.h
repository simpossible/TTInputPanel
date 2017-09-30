//
//  TTInputPanelBarlItem.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputBarItem.h"

@interface TTInputPanelBarItem : UIControl

@property (nonatomic, strong) TTInputBarItem *barItem;

- (instancetype)initWithInputItem:(TTInputBarItem *)item;

+ (instancetype)panelItemWithBarItem:(TTInputBarItem *)item;

@end
