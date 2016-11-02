//
//  DogTypesView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickBtnBlock)(UIButton *addButton);

@interface DogTypesView : UIView

/** 点击Button回调方法 */
@property (copy,nonatomic) ClickBtnBlock btnBlock;

@end
