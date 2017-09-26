//
//  TTInputPanelDefine.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTInputSource.h"
#import "TTInputBarItem.h"

@class TTInputSource;
@class TTInputBarItem;

typedef NS_ENUM(NSUInteger,TTInputLayoutFlex) {
    TTInputLayoutFlexFix = 1000,
    TTInputLayoutFlexlow,
    TTInputLayoutFlexDefault,
    TTInputLayoutFlexHeight,
};


typedef BOOL (^TTInputPanelSourceIsValid)(TTInputSource *source);

typedef void (^TTInputPanelItemLayouted)(TTInputBarItem *item);
