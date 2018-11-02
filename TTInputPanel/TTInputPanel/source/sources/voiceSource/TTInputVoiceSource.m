//
//  TTInputVoiceSource.m
//  TTInputPanel
//
//  Created by simp on 2017/11/5.
//

#import "TTInputVoiceSource.h"

@implementation TTInputVoiceSource

- (void)setFocusState:(TTIInputSoureFocusState)focusState {
    [super setFocusState:focusState];
    if (focusState == TTIInputSoureFocusStateFoucus) {
        self.voiceButton.hidden = NO;
    }else {
        self.voiceButton.hidden = YES;
    }
}

@end
