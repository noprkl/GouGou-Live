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
#import "DogDetailInfoModel.h"

static NSString * liveCell = @"liveCellID";
static NSString * dogCell = @"dogCellID";
@interface MyFavoriteTableView  ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MyFavoriteTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {

    if (self = [super initWithFrame:frame style:style]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;

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
        return self.favoriteDogArray.count;
//        return 5;
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
    if (_isLive) {
        DLog(@"直播");
    }else{
        DLog(@"狗狗");
    }
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
        DogDetailInfoModel *model = self.favoriteDogArray[indexPath.row];

        DogDetailInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:dogCell];
        if (!cell) {
            cell = [[DogDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:dogCell];
        }
        
        cell.model = model;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isLive) {
        DogDetailInfoModel *model = self.favoriteDogArray[indexPath.row];
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            if (_deleBlock) {
                _deleBlock(model.ID);
            }
        }
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除后不可恢复";
}
@end
