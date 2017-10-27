//
//  TTInputNormlSouce.h
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import <TTInputPanel/TTInputPanel.h>

@protocol TTInputNorlmalSourceProtocol <TTInputSourceProtocol>



@end

/**
 normal item 默认 item 大小一致
 */
@interface TTInputNormlSouce : TTInputSource

@property (nonatomic, weak) id<TTInputNorlmalSourceProtocol> delegate;

- (void)generateView;
@end
