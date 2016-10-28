//
//  DogSizeFilter.h
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickSizeCellBlock)(NSString *size);

@interface DogSizeFilter : UITableView

/** 点击cell回调 */
@property (strong, nonatomic) ClickSizeCellBlock sizeCellBlock;

- (void)show;
- (void)dismiss;
@end
