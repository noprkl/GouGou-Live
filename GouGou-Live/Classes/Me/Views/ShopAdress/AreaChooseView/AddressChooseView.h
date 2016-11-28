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

typedef NSArray*(^selectFirstCompentBlock)(MyShopProvinceModel *model);
typedef NSArray*(^selectSecondCompentBlock)(MyShopProvinceModel *model);

@interface AddressChooseView : UIView

@property(nonatomic, strong) NSArray *provinceDataArr; /**< 省数据 */
@property(nonatomic, strong) NSArray *cityDataArr; /**< 市数据 */
@property(nonatomic, strong) NSArray *desticDataArr; /**< 县数据 */

/** pickerView */
@property (strong, nonatomic) UIPickerView *areaPicker;

@property(nonatomic, strong) selectedAreaBlock areaBlock; /**< 选中回调 */
@property(nonatomic, strong) selectFirstCompentBlock firstBlock; /**< 第一列选中 */
@property(nonatomic, strong) selectSecondCompentBlock secondBlock; /**< 第二列选中 */

- (void)show;
- (void)dismiss;
@end
