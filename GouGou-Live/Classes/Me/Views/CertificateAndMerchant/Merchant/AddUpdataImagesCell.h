//
//  AddUpdataImagesCell.h
//  Test1
//
//  Created by ma c on 16/11/29.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickDeleteBlcok)();
@interface AddUpdataImagesCell : UICollectionViewCell

@property(nonatomic, strong) ClickDeleteBlcok deleteBlock; /**< 删除回调 */

@property(nonatomic, strong) UIImage *image; /**< 图片 */

@end
