//
//  MyPagePictureView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAlbumsModel.h"

typedef void(^ClickManageButtonBlobk)();
typedef void(^ClickPictureCellBlobk)(MyAlbumsModel *model);
@interface MyPagePictureView : UIView

@property(nonatomic, assign) NSInteger maxCount; /**< 每行图片最大个数 */

@property(nonatomic, strong) NSArray *dataPlist; /**< 数据源 */

@property(nonatomic, strong) ClickManageButtonBlobk manageBlock; /**< 管理回调 */

@property(nonatomic, strong) ClickPictureCellBlobk pictureBlock; /**< 管理回调 */

@property (nonatomic, assign) BOOL isHidManage;
@end
