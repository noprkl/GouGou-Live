//
//  ResonsTableView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/11.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseResonBlock)(NSString * text);

@interface ResonsTableView : UITableView
/** 选责原因回调 */
@property (strong,nonatomic) ChooseResonBlock resonBlock;
- (void)show;
- (void)dismiss;
@end
