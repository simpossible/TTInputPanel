//
//  TTInputPanelDefine.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTInputSource.h"

@class TTInputSource;
@class TTInputBarItem;


typedef NS_ENUM(NSUInteger,TTInputLayoutFlex) {
    TTInputLayoutFlexFix = 1000,
    TTInputLayoutFlexGreater,
    TTInputLayoutFlexLesser,
};


typedef BOOL (^TTInputPanelSourceIsValid)(TTInputSource *source);

typedef void (^TTInputPanelItemLayouted)(TTInputBarItem *item);




/**barItem 的类型*/
FOUNDATION_EXTERN NSString * const TTINPUTSOURCETYPE;
/**普通按钮*/
FOUNDATION_EXTERN NSString * const TTINPUTSOURCETYPENORMAL;
/**输入框*/
FOUNDATION_EXTERN NSString * const TTINPUTSOURCETYPETEXTINPUT;

/**布局类型*/
FOUNDATION_EXTERN NSString * const TTINPUTBARITEMLAOUT;

/**平均分布 支持Flex*/
FOUNDATION_EXTERN NSString * const TTINPUTBARITEMLAOUTSPACE;

/**平均分布 支持Flex*/
FOUNDATION_EXTERN NSString * const TTINPUTBARITEMLAOUTNORMAL;

/**指定每个Item 的大小 一个个排列 超过后显示更多*/
FOUNDATION_EXTERN NSString * const TTINPUTBARITEMLAOUTFIX;


/**指定每个Item 的浮动属性*/
FOUNDATION_EXTERN NSString * const TTINPUTBARITEFlEX;

/**指定每个Item 的浮动属性*/
FOUNDATION_EXTERN NSString * const TTINPUTBARITEFlEXFIX;

/**指定每个Item 的浮动属性 大于等于*/
FOUNDATION_EXTERN NSString * const TTINPUTBARITEFlEXGREAT;

/**指定每个Item 的浮动属性 小于等于*/
FOUNDATION_EXTERN NSString * const TTINPUTBARITEFlEXLESS;



typedef NS_ENUM(NSUInteger,TTInputBarLayoutType) {
    TTInputBarLayoutTypeSpace = 0,
    TTInputBarLayoutTypeNormal,
};

typedef NS_ENUM(NSUInteger,TTInputPanelState) {
    TTInputPanelStateUp = 0,
    TTInputPanelStateDown,
};



FOUNDATION_EXTERN NSString * const TTInputMargin;

FOUNDATION_EXTERN NSString * const TTInputMarginLeft;

FOUNDATION_EXTERN NSString * const TTInputMarginRight;

FOUNDATION_EXTERN NSString * const TTInputMarginTop;

FOUNDATION_EXTERN NSString * const TTInputMarginBottom;

FOUNDATION_EXTERN NSString * const TTInputSizeWidth;

FOUNDATION_EXTERN NSString * const TTInputSizeHeight;


FOUNDATION_EXTERN NSString * const TTInputBundle;


typedef struct {
    NSInteger page;
    NSInteger row;
} TTInputIndex;

@class TTInputSource;
@class TTInputSourceItem;
@class TTinputMenuItem;
@class TTPageNormalLayout;

@protocol TTInputProtocol <NSObject>

@required

- (NSInteger)numberOfSourceForInput;



- (TTInputSource *)sourceAtIndex:(NSInteger)index;

- (CGFloat)TTInputBarHeight;

- (UIColor *)TTInputBarColor;

- (BOOL)sourceShouldDeFocus:(TTInputSource *)souce;

@end


@protocol TTInputSourcesProtocol <NSObject>

@end


@protocol TTInputNormalSourceProtocol <TTInputSourcesProtocol>

- (CGFloat)ttinputNormalSourceMenuHeight;

- (NSInteger)numberOfPageForSource:(TTInputSource *)source;

- (NSInteger)itemNumerInPageIndex:(NSInteger)index atSource:(TTInputSource *)source;

- (UIEdgeInsets)marginForPageIndex:(NSInteger)index atSource:(TTInputSource *)source;

- (UIEdgeInsets)itemMarginForPageIndex:(NSInteger)index atSource:(TTInputSource *)source;

- (CGSize)itemSizeForPageAtIndex:(NSInteger)index atSource:(TTInputSource *)source;

- (TTInputSourceItem *)itemForPageAtIndex:(TTInputIndex)index atSource:(TTInputSource *)source;

//- (void)sourceItemChooesed:(TTInputSourceItem *)item;

- (void)itemSelected:(TTInputSourceItem *)item atIndex:(TTInputIndex)index forsource:(TTInputSource *)source;

- (UIImage *)unFocusImageForSourceBarItem:(TTInputSource *)source;

- (UIImage *)focusImageForSourcceBarItem:(TTInputSource *)source;

- (BOOL)shouldShowMenuForSource:(TTInputSource *)source;

- (NSArray<TTinputMenuItem *> *)itemsForMenuForSource:(TTInputSource *)source withExsitItems:(NSArray *)items;

- (UIImage *)pageIconForMenu:(TTInputSource *)source atIndex:(NSInteger)index;

- (CGSize)pageIconSizeForMenu:(TTInputSource *)source atIndex:(NSInteger)index;

- (TTPageNormalLayout *)normalLayouForSource:(TTInputSource *)source;
@end



extern TTInputIndex indexForPage(NSInteger page,NSInteger row);
