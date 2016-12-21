//
//  NoneFocusView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickRequestBlock)(NSString *text);

@interface NoneFocusView : UIView

@property (nonatomic, strong) ClickRequestBlock requestBlock; /**< 重新加载 */

@end
