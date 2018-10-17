//
//  TTInputSourcePage.h
//  TTInputPanel
//
//  Created by simp on 2017/10/22.
//

#import <Foundation/Foundation.h>

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
@property (nonatomic, strong) UIImage * pageIcon;

@property (nonatomic, assign) CGSize iconSize;

@property (nonatomic, assign) BOOL selected;


/**一个page 占据多少页*/
@property (nonatomic, assign) NSInteger totoalpage;

@property (nonatomic, assign) NSInteger startPage;

/**在所有page中的顺序 - 主要是布局的时候可能用到*/
@property (nonatomic, assign) NSUInteger index;

- (instancetype)initFromDic:(NSDictionary *)dic;


@property (nonatomic, weak) id<TTInputSourcePageProtocol> delegate;

@property (nonatomic, weak) id<TTInputNormalSourceProtocol> datasource;


@property (nonatomic, weak) TTInputSource * source;

- (void)loadItems;

@end
