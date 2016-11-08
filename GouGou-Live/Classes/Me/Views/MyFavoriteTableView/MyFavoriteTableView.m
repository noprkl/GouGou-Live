//
//  MyFavoriteTableView.m
//  GouGou-Live
//
//  Created by ma c on 16/11/7.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "MyFavoriteTableView.h"
#import "WatchHistoryCell.h"
#import "DogDetailInfoCell.h"

static NSString * liveCell = @"liveCellID";
static NSString * dogCell = @"dogCellID";
@interface MyFavoriteTableView  ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyFavoriteTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;

    }
    return self;
}

- (void)setFavoriteLiveArray:(NSArray *)favoriteLiveArray {

    _favoriteLiveArray = favoriteLiveArray;
    
    [self reloadData];
}

- (void)setFavoriteDogArray:(NSArray *)favoriteDogArray {

    _favoriteDogArray = favoriteDogArray;
    
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (_isLive) {
//        return self.favoriteLiveArray.count;
        return 10;
    }else {
//        return self.favoriteDogArray.count;
        return 5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_isLive) {
        
        return 273;
        
    } else {
    
        return 120;
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DLog(@"%ld", indexPath.row);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_isLive) {
        
        WatchHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:liveCell];
        if (!cell) {
            cell = [[WatchHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:liveCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        DogDetailInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:dogCell];
        if (!cell) {
            cell = [[DogDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dogCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

@end
