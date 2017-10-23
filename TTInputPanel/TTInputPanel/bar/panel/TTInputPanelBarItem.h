//
//  TTInputPanelBarlItem.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputBarItem.h"



@interface TTInputPanelBarItem : UIControl

@property (nonatomic, strong) TTInputSource *source;

- (instancetype)initWithSource:(TTInputSource *)source;

+ (instancetype)panelItemWithSource:(TTInputSource *)source;

/**降落*/
- (void)landing;

- (void)rise;

@end
