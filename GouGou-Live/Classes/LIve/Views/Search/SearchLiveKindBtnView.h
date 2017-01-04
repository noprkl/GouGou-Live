//
//  SearchLiveKindBtnView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/30.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickLiveKindBtnBlock)(NSString *btnTitle);

@interface SearchLiveKindBtnView : UIView
/** 数据 */
@property (strong,nonatomic) NSArray *datalist;

- (CGFloat)getViewHeight:(NSArray *)datalist;
@property(nonatomic, strong) ClickLiveKindBtnBlock clickBlcok; /**< 点击事件 */

@end
