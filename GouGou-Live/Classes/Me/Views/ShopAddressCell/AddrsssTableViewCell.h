//
//  AddrsssTableViewCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/3.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickEditBtnBlock)();

@interface AddrsssTableViewCell : UITableViewCell

/** 点击编辑回调 */
@property (strong,nonatomic) ClickEditBtnBlock editBtnBlock;

@end
