//
//  FMDBDataBase.h
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/26.
//  Copyright © 2018年 blm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UploadInfo.h"
@interface VADataBase : NSObject
/**
 获取单例
 
 @return 对象
 */
+ (instancetype)sharedDataBase;

/**
 添加数据
 
 @param model 模型
 */
- (void)addUploadInfoModel:(UploadInfo *)model;

/**
 删除指定数据
 @param idValue 主键
 */
- (void)deleteUploadInfoModelWithId:(NSInteger )idValue;

/**
 删除所有数据
 */
- (void)deleteTable;

/**
 更新数据

 @param model 模型
 */
- (void)updateDateWithModel:(UploadInfo *)model;

/**
 获取所有数据
 
 @return 所有数据
 */
- (NSMutableArray <UploadInfo *> *)getAllUploadInfoModels;
@end
