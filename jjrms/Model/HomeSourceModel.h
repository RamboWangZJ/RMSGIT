//
//  HomeSourceModel.h
//  jjrms
//
//  Created by user on 16/9/27.
//  Copyright © 2016年 supercity. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeSourceModel : NSObject


@property(nonatomic,strong)NSString *house_id;
@property(nonatomic,strong)NSString *house_sn;
@property(nonatomic,strong)NSString *landlord_sn;
@property(nonatomic,strong)NSString *house_name;
@property(nonatomic,strong)NSString *house_type;
@property(nonatomic,strong)NSString *room_address;
@property(nonatomic,strong)NSString *create_time;
@property(nonatomic,strong)NSString *update_time;
@property(nonatomic,strong)NSString *decoration;
@property(nonatomic,strong)NSString *status;
@property(nonatomic,retain)NSMutableArray *images;

@property(nonatomic,strong)NSString *bedroom_count;//
@property(nonatomic,strong)NSString *livingroom_count;//
@property(nonatomic,strong)NSString *bathroom_count;//
@property(nonatomic,strong)NSString *house_rooms_txt;//
@property(nonatomic,strong)NSString *rental_unit;//
@property(nonatomic,strong)NSString *status_txt;//


@end
