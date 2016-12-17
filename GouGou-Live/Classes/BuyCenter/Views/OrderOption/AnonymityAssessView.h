//
//  AnonymityAssessView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/16.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AnonymityAssessBlock)(BOOL isReal);
@interface AnonymityAssessView : UIView

@property (nonatomic, strong) AnonymityAssessBlock realBlock; /**< 是否匿名 */

@end
