//
//  AddressChooseView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/4.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyShopProvinceModel;

typedef void(^selectedAreaBlock)(NSString *province,NSString *city,NSString *area);

typedef void(^selectFirstCompentBlock)(MyShopProvinceModel *model);
typedef void(^selectSecondCompentBlock)(MyShopProvinceModel *model);

@interface AddressChooseView : UIView

@property(nonatomic, strong) NSMutableArray *provinceArr; /**< <#注释#> */
@property(nonatomic, strong) NSMutableArray *cityArr; /**< <#注释#> */
@property(nonatomic, strong) NSMutableArray *desticArr; /**< <#注释#> */

/** pickerView */
@property (strong, nonatomic) UIPickerView *areaPicker;

@property(nonatomic, strong) selectedAreaBlock areaBlock; /**< 选中回调 */
@property(nonatomic, strong) selectFirstCompentBlock firstBlock; /**< 第一列选中 */
@property(nonatomic, strong) selectSecondCompentBlock secondBlock; /**< 第二列选中 */

- (void)show;
- (void)dismiss;
@end
