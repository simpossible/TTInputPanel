//
//  TTInputSourcePage.h
//  TTInputPanel
//
//  Created by simp on 2017/10/22.
//

#import <Foundation/Foundation.h>
#import "TTInputPanelDefine.h"

@class TTInputSourceItem;

@protocol TTInputSourcePageProtocol <NSObject>

- (void)pageSelectedChanged;

@end

@interface TTInputSourcePage : NSObject

@property (nonatomic, strong, readonly) NSArray<TTInputSourceItem *> *sourceItems;

/**每个pagecollectioncell 的margin*/
@property (nonatomic, assign) UIEdgeInsets margin;

/**行间距*/
@property (nonatomic, assign) CGFloat lineSpace;

/**默认的item 大小*/
@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) UIEdgeInsets itemMargin;

/**
 * item 的个数
 * 这里如果是从delegate 拿到的数据。则没有items
 */
@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) CGFloat itemBoxHeight;

@property (nonatomic, assign) CGFloat itemBoxWidth;

/**当前页面的Icon 可以显示在menu 中的*/

@property (nonatomic, copy) NSString * iconUrl;

@property (nonatomic, strong) UIImage * pageIcon;

/**menu 菜单的大小*/
@property (nonatomic, assign) CGSize iconSize;

/**menu icon 里面的图片大小*/
@property (nonatomic, assign) CGSize iconImgSize;

@property (nonatomic, assign) BOOL selected;


/**一个page 占据多少页*/
@property (nonatomic, assign) NSInteger totoalpage;

@property (nonatomic, assign) NSInteger startPage;

/**在所有page中的顺序 - 主要是布局的时候可能用到*/
@property (nonatomic, assign) NSUInteger index;

/**
 * 是否使用 item 自己的size 和 margin 来计算
 * yes : 计算布局使用每个item 的size。适用于 item 已经全部准备好的情况
 * NO : 使用于 需要动态加载item 的情况 - 需要 指定 page 的itemsize。item margin 。这种情况下 item的size 不可变
 */
@property (nonatomic, assign) BOOL useItemLayout;

- (instancetype)initFromDic:(NSDictionary *)dic;


@property (nonatomic, weak) id<TTInputSourcePageProtocol> delegate;

@property (nonatomic, weak) id<TTInputNormalSourceProtocol> datasource;


@property (nonatomic, weak) TTInputSource * source;

@property (nonatomic, assign) BOOL isSizeCaculated;

@property (nonatomic, assign) CGFloat totoalWidth;

/**这个方法给动态加载的人*/
- (TTInputSourceItem *)itemAtIndex:(NSInteger)index;

/**插入一个新的item*/
- (void)insertItem:(TTInputSourceItem *)item atIndex:(NSInteger)index;

- (void)appendItem:(TTInputSourceItem *)item;

- (void)loadItems;

@end
