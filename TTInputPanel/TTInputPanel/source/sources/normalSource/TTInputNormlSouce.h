//
//  TTInputNormlSouce.h
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInputNormlSouce.h"

/**
 normal item 默认 item 大小一致
 */
@interface TTInputNormlSouce : TTInputSource

@property (nonatomic, strong) NSArray<TTInputSourcePage *> * pages;

@property (nonatomic, weak) id <TTInputNormalSourceProtocol> datasouce;

- (void)addPage:(TTInputSourcePage *)page;

@property (nonatomic, weak) id<TTInputSourceProtocol> delegate;

- (void)generateView;

- (void)pageCaculated;
@end
