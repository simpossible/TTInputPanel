//
//  TTInputNormalBarItem.h
//  TTInputPanel
//
//  Created by simp on 2017/10/31.
//

#import <UIKit/UIKit.h>
#import "TTInputSource.h"

@interface TTInputNormalBarItem : UIControl

@property (nonatomic, strong) UIImage * focusImage;

@property (nonatomic, strong) UIImage * unfocusImage;

/**改变显示的image*/
@property (nonatomic, assign) TTIInputSoureFocusState state;

@end
