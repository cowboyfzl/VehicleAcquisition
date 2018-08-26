//
//  VCLoginModel.h
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/26.
//  Copyright © 2018年 blm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarInfoModel.h"
#import "CityModel.h"

@interface VCLoginModel : NSObject
/**
 获取单例
 
 @return 对象
 */
+ (instancetype)sharedLoginModel;
/// 汽车数据
@property (nonatomic, strong) NSMutableArray <CarInfoModel *> *carInfoModels;
/// 城市数据
@property (nonatomic, strong) NSMutableArray <CityModel *> *cityModels;
/// 是否登录
@property (nonatomic, assign, getter=isLogin) BOOL login;
/// 是否有基础数据
@property (nonatomic, assign, getter=isAllBaseData) BOOL allBaseData;
@end
