//
//  EmojiService.m
//  TTService
//
//  Created by wilson on 15/5/27.
//  Copyright (c) 2015年 yiyou. All rights reserved.
//

#import "EmojiService.h"
#import "TTEmojiCatelog.h"
#import "TTEmoji.h"

#define BASE_CATELOG_NAME       @"base"
#define EMOJI_JSON_FILE         @"emojis.json"
#define EMOJI_CATELOG_NAMESPACE @"EMOJI_CATELOG"
#define EMOJI_TEXT_NAMESPACE    @"EMOJI_TEXT"
#define JSON_KEY_CATELOG        @"catelog"
#define JSON_KEY_EMOJIS         @"emojis"
//#define EMOJI_INDEX_KEY(uid) [NSString stringWithFormat:@"emoji_index_created_%u", (unsigned int)uid]
#define EMOJI_INDEX_KEY         @"emoji_index_created_key"

static NSMutableDictionary *emojiCatelogDict;

@interface EmojiService ()

//@property(nonatomic, strong) DBKeyValueStorage *emojiTextStorage;
//@property(nonatomic, strong) DBKeyValueStorage *emojiCatelogStorage;

@property(nonatomic, strong) NSMutableDictionary *emojiTextDictionary;
@property(nonatomic, strong) NSMutableDictionary *emojiCatelogDictionary;


@end

@implementation EmojiService

+ (instancetype)currentService {
    static EmojiService * service;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        service = [[EmojiService alloc] init];
    });
    return service;
}


- (id)init{
    self = [super init];
    
    if (self) {
//        self.emojiTextStorage = [[DBKeyValueStorage alloc] initWithNamespace:EMOJI_TEXT_NAMESPACE];
//        self.emojiCatelogStorage = [[DBKeyValueStorage alloc] initWithNamespace:EMOJI_CATELOG_NAMESPACE];
        self.emojiTextDictionary    = [[NSMutableDictionary alloc] init];
        self.emojiCatelogDictionary = [[NSMutableDictionary alloc] init];
        
        [self initBaseEmojis];
    }
    
    return self;
}

- (void)initBaseEmojis{
    
//    NSString *emojisDirectory = [TTEmojiCatelog baseEmojisDirectory];
    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    
//    BOOL isDirectory;
//    BOOL exists =  [fileManager fileExistsAtPath:emojisDirectory isDirectory:&isDirectory];
//    
//    if (!exists) {
//        NSError *error;
//        BOOL success =  [fileManager createDirectoryAtPath:emojisDirectory withIntermediateDirectories:YES attributes:nil error:&error];
//        
//        if (!success) {
//            [Log error:NSStringFromClass(self.class) message:@"create emojis directory fail:%@", error];
//            return;
//        }
//        
//        NSString *baseEmojiPath = [[NSBundle mainBundle] pathForResource:BASE_CATELOG_NAME ofType:@"zip"];
//        success = [ZipUtil unzipFileAtPath:baseEmojiPath toDestination:emojisDirectory];
//        
//        if (!success) {
//            [Log error:NSStringFromClass(self.class) message:@"unzip base emoji fail."];
//            return ;
//        }
//        
//    }
    
//    UInt32 myUid = [GET_SERVICE(AuthService) myUid];
//    NSString *userDefaultKey = EMOJI_INDEX_KEY(myUid);
//    NSString *userDefaultKey = EMOJI_INDEX_KEY;
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:userDefaultKey]) { // 是否初始化基础表情
        NSError *error;
//        NSString *emojiConfigPath = [NSString stringWithFormat:@"%@/%@/%@", emojisDirectory, BASE_CATELOG_NAME, EMOJI_JSON_FILE];
        NSString *emojiConfigPath = [[NSBundle mainBundle] pathForResource:@"emojis" ofType:@"json"];
        
        NSData *emojiConfigData = [[NSData alloc] initWithContentsOfFile:emojiConfigPath];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:emojiConfigData options:kNilOptions error:&error];
    
        
        TTEmojiCatelog *emojiCatelog = [[TTEmojiCatelog alloc] initWithAttributes:[json objectForKey:JSON_KEY_CATELOG]];
        
        
        NSArray *emojiList = [self getEmojiListByCateloyName:emojiCatelog.name];
        for (TTEmoji *emoji in emojiList) {
//            [self.emojiCatelogStorage setObject:emojiCatelog.name forKey:emoji.md5];
//            [self.emojiTextStorage setObject:emoji.text forKey:emoji.md5];
            
            [self.emojiCatelogDictionary setObject:emojiCatelog.name forKey:emoji.md5];
            [self.emojiTextDictionary setObject:emoji.text forKey:emoji.md5];
        }
        
        // 保存标志
        
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:userDefaultKey];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
    
    // 建立索引    
}

- (TTEmojiCatelog *)getEmojiCatelogByName:(NSString *)name{
//    NSString *emojiConfigPath = [NSString stringWithFormat:@"%@/%@/%@", [TTEmojiCatelog baseEmojisDirectory], name, EMOJI_JSON_FILE];
    NSString *emojiConfigPath = [[NSBundle mainBundle] pathForResource:@"emojis" ofType:@"json"];
    NSData *emojiConfigData = [[NSData alloc] initWithContentsOfFile:emojiConfigPath];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:emojiConfigData options:kNilOptions error:&error];
    
 
    
    TTEmojiCatelog *emojiCatelog = [[TTEmojiCatelog alloc] initWithAttributes:[json objectForKey:JSON_KEY_CATELOG]];
    return emojiCatelog;
}

- (NSArray<TTEmoji *> *)getEmojiListByCateloyName:(NSString *)cateloyName{
//    NSString *emojiConfigPath = [NSString stringWithFormat:@"%@/%@/%@", [TTEmojiCatelog baseEmojisDirectory], cateloyName, EMOJI_JSON_FILE];
    NSString *emojiConfigPath = [[NSBundle mainBundle] pathForResource:@"emojis" ofType:@"json"];
    NSData *emojiConfigData = [[NSData alloc] initWithContentsOfFile:emojiConfigPath];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:emojiConfigData options:kNilOptions error:&error];

    
    NSDictionary *jsonEmojiCatelog = [json objectForKey:JSON_KEY_CATELOG];
    NSArray *jsonEmojiList = [jsonEmojiCatelog objectForKey:JSON_KEY_EMOJIS];
    
    NSMutableArray *emojiList = [[NSMutableArray alloc] init];
    for (NSDictionary *emojiAttributes in jsonEmojiList) {
        TTEmoji *emoji = [[TTEmoji alloc] initWithAttributes:emojiAttributes inCatelogName:cateloyName];
        [emojiList addObject:emoji];
    }
    return emojiList;
}

- (TTEmoji *)getEmojiByMd5:(NSString *)md5 excludeText:(BOOL)exclude{
    NSString *catelogName = [self getCatelogNameByMd5:md5];
    if (!catelogName) {
        return nil;
    }
    NSString *text = @"";
    if (!exclude) {
        text = [self getTextByMd5:md5];
        if (!text) {
            text = @"";
        }
    }

    NSDictionary *emojiAttributes = @{@"md5":md5, @"text":text};
    TTEmoji *emoji = [[TTEmoji alloc] initWithAttributes:emojiAttributes inCatelogName:catelogName];
    return emoji;
    
}

- (NSString *)getImagePathByMd5:(NSString *)md5{
    
//    NSString *catelogName = [self getCatelogNameByMd5:md5];
//    if (!catelogName) {
//        return nil;
//    }
//    NSString *path = [NSString stringWithFormat:@"%@/%@/%@/%@", [TTEmojiCatelog baseEmojisDirectory], catelogName, @"images", md5];
//    return path;
    return md5;
}

- (NSString *)getTextByMd5:(NSString *)md5{
//    return [self.emojiTextStorage getObjectForKey:md5 expectedClass:[NSString class] updateTime:NULL];
    return [self.emojiTextDictionary objectForKey:md5];
}

- (NSString *)getCatelogNameByMd5:(NSString *)md5{
//    NSString *catelogName = [self.emojiCatelogStorage getObjectForKey:md5 expectedClass:[NSString class] updateTime:NULL];
    NSString *catelogName = [self.emojiCatelogDictionary objectForKey:md5];
    return catelogName;

}



@end
