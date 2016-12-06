//
//  LiveTableView.m
//  GouGou-Live
//
//  Created by ma c on 16/10/27.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import "LiveTableView.h"
#import "LiveViewCell.h"

@interface LiveTableView () <UITableViewDelegate, UITableViewDataSource>

@end

/** cellid */
static NSString *cellid = @"RecommentCellid";

@implementation LiveTableView
- (void)setDataPlist:(NSMutableArray *)dataPlist {
 
    _dataPlist = dataPlist;
    
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerNib:[UINib nibWithNibName:@"LiveViewCell" bundle:nil] forCellReuseIdentifier:cellid];
         
    }
    return self;
}

// tableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return self.dataPlist.count;
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LiveViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cardBlcok = ^(UIControl *control){
        DLog(@"第%ld个卡片", indexPath.row);
    };
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (_cellBlock) {
        _cellBlock();
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 357;
}
@end
