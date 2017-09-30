//
//  TTInputPanelDefine.m
//  TTInputPanel
//
//  Created by simp on 2017/9/29.
//  Copyright © 2017年 simp. All rights reserved.
//

#import "TTInputPanelDefine.h"

/**barItem 的类型*/
 NSString * const TTINPUTSOURCETYPE = @"type";
/**普通按钮*/
 NSString * const TTINPUTSOURCETYPENORMAL = @"normal";
/**输入框*/
 NSString * const TTINPUTSOURCETYPETEXTINPUT = @"textinput";

/**布局类型*/
 NSString * const TTINPUTBARITEMLAOUT = @"layout";

/**平均分布 支持Flex*/
 NSString * const TTINPUTBARITEMLAOUTSPACE = @"space";

/**指定每个Item 的大小 一个个排列 超过后显示更多*/
 NSString * const TTINPUTBARITEMLAOUTFIX = @"fix";




/**指定每个Item 的浮动属性*/
NSString * const TTINPUTBARITEFlEX = @"flex";

/**指定每个Item 的浮动属性*/
NSString * const TTINPUTBARITEFlEXFIX = @"fix";

/**指定每个Item 的浮动属性 大于等于*/
NSString * const TTINPUTBARITEFlEXGREAT = @"greater";

/**指定每个Item 的浮动属性 小于等于*/
NSString * const TTINPUTBARITEFlEXLESS = @"lesser";
