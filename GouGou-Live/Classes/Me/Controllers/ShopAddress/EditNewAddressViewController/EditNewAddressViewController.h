//
//  EditNewAddressViewController.h
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ClickSaveItemBlock)();

@interface EditNewAddressViewController : BaseViewController

@property(nonatomic, strong) ClickSaveItemBlock saveBlock; /**< 保存按钮 */

@end
