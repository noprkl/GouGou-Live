//
//  SellerChoseAdressViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/20.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ChosedAdressBlock)(BOOL flag);
@interface SellerChoseAdressViewController : BaseViewController


@property(nonatomic, strong) ChosedAdressBlock adressBlock; /**< 选择了地址 */

@end
