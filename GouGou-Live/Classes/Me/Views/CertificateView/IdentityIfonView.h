//
//  IdentityIfonView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NameTextfiledChangeBlock)(UITextField *textfiled);

typedef void(^IdentityTextfiledChangeBlock)(UITextField *textfiled);

@interface IdentityIfonView : UIView
/** 监听姓名输入 */
@property (strong,nonatomic) NameTextfiledChangeBlock nameTextBlock;
/** 监听身份证号输入 */
@property (strong,nonatomic) IdentityTextfiledChangeBlock identiityTextBlock;
@end
