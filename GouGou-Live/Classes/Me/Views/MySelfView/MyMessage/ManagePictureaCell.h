//
//  ManagePictureaCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/21.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyAlbumsModel;
typedef void(^ClickSelectBtnBlock)();

@interface ManagePictureaCell : UICollectionViewCell

@property(nonatomic, strong) ClickSelectBtnBlock selectBlock; /**< 选中按钮 */

@property(nonatomic, assign) BOOL isHid; /**< 是否隐藏 */
@property(nonatomic, assign) BOOL isAllSelect; /**< 是否全选 */

@property(nonatomic, strong) MyAlbumsModel *model; /**< 模型 */

@end
