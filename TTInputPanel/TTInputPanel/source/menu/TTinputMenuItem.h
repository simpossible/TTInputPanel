//
//  TTinputMenuItem.h
//  TTInputPanel
//
//  Created by simp on 2017/11/1.
//

#import <UIKit/UIKit.h>
@class TTInputSourcePage;

@protocol TTinputMenuItemProtocol <NSObject>

- (void)menuItemPageIconClicked:(TTInputSourcePage *)page;

@end

@interface TTinputMenuItem : UIView{

}

@property (nonatomic, assign) CGFloat width;

@property (nonatomic, assign) TTInputLayoutFlex flex;

@property (nonatomic, weak) id<TTinputMenuItemProtocol> delegate;

- (instancetype)init __unavailable;

- (instancetype)initWithWidth:(CGFloat)width flex:(TTInputLayoutFlex)flex content:(UIView *)contentView;

@end
