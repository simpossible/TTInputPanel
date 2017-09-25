//
//  TTInput.h
//  TTInputPanel
//
//  Created by simp on 2017/9/25.
//  Copyright © 2017年 simp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTInput : NSObject

@property (nonatomic, strong) TTInputBar * inpurtBar;

@property (nonatomic, strong) NSMutableArray<TTInputSource *> * sources;


- (void)intiialFromJsonData:(NSData *)data;

+ (instancetype)inputFromJsonData:(NSData *)data;

@end
