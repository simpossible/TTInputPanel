//
//  TTinputMenuItem.h
//  TTInputPanel
//
//  Created by simp on 2017/11/1.
//

#import <UIKit/UIKit.h>

@interface TTinputMenuItem : UIView{
    @protected
    UIView * _contentView;
}

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) TTInputLayoutFlex flex;

- (instancetype)init __unavailable;

- (instancetype)initWithWidth:(CGFloat)width flex:(TTInputLayoutFlex)flex content:(UIView *)contentView;

@end
