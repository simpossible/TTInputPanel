//
//  TTMessageInputer.h
//  TT
//
//  Created by simp on 2018/10/18.
//  Copyright © 2018年 yiyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TTFuncSourceItem.h"
#import "TTInput.h"
@class TTInput;
@class TTFuncSourceItem;
@class TTInputCusSourceItem;

@protocol TTMessageInputerProtocol <NSObject>

- (void)sendMsg:(NSAttributedString *)attr;

- (void)inputerLayouted;

- (void)inputerToTakePicture;

- (void)inputerToTakePhoto;

- (void)inputerToMyRoom;

- (void)inputerToMuteGroup:(TTFuncSourceItem *)muteItem;

- (UIViewController *)inputerController;

- (void)inputHeightChangingFrom:(CGFloat)oheight toHeight:(CGFloat)nheight;

- (void)inputWillChangeToHeight:(CGFloat)height;

- (void)inputWillChangeByHeight:(CGFloat)height;

- (void)inputerSendCustomEmojiWithItem:(TTInputCusSourceItem *)item;

- (BOOL)inputcanBeFocus;


- (void)textView:(UITextView *)textView willTextInRange:(NSRange)range replacementText:(NSString *)text;

@end

@interface TTMessageInputer : NSObject

@property (nonatomic, copy, readonly) NSString * account;

@property (nonatomic, weak) id<TTMessageInputerProtocol> delegate;

@property (nonatomic, weak, readonly) UIView * iphonexBottomView;

- (instancetype)initWithAccount:(NSString *)account;

- (TTInput *)input;

/**收起*/
- (void)landing;

/**如果当前是textsource 那么landing*/
- (void)landingText;

- (void)reloadMyCustomEmoji;

/**设置草稿的内容*/
- (void)setDraftForText:(NSAttributedString *)attr;

- (NSAttributedString *)draftAttr;

- (NSString *)textSourceText;

- (void)setTextSoureceText:(NSString *)text;

- (UITextView *)textView;

/**用一个view 来盖住底部。个个souce 需要改变这个coverview 的颜色*/
- (void)registIphonexBottomView:(UIView *)view;
@end
