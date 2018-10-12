//
//  TTInputSourceItem.h
//  TTInputPanel
//
//  Created by simp on 2017/10/22.
//

#import <UIKit/UIKit.h>

@interface TTInputSourceItem : NSObject

- (instancetype)initFromDic:(NSDictionary *)dic;

/**当前的page 的item size*/
@property (nonatomic, assign) CGSize itemSize;

@property (nonatomic, assign) UIEdgeInsets margin;

@property (nonatomic, assign) CGFloat boxWidth;

@property (nonatomic, assign) CGFloat boxHeight;

@property (nonatomic, strong) UIImage * itemImg;


@end
