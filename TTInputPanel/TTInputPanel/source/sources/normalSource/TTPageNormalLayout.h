//
//  TTPageNormalLayout.h
//  TTInputPanel
//
//  Created by simp on 2017/10/26.
//

#import <UIKit/UIKit.h>

@class TTInputNormlSouce;

@interface TTPageNormalLayout : UICollectionViewLayout {
    @protected
    NSMutableDictionary * _cacheForItem;
}

@property (nonatomic, strong, readonly) NSMutableDictionary * cacheForItem;

@property (nonatomic, assign, readonly) CGSize contensize;

- (instancetype)initWithSource:(TTInputNormlSouce *)source;

/**一次显示多少的item 用于 空出一两个 展示 发送按钮什么的*/
@property (nonatomic, assign) NSInteger numberItemOneceShow;

- (CGSize)caculateContentSizeForSource;

@end
