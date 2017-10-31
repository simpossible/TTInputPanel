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


/**
 当前是否升起
 */
@property (nonatomic, assign, readonly) TTInputPanelState state;


- (instancetype)initWithInput:(TTInput *)input;

///**收起panel*/
//- (void)landingPanel;

@end
