//
//  HUDView.h
//  GouGou-Live
//
//  Created by ma c on 17/1/7.
//  Copyright © 2017年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HUDView : UIView

@property (nonatomic, strong) NSString *alertStr; /**< 提示文字 */
- (void)show;
- (void)dismiss;
@end
