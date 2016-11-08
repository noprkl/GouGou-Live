//
//  MyFavoriteTableView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyFavoriteTableView : UITableView

/** 是否为直播 */
@property (assign,nonatomic) BOOL isLive;
/** 存放喜欢的直播*/
@property (strong,nonatomic) NSArray *favoriteLiveArray;
/** 存放喜欢的狗狗 */
@property (strong,nonatomic) NSArray *favoriteDogArray;

@end
