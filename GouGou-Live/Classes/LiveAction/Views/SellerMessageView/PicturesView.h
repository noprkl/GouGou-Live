//
//  PicturesView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/2.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickFactoryBtnBlcok)();
typedef void(^ClickDogViewBtnBlcok)();

@interface PicturesView : UIView

@property(nonatomic, strong) ClickFactoryBtnBlcok factoryBlock; /**< 工程外景回调 */
@property(nonatomic, strong) ClickDogViewBtnBlcok dogViewBlock; /**< 狗狗实景回调 */

@property(nonatomic, strong) NSArray *pictures; /**< 图片数组 */

@end
