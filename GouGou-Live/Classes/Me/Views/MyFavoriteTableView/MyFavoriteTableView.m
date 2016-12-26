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
#import "PlayBackModel.h"

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
        return self.favoriteLiveArray.count;
//        return 10;
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
        PlayBackModel *model = self.favoriteLiveArray[indexPath.row];
        if (_clickLiveBlock) {
            _clickLiveBlock(model.liveId);
        }
    }else{
        DLog(@"狗狗");
        DogDetailInfoModel *model = self.favoriteDogArray[indexPath.row];
        if (_clickDogBlock) {
            _clickDogBlock(model.ID);
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_isLive) {
        
        WatchHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:liveCell];

        if (!cell) {
            cell = [[WatchHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:liveCell];
        }
        PlayBackModel *model = self.favoriteLiveArray[indexPath.row];
        cell.model = model;
        cell.deleBlock = ^(UIButton *btn){

            if (_deleLiveBlock) {
                _deleLiveBlock(model.liveId);
            }
        };
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
    // 如果不是直播数据 允许被编辑 侧滑删除
    if (_isLive) {
        return NO;
    }
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isLive) {
        return UITableViewCellEditingStyleDelete;
    }else{
        return UITableViewCellEditingStyleNone;
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_isLive) {
        DogDetailInfoModel *model = self.favoriteDogArray[indexPath.row];
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            if (_deleDogBlock) {
                _deleDogBlock(model.ID);
            }
        }
    }
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除后不可恢复";
}
@end
