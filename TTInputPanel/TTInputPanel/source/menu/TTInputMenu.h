//
//  TTInputMenu.h
//  TTInputPanel
//
//  Created by simp on 2017/11/1.
//

#import <UIKit/UIKit.h>
#import "TTinputMenuItem.h"

@interface TTInputMenu : UIView

- (instancetype)initWithItems:(NSArray<TTinputMenuItem *> *)items;

@end
