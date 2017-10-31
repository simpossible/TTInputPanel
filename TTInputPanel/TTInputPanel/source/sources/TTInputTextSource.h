//
//  TTInputTextSource.h
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInput.h"

@protocol TTInputTextSourceProtocol <TTInputSourceProtocol>

- (void)toChangeSourceHeight:(CGFloat)height time:(CGFloat)time animateOption:(UIViewAnimationOptions)options;

@end

@interface TTInputTextSource : TTInputSource

@property (nonatomic, weak) id <TTInputTextSourceProtocol> delegate;

@end
