//
//  AddDogImpressionView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSureAddBtnBlock)(NSString *dogImpress);

@interface AddDogImpressionView : UIView

@property(nonatomic, strong) ClickSureAddBtnBlock addBlock; /**< 添加回调 */

@property(nonatomic, strong) NSString *dogImpress; /**< 狗狗印象 */
@end
