//
//  SellerOrderDetailModel.h
//  GouGou-Live
//
//  Created by ma c on 16/12/5.
//  Copyright © 2016年 LXq. All rights reserved.
//  订单详情

#import "BaseModel.h"

@interface SellerOrderDetailModel : BaseModel



@property(nonatomic, strong) NSString *buyUserId; // 买家流水号
@property(nonatomic, strong) NSString *buyUserName; //  买家姓名
@property(nonatomic, strong) NSString *status;// 订单状态

@property(nonatomic, strong) NSString *buyUserTel;//   买家电话号码
@property(nonatomic, strong) NSString *recevieProvince;// 买家所在省
@property(nonatomic, strong) NSString *recevieCity;//   买家所在市/区
@property(nonatomic, strong) NSString *recevieDistrict;//    买家所在区/县
@property(nonatomic, strong) NSString *recevieAddress;//   买家地址

@property(nonatomic, strong) NSString *closeTime; //,交易关闭时间，过期将不可再交易
@property(nonatomic, strong) NSString *finalTime;// 维权截至时间，过期将不可维权

@property(nonatomic, strong) NSString *productDeposit;//  商品订金
@property(nonatomic, strong) NSString *productRealDeposit;//  商品实付订金
@property(nonatomic, strong) NSString *productBalance;//  商品尾款
@property(nonatomic, strong) NSString *productRealBalance;// 商品实付尾款

@property(nonatomic, strong) NSString *balancePayMethod;// 尾款支付方式
@property(nonatomic, strong) NSString *traficFee;//        商品运费
@property(nonatomic, strong) NSString *traficRealFee;//商品实付运费
@property(nonatomic, strong) NSString *createTime;//   订单创建时间
@property(nonatomic, strong) NSString *depositTime;// 定金支付时间
@property(nonatomic, strong) NSString *balanceTime;// 尾款支付时间
@property(nonatomic, strong) NSString *deliveryTime;//  发货时间

@property(nonatomic, strong) NSString *userName;//  购买者昵称
@property(nonatomic, strong) NSString *name;//   商品名称
@property(nonatomic, strong) NSString *priceOld;// 商品原价
@property(nonatomic, strong) NSString *price;// 商品现价
@property(nonatomic, strong) NSString *pathSmall;// 商品图片
@property(nonatomic, strong) NSString *ageName;
@property(nonatomic, strong) NSString *sizeName;
@property(nonatomic, strong) NSString *colorName;

@end
