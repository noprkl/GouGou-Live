//
//  AddShowDogImgView.h
//  GouGou-Live
//
//  Created by Huimor on 16/12/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickAddBtnImageBlock)();
typedef void(^ClickDeleteBtnImageBlock)();
@interface AddShowDogImgView : UIView

@property(nonatomic, assign) NSInteger maxCount; /**< 每行图片最大个数 */

@property(nonatomic, assign) NSInteger maxRow; /**< 最大行数 */

@property(nonatomic, strong) ClickAddBtnImageBlock addBlock; /**< 添加按钮 */

@property(nonatomic, strong) ClickDeleteBtnImageBlock deleImg; /**< 删除按钮 */
@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */
@property(nonatomic, strong) UICollectionView *collectionView; /**< 列表 */
@end
