//
//  EmojiUtil.m
//  TT
//
//  Created by 杨玺湘 on 16/6/3.
//  Copyright © 2016年 yiyou. All rights reserved.
//

#import "EmojiUtil.h"
#import "CustomImageMan.h"


@implementation EmojiUtil

static UInt32 const kMinEmojiNameLen = 4;
static UInt32 const kQQFaceSize = 48;
static UInt32 const kQQFaceCols = 10;
static UInt32 const kTTFaceSize = 50;
static UInt32 const kTTFaceCols = 9;

+ (UIImage*)getFaceImage:(NSString*)thumb
{
    if (kMinEmojiNameLen > thumb.length)
    {
        return nil;
    }
    NSString* string = [thumb substringFromIndex:1];
    UInt32 index = string.intValue;
    CustomImageMan* customImageMan = [CustomImageMan sharedInstance];
    if ('f' == [thumb characterAtIndex:0])
    {
        return [customImageMan getSplitImageFilePath:@"emojiqq" splitSize:CGSizeMake(kQQFaceSize, kQQFaceSize) columnNum:kQQFaceCols index:index];
    }
    else if ('t' == [thumb characterAtIndex:0])
    {
        return [customImageMan getSplitImageFilePath:@"emojitt" splitSize:CGSizeMake(kTTFaceSize, kTTFaceSize) columnNum:kTTFaceCols index:index];
    }
    return nil;
}

@end
