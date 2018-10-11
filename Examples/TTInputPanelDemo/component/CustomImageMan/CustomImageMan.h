//
//  CustomImageMan.h
//  TT
//
//  Created by 杨玺湘 on 16/6/3.
//  Copyright © 2016年 yiyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CustomImageMan : NSObject

+ (CustomImageMan *)sharedInstance;

- (UIImage*)imageNamed:(NSString *)name;

- (UIImage*)getSplitImageFilePath:(NSString*)srcImageName splitSize:(CGSize)size columnNum:(UInt32)columnNum index:(UInt32)index;

- (void)removeSplitImageFilePath:(NSString*)srcImageName;

- (void)clearMemory;

@end
