//
//  DogShowMessageCell.h
//  GouGou-Live
//
//  Created by ma c on 16/10/31.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LiveListDogInfoModel.h"

typedef void(^ClidkShareBtnBlock)();
typedef void(^ClidkLikeBtnBlock)();
typedef void(^ClidkBookBtnBlock)(NSString *book);

@interface DogShowMessageCell : UITableViewCell

@property(nonatomic, strong) ClidkShareBtnBlock shareBlock; /**< 点击分享按钮 */
@property(nonatomic, strong) ClidkLikeBtnBlock likeBlock; /**< 点击喜欢按钮 */
@property(nonatomic, strong) ClidkBookBtnBlock bookBlock; /**< 点击订购按钮 */

@property(nonatomic, strong) LiveListDogInfoModel *model; /**< 模型 */


- (CGFloat)getCellHeight;
@end
