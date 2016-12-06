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
#define SERVER_HOST @"http://gougou.itnuc.com/"

/** 图片服务器 */
#define IMAGE_HOST @"http://images.itnuc.com/"


#pragma mark
#pragma mark - 登录注册
/** 登录接口 get */
#define API_Login @"api/UserService/login"
/** 快速登录 get */
#define API_LoginQuick @"api/UserService/loginQuick"
/** 注册接口 get */
#define API_Register @"api/UserService/register"
/** 验证码 */
#define API_Code @"api/UserService/sms"
/** 找回密码 get */
#define API_RetrivePwd @"api/UserService/retrivePwd"
/** 验证登录密码 */
#define API_Validation_l_pwd @"api/UserService/validation_l_pwd"
/** 登录密码重置 */
#define API_Reset_pwd @"api/UserService/reset_pwd"
/** 第三方登录 */
#define API_Login_binding @"api/UserService/login_binding"
/** 第三方绑定 */
#define API_Binding @"api/UserService/binding"
/** 第三方解绑 */
#define API_Del_binding @"api/UserService/del_binding"



#pragma mark
#pragma mark - 我的模块

#pragma mark - 个人主页
/** 用户相册列表 */
#define API_album @"api/UserService/album"
/** 用户相册增加 */
#define API_Albums @"api/UserService/albums"
/** 用户相册修改 */
#define API_Up_albums @"api/UserService/up_albums"
/** 用户相册删除 */
#define API_Del_albums @"api/UserService/del_albums"

/** 用户相册相片列表 */
#define API_Album_list @"api/UserService/album_list"
/** 用户相册相片增加 */
#define API_Add_albums @"api/UserService/add_albums"
/** 用户相册相片删除 */
#define API_Album_del @"api/UserService/album_del"


#pragma mark - 认证
/** 实名认证 post */
#define API_Authenticate  @"api/UserService/Authenticate"
/** 商家认证 */
#define API_MerchantAuth @"api/UserService/merchantAuth"

#pragma mark - 账户
/** 获取用户资产 */
#define API_UserAsset @"api/UserService/getUserAsset"
/** 获取用户资产明细 */
#define API_GetUserAssertDetai @"api/UserService/getUserAssertDetai"
/** 用户提现申请 */
#define API_RetriveMoney @"api/UserService/retriveMoney"
/** 用户提现纪录 */
#define API_GetRetriveRecord @"api/UserService/getRetriveRecord"

#pragma mark - 支付宝
/** 用户支付密码添加接口 */
#define API_Pay_add @"api/UserService/pay_add"
/** 用户支付密码修改 */
#define API_Pay_up @"api/UserService/pay_up"
/** 用户绑定支付宝 */
#define API_Treasure @"api/UserService/treasure"
/** 验证支付密码接口 */
#define API_Validation_pwd @"api/UserService/validation_pwd"
/** 支付密码找回 */
#define API_Pay_find @"api/UserService/pay_find"

#pragma mark - 粉丝关注
// 粉丝列表
#define API_Fans @"api/UserService/fan"
// 关注列表
#define API_Fan_Information @"api/UserService/fan_information"
// 搜索用户
#define API_Search_nick @"api/UserService/search_nick"
// 关注/取消关注用户
#define API_Add_fan @"api/UserService/add_fan"


#pragma mark - 收藏
// 我的喜欢-狗狗
#define API_My_like_product @"api/UserService/my_like_product"
// 我的喜欢－－添加/删除
#define API_My_add_like @"api/UserService/my_add_like"


#pragma mark - 个人信息
/** 个人昵称 */
#define API_Nickname @"api/UserService/nickname"
/** 个人签名 */
#define API_Signature @"api/UserService/signature"
/** 个人头像 */
#define API_Portrait @"api/UserService/portrait"

#pragma mark - 收货地址
/** 收货地址 */
#define API_Address @"api/UserService/address"
/** 地址修改 */
#define API_Up_address @"api/UserService/up_address"
/** 地址添加 */
#define API_Add_address @"api/UserService/add_address"
/** 地址删除 */
#define API_Del_address @"api/UserService/del_address"
/** 默认地址 */
#define API_Default_address @"api/UserService/default_address"
/** 省市区 */
#define API_Province @"api/UserService/province"

#pragma mark - 发货地址
/** 发货地址列表 */
#define API_Seller_address @"api/UserService/seller_address"
/** 发货地址修改 */
#define API_Seller_address_up @"api/UserService/seller_address_up"
/** 发货地址添加 */
#define API_Seller_address_add @"api/UserService/seller_address_add"
/** 发货地址删除 */
#define API_Seller_address_del @"api/UserService/seller_address_del"
/** 发货默认地址 */
#define API_Seller_address_default @"api/UserService/seller_address_default"


#pragma mark
#pragma mark - 商品
/** 印象列表 */
#define API_Impression @"api/ProductService/Impression"
/** 搜索印象 */
#define API_Search_impression @"api/ProductService/search_impression"
/** 添加印象 */
#define API_Add_Impression @"api/ProductService/Add_Impression"

/** 搜索品种 */
#define API_Search_varieties @"api/ProductService/search_varieties"
/** 添加品种 */
#define API_Add_varieties @"api/ProductService/Add_varieties"


/** 商品分类－获取筛选过滤值 */
#define API_Category @"api/ProductService/category"
/** 商品添加 */
#define API_Add_product @"api/ProductService/add_product"
/** 商品详情 */
#define API_Product_limit @"api/ProductService/product_limit"
/** 商品修改 */
#define API_Up_product @"api/ProductService/up_product"
/** 商品图片上传 */
#define API_UploadImg @"api/ProductService/UploadImg"
/** 商品展示列表 */
#define API_Product @"api/ProductService/Product"
/** 卖家商品－列表 */
#define API_Commodity @"api/ProductService/Commodity"
/** 商品删除 */
#define API_Del_Commodity @"api/ProductService/del_Commodity"

#pragma mark
#pragma mark - 订单

#pragma mark - 买家
/** 买家订单列表 */
#define API_List_order @"api/OrderService/list_order"
/** 买家订单初始化 */
#define API_Order @"api/OrderService/order"
/** 订单评价买家 */
#define API_Order_evaluation @"api/OrderService/order_evaluation"
/** 钱包支付 */
#define API_Wallet @"api/OrderService/wallet"
/** 取消订单 */
#define API_Cancel_order @"api/OrderService/cancel_order"
/** 订单取消原因 */
#define API_Cancel_order_reason @"api/OrderService/cancel_order_reason"
/** 订单维权添加 */
#define API_Add_activist @"api/OrderService/add_activist"
/** 订单维权买家列表 */
#define API_Activist @"api/OrderService/activist"

#pragma mark - 卖家
/** 卖家订单列表 */
#define API_My_order @"api/OrderService/my_order"
/** 订单状态修改 */
#define API_Up_status @"api/OrderService/up_status"
/** 订单详情 */
#define API_Order_limit @"api/OrderService/order_limit"
/** 订单修改价格 */
#define API_Order_up @"api/OrderService/order_up"
/** 订单评价卖家 */
#define API_My_order_comment @"api/OrderService/my_order_comment"

/** 订单维权卖家列表 */
#define API_My_activist @"api/OrderService/my_activist"
/** 订单维权详情 */
#define API_My_activist_limit @"api/OrderService/activist_limit"


#pragma mark - 系统通知
/** 系统通知 */
#define API_System_msg @"api/UserService/system_msg"

@end
