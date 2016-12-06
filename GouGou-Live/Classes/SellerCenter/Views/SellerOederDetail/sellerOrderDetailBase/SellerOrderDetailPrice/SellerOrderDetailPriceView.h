//
//  SellerOrderDetailPriceView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/17.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerOrderDetailPriceView : UIView

@property(nonatomic, strong) UILabel *allPriceCount; /**< 总价数 */
@property(nonatomic, strong) UILabel *templatePriceCount; /**< 运费数 */
@property(nonatomic, strong) UILabel *favorablePriceCount; /**< 优惠数 */
@property(nonatomic, strong) UILabel *realPriceCount; /**< 实付数 */

@end
