//
//  AddPhotosView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ClickAddPhotoBtnBlock)(UIButton *button);

@interface AddPhotosView : UIView

typedef void(^ClickAddImageBlock)();

/** 点击添加图片回调 */
@property (strong,nonatomic) ClickAddPhotoBtnBlock addPhotoBlock;

@property(nonatomic, assign) NSInteger maxCount; /**< 每行图片最大个数 */

@property(nonatomic, assign) NSInteger maxRow; /**< 最大行数 */

@property(nonatomic, strong) ClickAddImageBlock addBlock; /**< 添加按钮 */

@property(nonatomic, strong) NSMutableArray *dataArr; /**< 数据源 */
@property(nonatomic, strong) UICollectionView *collectionView; /**< 列表 */

/** 接受picker */
@property (strong,nonatomic) UIImagePickerController *pickers;
//@property (assign, nonatomic) NSInteger maxCount;
@end
