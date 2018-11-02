//
//  TTInputTextSource.h
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInput.h"
@class TTInputTextSource;


@protocol TTInputTextSourceProtocol <TTInputSourceProtocol>

/**完成编辑后*/
- (void)textSourceEndEdit:(TTInputSource *)source;;

- (void)textView:(UITextView *)textView willTextInRange:(NSRange)range replacementText:(NSString *)text;

@end

@interface TTInputTextSource : TTInputSource

@property (nonatomic, strong, readonly) UITextView * textView;

- (void)dissMissPlaceHolder;

- (void)barItemRecover;

- (void)textViewDidChanged;

@end
