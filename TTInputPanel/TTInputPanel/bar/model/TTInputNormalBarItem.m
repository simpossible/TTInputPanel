//
//  TTInputNormalBarItem.m
//  TTInputPanel
//
//  Created by simp on 2017/9/26.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputNormalBarItem.h"

@implementation TTInputNormalBarItem

- (void)dealJson:(NSDictionary *)json {
    [super dealJson:json];
    
    self.imgName = [json objectForKey:@"itemImg"];
    self.imgUrl = [json objectForKey:@"itemUrl"];
    
}

@end
