//
//  LivingSendMessageView.h
//  GouGou-Live
//
//  Created by ma c on 16/12/9.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickEmojiButtonBlock)();
typedef void(^ClickSendButtonBlock)(NSString *string);
typedef void(^ClickEditTextFieldBlock)(UITextField *textField);
@interface LivingSendMessageView : UIView

@property(nonatomic, strong) ClickEmojiButtonBlock emojiBlock; /**< 点击表情回调 */
@property(nonatomic, strong) ClickSendButtonBlock sendBlock; /**< 点击发送回调 */
@property(nonatomic, strong) ClickEditTextFieldBlock textFieldBlock; /**< 文本框回调 */

@end
