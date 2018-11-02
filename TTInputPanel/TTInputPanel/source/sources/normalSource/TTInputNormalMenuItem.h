//
//  TTInputNormalMenuItem.h
//  TTInputPanel
//
//  Created by simp on 2017/11/1.
//

#import "TTinputMenuItem.h"

#import "TTInputNormlSouce.h"

@interface TTInputNormalMenuItem : TTinputMenuItem

@property (nonatomic, weak) TTInputNormlSouce * source;

- (void)reload;

@end
