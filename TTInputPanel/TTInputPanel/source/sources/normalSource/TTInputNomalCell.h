//
//  TTInputNomalCell.h
//  Masonry
//
//  Created by simp on 2017/10/27.
//

#import <UIKit/UIKit.h>
#import "TTInputSourceItem.h"

@interface TTInputNomalCell : UICollectionViewCell{
    @protected
    UIImageView *_img;
}

@property (nonatomic, strong, readonly) UIImageView * img;

@property (nonatomic, strong) TTInputSourceItem * item;

- (void)initialUI;

- (void)diddisAppear;

@end
