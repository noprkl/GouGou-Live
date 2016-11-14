//
//  PhotoView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickDeleteBlock)();

@interface PhotoView : UIView

@property(nonatomic, strong) clickDeleteBlock deleteBlock; /**< 删除按钮 */

@end
