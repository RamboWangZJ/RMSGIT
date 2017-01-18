//
//  OrderDetailModel.h
//  jjrms
//
//  Created by user on 16/10/8.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderDetailModel : NSObject

@property(nonatomic,strong)NSString *order_status;//订单状态
@property(nonatomic,strong)NSString *order_sn;//订单id
//@property(nonatomic,strong)NSString *start_time;//开始时间
//@property(nonatomic,strong)NSString *end_time;//结束时间
@property(nonatomic,strong)NSString *ota_logo;//otalogo
//@property(nonatomic,strong)NSString *total_price;//金额
//@property(nonatomic,strong)NSString *price_unit;//货币单位
@property(nonatomic,strong)NSString *ota_tenant_name;//客户名称
//@property(nonatomic,strong)NSString *ota_tenant_phone;//客户电话
@property(nonatomic,strong)NSString *image;//图片链接
@property(nonatomic,strong)NSString *room_address;//房源地址
@property(nonatomic,strong)NSString *house_name;//房源名称
@property(nonatomic,strong)NSString *day;//居住天数
@property(nonatomic,strong)NSString *total_rental;//总价格
@property(nonatomic,strong)NSString *overview_txt;//概况
@property(nonatomic,strong)NSString *price_unit_symbol;//货币单位

//2.0

@property(nonatomic,strong)NSString *ota_tenant_email;//email
@property(nonatomic,strong)NSString *estimated_arrive_time;//qi
@property(nonatomic,strong)NSString *estimated_leave_time;//zhi
@property(nonatomic,strong)NSString *ota_tenant_phone;//zhi
@property(nonatomic,strong)NSString *rent_overview_txt;//xiangqing
@property(nonatomic,strong)NSString *price_unit;//货币单位
@property(nonatomic,strong)NSString *total_price;//金额
@property(nonatomic,strong)NSString *start_time;//开始时间
@property(nonatomic,strong)NSString *end_time;//结束时间
@property(nonatomic,strong)NSString *landlord_total_price;//价格

@end
