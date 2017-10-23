//
//  TTInputPannelSourceMenu.h
//  Masonry
//
//  Created by simp on 2017/10/22.
//

#import <UIKit/UIKit.h>
#import "TTInputSource.h"

@interface TTInputPannelSourceMenu : UIView

@property (nonatomic, strong) TTInputSource *source;

- (instancetype)initWithSource:(TTInputSource *)source;

@end
