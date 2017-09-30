//
//  TTInputPanelBarlItem.m
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelBarItem.h"
#import "TTInputPanelTextBarItem.h"
#import "TTInputPanelNormalBarItem.h"
#import "TTInputTextBarItem.h"

@interface TTInputPanelBarItem ()

@property (nonatomic, strong) UIImageView * icon;

@property (nonatomic, strong) UIImage * iconImage;

@property (nonatomic, strong) UIImage * selectedImage;

@end

@implementation TTInputPanelBarItem

- (instancetype)initWithInputItem:(TTInputBarItem *)item {
    if (self = [super init]) {
        self.barItem = item;
    }
    self.backgroundColor = [UIColor orangeColor];
    return self;
}


+ (instancetype)panelItemWithBarItem:(TTInputBarItem *)item {

    Class itemClass = [item class];
    if (itemClass==[TTInputBarItem class]) {
        
        return [[TTInputPanelBarItem alloc] initWithInputItem:item];
        
    }else if(itemClass ==[TTInputNormalBarItem class]) {
        
        return [[TTInputPanelNormalBarItem alloc] initWithInputItem:item];

    }else if(itemClass == [TTInputTextBarItem class]) {
    
        return [[TTInputPanelTextBarItem alloc] initWithInputItem:item];
    }
    return nil;
    
}

@end
