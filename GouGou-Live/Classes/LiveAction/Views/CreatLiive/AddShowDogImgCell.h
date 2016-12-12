//
//  AddShowDogImgCell.h
//  GouGou-Live
//
//  Created by ma c on 16/12/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SellerMyGoodsModel.h"

typedef void(^ClickDeleteBlcok)();
@interface AddShowDogImgCell : UICollectionViewCell

@property(nonatomic, strong) ClickDeleteBlcok deleteBlock; /**< 删除回调 */

@property(nonatomic, strong) SellerMyGoodsModel  *model; /**< 图片 */


@end
