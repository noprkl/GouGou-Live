//
//  MyPagePictureView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickManageButtonBlobk)();
typedef void(^ClickPictureCellBlobk)();
@interface MyPagePictureView : UIView

@property(nonatomic, assign) NSInteger maxCount; /**< 每行图片最大个数 */

@property(nonatomic, strong) NSArray *dataPlist; /**< 数据源 */

@property(nonatomic, strong) ClickManageButtonBlobk manageBlock; /**< 管理回调 */

@property(nonatomic, strong) ClickPictureCellBlobk pictureBlock; /**< 管理回调 */
@end
