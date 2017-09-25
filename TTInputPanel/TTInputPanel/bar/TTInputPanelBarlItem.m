//
//  TTInputPanelBarlItem.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelBarlItem.h"
#import "TTInputBarItem.h"

@interface TTInputPanelBarlItem ()

@property (nonatomic, strong) TTInputBarItem *inputItem;

@end

@implementation TTInputPanelBarlItem

- (instancetype)initWithInputItem:(TTInputBarItem *)item {
    if (self = [super init]) {
        self.inputItem = item;
    }
    return self;
}



@end
