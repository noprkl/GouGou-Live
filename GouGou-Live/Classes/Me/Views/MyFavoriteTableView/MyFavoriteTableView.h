//
//  MyFavoriteTableView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DeleteFavoritDogBlock)(NSString *dogID);
typedef void(^DeleteFavoriteLiveBlock)(NSString *liveID);

typedef void(^ClickFavoriteDogBlock)(NSString *dogID);
typedef void(^ClickFavoriteLiveBlock)(NSString *liveID);

@interface MyFavoriteTableView : UITableView

/** 是否为直播 */
@property (assign,nonatomic) BOOL isLive;
/** 存放喜欢的直播*/
@property (strong,nonatomic) NSMutableArray *favoriteLiveArray;
/** 存放喜欢的狗狗 */
@property (strong,nonatomic) NSMutableArray *favoriteDogArray;

@property(nonatomic, strong) DeleteFavoritDogBlock deleDogBlock; /**< 删除block */
@property(nonatomic, strong) DeleteFavoriteLiveBlock deleLiveBlock; /**< 删除block */
@property(nonatomic, strong) ClickFavoriteDogBlock clickDogBlock; /**< 删除block */
@property(nonatomic, strong) ClickFavoriteLiveBlock clickLiveBlock; /**< 删除block */

@end
