//
//  DogTypesView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^ClickeasyBtnBlock)();
//typedef void(^ClickNoDropFurBtnBlock)();
//typedef void(^ClickFaithBtnBlock)();
//typedef void(^ClickLovelyBtnBlock)();
//typedef void(^ClickMoreImpressBtnBlock)();
@class DogTypesView;

typedef void(^ClickBtnBlock)(UIButton *addButton);

@interface DogTypesView : UIView



/** 点击Button回调方法 */
@property (copy,nonatomic) ClickBtnBlock btnBlock;

@end
