//
//  TTInputPanel.h
//  TTInputPanel
//
//  Created by simp on 2017/9/20.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTInput.h"

@interface TTInputPanel : UIView

- (instancetype)initWithInput:(TTInput *)input;

//这里需要父视图来进行布局
//- (void)addToView:(UIView *)view;

@end
