//
//  TTInputPanel.m
//  TTInputPanel
//
//  Created by simp on 2017/9/20.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanel.h"

@interface TTInputPanel ()

@property (nonatomic, strong) TTInput * input;

@end

@implementation TTInputPanel

- (instancetype)initWithInput:(TTInput *)input {
    if (self = [super init]) {
        self.input = input;
    }
    return self;
}

- (void)initialUI {
    
}

- (void)initialBar {
    
}

- (void)initialContainerView {
    
}

@end
