//
//  TalkingView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/1.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickEmojiBtnBlock)();
typedef void(^ClickSendBtnBlock)(NSString *string);
typedef void(^ClickTextFieldBlock)();
@interface TalkingView : UIView

@property(nonatomic, strong) ClickEmojiBtnBlock emojiBlock; /**< 点击表情回调 */
@property(nonatomic, strong) ClickSendBtnBlock sendBlock; /**< 点击发送回调 */
@property(nonatomic, strong) ClickTextFieldBlock textFieldBlock; /**< 文本框回调 */

@property(nonatomic, strong) UITextView *messageTextField; /**< 信息输入 */

@end
