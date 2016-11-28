//
//  APIConfig.h
//  GouGou-Live
//
//  Created by ma c on 16/10/26.
//  Copyright © 2016年 LXq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConfig : NSObject

/** 信息类服务器 */
#define SERVER_HOST @"http://gougou.itnuc.com/api/"

/** 图片服务器 */
#define IMAGE_HOST @"http://images.itnuc.com/"


#pragma mark
#pragma mark - 登录注册
/** 登录接口 get */
#define API_Login @"UserService/login"
/** 快速登录 get */
#define API_LoginQuick @"UserService/loginQuick"
/** 注册接口 get */
#define API_Register @"UserService/register"
/** 验证码 */
#define API_Code @"UserService/sms"
/** 找回密码 get */
#define API_RetrivePwd @"UserService/retrivePwd"

#pragma mark
#pragma mark - 我的模块

#pragma mark - 个人主页
/** 用户相册列表 */
#define API_album @"UserService/album"
/** 用户相册增加 */
#define API_Albums @"UserService/albums"
/** 用户相册修改 */
#define API_Up_albums @"UserService/up_albums"
/** 用户相册上传图片 */
#define API_Add_albums @"UserService/add_albums"
/** 用户相册删除 */
#define API_Del_albums @"UserService/del_albums"


#pragma mark - 认证
/** 实名认证 post */
#define API_Authenticate  @"UserService/Authenticate"
/** 商家认证 */
#define API_MerchantAuth @"merchantAuth"

#pragma mark - 账户
/** 获取用户资产 */
#define API_UserAsset @"UserService/getUserAsset"
/** 获取用户资产明细 */
#define API_GetUserAssertDetai @"UserService/getUserAssertDetai"
/** 用户支付密码添加接口 */
#define API_Pay_add @"UserService/pay_add"
/** 用户支付密码修改 */
#define API_Pay_up @"UserService/pay_up"
/** 用户提现申请 */
#define API_RetriveMoney @"UserService/retriveMoney"
/** 用户提现纪录 */
#define API_GetRetriveRecord @"UserService/getRetriveRecord"
/** 用户绑定支付宝 */
#define API_Treasure @"UserService/treasure"

#pragma mark - 粉丝关注
#define API_Fans @"/UserService/fan"
#define API_Fan_Information @"/UserService/fan_information"

#pragma mark - 个人信息
/** 个人昵称 */
#define API_Nickname @"UserService/nickname"
/** 个人签名 */
#define API_Signature @"UserService/signature"
/** 个人头像 */
#define API_Portrait @"UserService/portrait"

#pragma mark - 我的地址
/** 收货地址 */
#define API_Address @"UserService/address"
/** 地址修改 */
#define API_Up_address @"UserService/up_address"
/** 地址添加 */
#define API_Add_address @"UserService/add_address"
/** 地址删除 */
#define API_Del_address @"UserService/del_address"
/** 默认地址 */
#define API_Default_address @"UserService/default_address"

/** 省市区 */
#define API_Province @"UserService/province"


#pragma mark
#pragma mark - 商品
/** 印象列表 */
#define API_Impression @"ProductService/Impression"
/** 添加印象 */
#define API_Add_Impression @"ProductService/Add_Impression"
/** 添加品种 */
#define API_Add_varieties @"ProductService/Add_varieties"
/** 商品分类－获取筛选过滤值 */
#define API_Category @"ProductService/category"
/** 商品添加 */
#define API_Add_product @"ProductService/add_product"
/** 商品详情 */
#define API_Product_limit @"ProductService/product_limit"
/** 商品修改 */
#define API_Up_product @"ProductService/up_product"
/** 商品图片上传 */
#define API_UploadImg @"ProductService/UploadImg"
/** 商品展示列表 */
#define API_Product @"ProductService/Product"
/** 卖家商品－列表 */
#define API_Commodity @"ProductService/Commodity"
/** 商品删除 */
#define API_Del_Commodity @"ProductService/del_Commodity"

#pragma mark
#pragma mark - 订单
/** 买家订单列表 */
#define API_List_order @"ProductService/list_order"
/** 买家订单未支付 */
#define API_Order @"ProductService/order"
/** 卖家订单列表 */
#define API_My_order @"ProductService/my_order"
/** 订单状态修改 */
#define API_Up_status @"ProductService/up_status"
/** 订单详情 */
#define API_Order_limit @"ProductService/order_limit"
/** 订单修改价格 */
#define API_Order_up @"ProductService/order_up"
/** 订单评价 */
#define API_Order_evaluation @"ProductService/order_evaluation"
/** 钱包支付 */
#define API_Wallet @"ProductService/wallet"
/** 钱包支付 */
#define API_Order_limit @"ProductService/order_limit"
/** 订单修改价格 */
#define API_Order_up @"ProductService/order_up"






#pragma mark - 系统通知
/** 系统通知 */
#define API_System_msg @"UserService/system_msg"

@end
