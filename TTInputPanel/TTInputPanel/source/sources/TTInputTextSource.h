//
//  TTInputTextSource.h
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInput.h"

@protocol TTInputTextSourceProtocol <TTInputSourceProtocol>



@end

@interface TTInputTextSource : TTInputSource

@property (nonatomic, weak) id <TTInputTextSourceProtocol> delegate;

@end
