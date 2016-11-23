//
//  MessageInputView.h
//  GouGou-Live
//
//  Created by ma c on 16/11/23.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickCameraBlock)();
typedef void(^ClickEmojiBtnBlock)();
typedef void(^ClickSendBtnBlock)(NSString *message);

@interface MessageInputView : UIView

@property(nonatomic, strong) ClickCameraBlock cameraBlock; /**< 点击相机回调 */
@property(nonatomic, strong) ClickEmojiBtnBlock emojiBlock; /**< 点击表情回调 */
@property(nonatomic, strong) ClickSendBtnBlock sendBlock; /**< 点击发送回调 */
@end
