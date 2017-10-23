//
//  TTInputPannelPageMenuItem.h
//  Masonry
//
//  Created by simp on 2017/10/22.
//

#import <UIKit/UIKit.h>
#import "TTInputSourcePage.h"

@interface TTInputPannelPageMenuItem : UIControl
/**当前对应的*/
@property (nonatomic, strong, readonly) TTInputSourcePage * page;

- (instancetype)initWithPage:(TTInputSourcePage *)page;

@end
