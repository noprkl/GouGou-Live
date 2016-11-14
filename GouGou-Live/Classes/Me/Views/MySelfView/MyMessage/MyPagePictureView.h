//
//  MyPagePictureView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/14.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickFactoryBtnBlcok)();
typedef void(^ClickDogViewBtnBlcok)();
typedef void(^ClickManageBtnBlcok)();

@interface MyPagePictureView : UIView

@property(nonatomic, strong) ClickFactoryBtnBlcok factoryBlock; /**< 工程外景回调 */
@property(nonatomic, strong) ClickDogViewBtnBlcok dogViewBlock; /**< 狗狗实景回调 */

@property(nonatomic, strong) ClickManageBtnBlcok manageBlock; /**< 管理按钮回调 */

@property(nonatomic, strong) NSArray *pictures; /**< 图片数组 */

- (instancetype)initWithFrame:(CGRect)frame withpictures:(NSArray *)pictures;
@end
