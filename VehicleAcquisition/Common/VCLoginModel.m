//
//  VCLoginModel.m
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/26.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "VCLoginModel.h"

@interface VCLoginModel()

@end
static VCLoginModel *_model = nil;
static NSString *const Login = @"Login";
@implementation VCLoginModel
+ (instancetype)sharedLoginModel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_model) {
            _model = [[VCLoginModel alloc]init];
        }
    });
    return _model;
}

- (void)setLogin:(BOOL)login {
    [[NSUserDefaults standardUserDefaults]setBool:login forKey:Login];
}

- (BOOL)isLogin {
    return [[NSUserDefaults standardUserDefaults]boolForKey:Login];
}

- (BOOL)isAllBaseData {
    /// 假数据
    return true;
    if (self.carInfoModels.count && self.cityModels.count) {
        return true;
    }
    
    return false;
}
@end
