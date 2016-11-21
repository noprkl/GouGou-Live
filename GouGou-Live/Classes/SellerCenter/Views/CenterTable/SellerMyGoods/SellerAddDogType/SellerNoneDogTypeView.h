//
//  SellerNoneDogTypeView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//  没有搜到狗狗狗品种

#import <UIKit/UIKit.h>

typedef void(^ClickSureAddBtnBlock)(NSString *dogType);

@interface SellerNoneDogTypeView : UIView

@property(nonatomic, strong) ClickSureAddBtnBlock addBlock; /**< 添加回调 */

@end
