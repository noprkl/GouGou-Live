//
//  DogTypesView.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef BOOL(^ClickeasyBtnBlock)();
typedef BOOL(^ClickNoDropFurBtnBlock)();
typedef BOOL(^ClickFaithBtnBlock)();
typedef BOOL(^ClickLovelyBtnBlock)();
typedef void(^ClickMoreImpressBtnBlock)();

@interface DogTypesView : UIView

/** 点击以驯养回调 */
@property (strong,nonatomic) ClickeasyBtnBlock easyBtnBlock;
/** 点击不掉毛回调 */
@property (strong,nonatomic) ClickNoDropFurBtnBlock noDropFureBlock;
/** 点击忠诚回调 */
@property (strong,nonatomic) ClickFaithBtnBlock faithBtnBlock;
/** 点击可爱回调 */
@property (strong,nonatomic) ClickLovelyBtnBlock lovelyBtnBlock;
/** 点击更多印象回调 */
@property (strong,nonatomic) ClickMoreImpressBtnBlock moreImpressBtnBlock;

@end
