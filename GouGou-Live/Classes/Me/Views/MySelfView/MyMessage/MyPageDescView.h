//
//  MyPageDescView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickEditBlock)(UILabel *contentLabel);
@interface MyPageDescView : UIView

@property(nonatomic, strong) ClickEditBlock editBlock; /**< 编辑回调 */

@property (nonatomic , assign) BOOL isHidEdit; /**< 是否隐藏编辑 */

@property (nonatomic, strong) NSString *descStr; /**< 简介 */

@end
