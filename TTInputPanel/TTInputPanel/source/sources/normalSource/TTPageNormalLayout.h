//
//  TTPageNormalLayout.h
//  TTInputPanel
//
//  Created by simp on 2017/10/26.
//

#import <UIKit/UIKit.h>
#import "TTInputNormlSouce.h"

@interface TTPageNormalLayout : UICollectionViewLayout

- (instancetype)initWithSource:(TTInputNormlSouce *)source;

/**一次显示多少的item*/
@property (nonatomic, assign) NSInteger numberItemOneceShow;

@end
