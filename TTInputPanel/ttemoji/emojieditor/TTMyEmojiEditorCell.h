//
//  TTMyEmojiEditorCell.h
//  TT
//
//  Created by simp on 2018/10/20.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import "TTInputCustomEmojiCell.h"

@class TTInputCusEditItem;
@protocol TTMyEmojiEditorCellProtocol <NSObject>

- (BOOL)isEditorMode;

- (void)itemSeletedStateChanged:(TTInputCusEditItem *)item;
@end


@interface TTMyEmojiEditorCell : TTInputCustomEmojiCell

@property (nonatomic, weak) id<TTMyEmojiEditorCellProtocol> delegate;

@end
