//
//  UpdateInfo.h
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/26.
//  Copyright © 2018年 blm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UploadInfo : NSObject
@property (nonatomic, assign) int id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) NSData *imageData;
@end
