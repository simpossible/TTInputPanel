//
//  TTInputNormlSouce.h
//  TTInputPanel
//
//  Created by simp on 2017/10/18.
//

#import "TTInputSource.h"
@class TTInputSourcePage;
/**
 normal item 默认 item 大小一致
 */
@interface TTInputNormlSouce : TTInputSource

@property (nonatomic, strong) NSArray<TTInputSourcePage *> * pages;

@property (nonatomic, weak) id <TTInputNormalSourceProtocol> datasouce;

- (void)addPage:(TTInputSourcePage *)page;

- (void)reloadPages;

@property (nonatomic, weak) id<TTInputSourceProtocol> delegate;


- (void)generateView;

- (void)pageCaculated;

/**刷新一页*/
- (void)reloadPage:(TTInputSourcePage *)page;

@end
