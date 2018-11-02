//
//  TTMyEmojiEditorToolBar.h
//  TT
//
//  Created by simp on 2018/10/20.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TTMyEmojiEditorToolBarProtocol <NSObject>

- (void)barToSelectAll:(BOOL)select;

- (void)barToDelete;


@end

@interface TTMyEmojiEditorToolBar : UIView

@property (nonatomic, weak) id<TTMyEmojiEditorToolBarProtocol> delegate;

@property (nonatomic, assign) BOOL allselect;

/**已经选中的个数*/
- (void)setDeleteCount:(NSInteger)count;


- (void)addToView:(UIView *)view;

- (void)show;

- (void)dissmiss;

@end
