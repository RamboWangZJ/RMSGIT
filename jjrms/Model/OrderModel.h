//
//  OrderModel.h
//  jjrms
//
//  Created by user on 16/9/28.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject
@property(nonatomic,strong)NSString *house_sn;//房源id
@property(nonatomic,strong)NSString *order_status;//订单状态
@property(nonatomic,strong)NSString *order_sn;//订单id
@property(nonatomic,strong)NSString *price;//订单金额
@property(nonatomic,strong)NSString *price_unit;//金额单位
@property(nonatomic,strong)NSString *image;//图片链接
//@property(nonatomic,strong)NSString *room_address;//房源地址
@property(nonatomic,strong)NSString *house_name;//房源名称

//2.0
@property(nonatomic,strong)NSString *tenant_avatar;//头像
@property(nonatomic,strong)NSString *ota_tenant_name;//名字
@property(nonatomic,strong)NSString *room_address;//房源地址
@property(nonatomic,strong)NSString *rent_period_txt;//时间
@property(nonatomic,strong)NSString *rent_overview_txt;//人数
@property(nonatomic,strong)NSString *ota_total_price;//价格
@property(nonatomic,strong)NSString *rental_unit;//单位
@property(nonatomic,strong)NSString *create_time;//日期

@property(nonatomic,strong)NSString *landlord_total_price;//价格


@end
