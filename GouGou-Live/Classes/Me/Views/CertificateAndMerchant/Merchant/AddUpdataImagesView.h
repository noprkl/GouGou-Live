//
//  AddUpdataImagesView.h
//  Test1
//
//  Created by ma c on 16/11/29.
//  Copyright © 2016年 LXq. All rights reserved.
//  自定义图片添加view

#import <UIKit/UIKit.h>

typedef void(^ClickAddImageBlock)();
@interface AddUpdataImagesView : UIView

@property(nonatomic, assign) NSInteger maxCount; /**< 每行图片最大个数 */

@property(nonatomic, assign) NSInteger maxRow; /**< 最大行数 */

@property(nonatomic, strong) ClickAddImageBlock addBlock; /**< 添加按钮 */

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */
@property(nonatomic, strong) UICollectionView *collectionView; /**< 列表 */

@end
