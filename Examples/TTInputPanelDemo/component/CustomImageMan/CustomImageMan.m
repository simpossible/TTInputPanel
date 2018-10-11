//
//  CustomImageMan.m
//  TT
//
//  Created by 杨玺湘 on 16/6/3.
//  Copyright © 2016年 yiyou. All rights reserved.
//

#import "CustomImageMan.h"

@interface CustomImageMan ()

@property(nonatomic) NSString* assetsPath;
@property(nonatomic) NSMapTable* srcImagesMap;
@property(nonatomic) NSMapTable* assetsImagesMap;
@property(nonatomic) NSDictionary* clarityDict;


@end

@implementation CustomImageMan

+ (CustomImageMan *)sharedInstance
{
    static dispatch_once_t onceToken;
    static CustomImageMan * imageSplitSharedInstance;
    
    dispatch_once(&onceToken, ^{
        imageSplitSharedInstance = [[CustomImageMan alloc] init];
    });
    return imageSplitSharedInstance;
}

static NSString* const kAssetsDir = @"assets";
static NSString* const kClarity2x = @"@2x";
static NSString* const kClarity3x = @"@3x";


- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
        self.assetsPath = [bundlePath stringByAppendingPathComponent:kAssetsDir];
        self.srcImagesMap = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:4];
        self.assetsImagesMap = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsStrongMemory capacity:32];
        [self getFilesRecursiveInDir:self.assetsPath];
        self.clarityDict    = @{@(480) : kClarity2x, @(568) : kClarity2x, @(667) : kClarity2x, @(736) : kClarity3x};
     
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
    }
    
    return self;
}

- (void)getFilesRecursiveInDir:(NSString*)dir
{
    NSFileManager* fileMgr = [NSFileManager defaultManager];
    NSArray* tempArray = [fileMgr contentsOfDirectoryAtPath:dir error:nil];
    for (NSString* fileName in tempArray)
    {
        BOOL flag = YES;
        NSString* fullPath = [dir stringByAppendingPathComponent:fileName];
        if ([fileMgr fileExistsAtPath:fullPath isDirectory:&flag])
        {
            if (!flag)
            {
                NSString* fileName = [fullPath lastPathComponent];
                NSString* fileNameWithoutExt = [fileName stringByDeletingPathExtension];
                [self.assetsImagesMap setObject:fullPath forKey:fileNameWithoutExt];
            }
            else
            {
                [self getFilesRecursiveInDir:fullPath];
            }
        }
    }
}

- (UIImage*)imageNamed:(NSString *)name
{
    NSString* fullPath = [self getClarityImagePath:name];
    
    if (fullPath)
    {
        return [UIImage imageWithContentsOfFile:fullPath];
    }
   
    if (fullPath)
    {
        return [UIImage imageWithContentsOfFile:fullPath];
    }
    if (!fullPath)
    {
        fullPath = [self.assetsImagesMap objectForKey:name];
    }
    if (!fullPath) {
        fullPath = name;
    }
    return [UIImage imageWithContentsOfFile:fullPath];
}

- (NSString*)getClarityImagePath:(NSString *)name
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    NSString* clarityString = [self.clarityDict objectForKey:@(size.height)];
    if (!clarityString)
    {
        clarityString = kClarity2x;
    }
    NSString* fileNameWithoutExt = [name stringByAppendingFormat:@"%@", clarityString];
    NSString* fullPath = [self.assetsImagesMap objectForKey:fileNameWithoutExt];
    if (fullPath)
    {
        return fullPath;
    }
    if ([kClarity3x isEqualToString:clarityString])
    {
        fileNameWithoutExt = [name stringByAppendingString:kClarity2x];
        fullPath = [self.assetsImagesMap objectForKey:fileNameWithoutExt];
    }

    return fullPath;
}


- (UIImage *)getSplitImageFilePath:(NSString *)srcImageName splitSize:(CGSize)size columnNum:(UInt32)columnNum index:(UInt32)index
{
    NSArray* images = [self.srcImagesMap objectForKey:srcImageName];
    if (!images)
    {
        UIImage *srcImage = [self imageNamed:srcImageName];
        if (!srcImage)
        {
            return nil;
        }
        images = [self getSplitImageFrom:srcImage splitSize:size columnNum:columnNum index:index];
        if (images)
        {
            [self.srcImagesMap setObject:images forKey:srcImageName];
            if (images.count > index)
            {
                return [images objectAtIndex:index];
            }
        }
    }
    else if(images.count > index)
    {
        return [images objectAtIndex:index];
    }
    return nil;
}

- (NSArray*)getSplitImageFrom:(UIImage*)srcImage splitSize:(CGSize)size columnNum:(UInt32)columnNum index:(UInt32)index
{
    if (!srcImage)
    {
        return nil;
    }
    CGFloat scale = srcImage.scale;
    UInt32 rowNum = srcImage.size.height * scale / size.height;
    UInt32 colNum = srcImage.size.width * scale  / size.width;
    UInt32 imageCount = rowNum * colNum;
    NSMutableArray* array = [[NSMutableArray alloc] initWithCapacity:imageCount];
    
    for (UInt32 i=0; i<imageCount; i++)
    {
        UInt32 rowIndex = i/columnNum;
        UInt32 colIndex = i%columnNum;
        
        CGImageRef imageRef =srcImage.CGImage;
        CGRect rect = CGRectMake(size.width*colIndex, size.height*rowIndex, size.width, size.height);
        
        CGImageRef image = CGImageCreateWithImageInRect(imageRef,rect);
        
        UIImage*newImage = [[UIImage alloc] initWithCGImage:image];
        [array addObject:newImage];
        
        CGImageRelease(image);
    }
    return array;
}

- (void)removeSplitImageFilePath:(NSString*)srcImageName
{
    [self.srcImagesMap removeObjectForKey:srcImageName];
}

- (void)clearMemory
{
    [self.srcImagesMap removeAllObjects];
}

@end
