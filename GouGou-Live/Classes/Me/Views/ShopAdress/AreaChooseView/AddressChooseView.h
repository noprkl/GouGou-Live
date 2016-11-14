//
//  AddressChooseView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectedAreaBlock)(NSString *province,NSString *city,NSString *area);

@interface AddressChooseView : UIView
/** 省数据 */
@property (strong,nonatomic) NSArray *provinceData;
/** 市数据 */
@property (strong,nonatomic) NSArray *cityData;
/** 区数据 */
@property (strong,nonatomic) NSArray *areaData;

@property(nonatomic, strong) selectedAreaBlock areaBlock; /**< 选中回调 */

- (void)show;
- (void)dismiss;
@end
