//
//  IdentityPictureCell.h
//  GouGou-Live
//
//  Created by ma c on 16/11/8.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickImageBlock)();

@interface IdentityPictureCell : UITableViewCell

/** 点击添加身份证 */
@property (strong,nonatomic) ClickImageBlock addIdentityBlock;


- (void)identityWithPromptlabel:(NSString *)promptText instanceImage:(UIImage *)instanceImage instanceLabe:(NSString *)instabceLabeltext identityImage:(UIImage *)identityImage identityLabel:(NSString *)idebtityLabelText;

@end
