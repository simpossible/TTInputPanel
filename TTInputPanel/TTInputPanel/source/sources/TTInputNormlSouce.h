//
//  TTInputNormlSouce.h
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import <TTInputPanel/TTInputPanel.h>

@protocol TTInputNorlmalSourceProtocol <TTInputSourceProtocol>



@end

@interface TTInputNormlSouce : TTInputSource

@property (nonatomic, weak) id<TTInputNorlmalSourceProtocol> delegate;

@end
