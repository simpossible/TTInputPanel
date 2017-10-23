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

@interface TTInputPanelBarItem ()<TTInputBarItemProtocol>

@property (nonatomic, strong) UIImageView * icon;

@property (nonatomic, strong) UIImage * iconImage;

@property (nonatomic, strong) UIImage * selectedImage;

@end

@implementation TTInputPanelBarItem



- (instancetype)initWithSource:(TTInputSource *)source {
    if (self= [super init]) {
        self.source = source;
    }
    return self;
}

+(instancetype)panelItemWithSource:(TTInputSource *)source {
    if ([source.sourceType isEqualToString:TTINPUTSOURCETYPENORMAL]){
        return [[TTInputPanelNormalBarItem alloc] initWithSource:source];
    }else if ([source.sourceType isEqualToString:TTINPUTSOURCETYPETEXTINPUT]) {
        return [[TTInputPanelTextBarItem alloc] initWithSource:source];
    }
    return [[TTInputPanelBarItem alloc] initWithSource:source];
}


#pragma mark operation -

- (void)landing {
    
}

- (void)rise {
    
}

#pragma mark baritemProtocol -

- (void)itemFoucusChanged {
        [self rise];
}



@end
