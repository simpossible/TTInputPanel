//
//  TTInputPanelBar.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTInputBar.h"
#import "TTInputPanelBarItem.h"

@protocol TTinputPanelBarProtocol <NSObject>

- (void)toChangeBarHeight:(CGFloat)height;

@end

@interface TTInputPanelBar : UIView

@property (nonatomic, strong) NSMutableArray * panelItems;

- (instancetype)initWithBar:(TTInputBar *)bar;

@end
