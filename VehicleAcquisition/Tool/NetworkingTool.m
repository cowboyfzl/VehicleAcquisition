//
//  NetworkingTool.m
//  PropertyCRM
//
//  Created by blm on 2018/4/28.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "NetworkingTool.h"
#import "Constant.h"
#import "AFNetworking.h"
@interface NetworkingTool()
@property (nonatomic, copy) NSString *url;
@end

@implementation NetworkingTool

static NetworkingTool *_netWork = nil;
#pragma mark - 单例获取
+ (instancetype)shareRequest {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_netWork == nil) {
            _netWork = [[NetworkingTool alloc] init];
            [_netWork netWorkingConfig];
        }
    });
    return _netWork;
}

- (void)netWorkingConfig {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"cityData" ofType:@"plist"];
    
    // 设置缓存方式
    [BANetManager sharedBANetManager].timeoutInterval = 10;
    [BANetManager ba_setValue:@"application/json" forHTTPHeaderKey:@"Content-Type"];
    // 实时监测网络状态
    [self monitorNetworkStatus];
}

#pragma mark - 实时监测网络状态
- (void)monitorNetworkStatus
{
    [BANetManager ba_startNetWorkMonitoringWithBlock:^(BANetworkStatus status) {
        NSString *msg;
        switch (status) {
            case 0:
            {
                msg = @"未知网络";
                
            }
                break;
            case 1:
            {
                msg = @"没有网络";
                
            }
                break;
            case 2:
            {
                msg = @"您的网络类型为：手机 3G/4G 网络";
                
            }
                break;
            case 3:
            {
                msg = @"您的网络类型为：wifi 网络";
                
            }
                break;
                
            default:
                break;
        }
    }];
}

- (NetworkingTool *)networkingSplicingRequestWithUrl:(NSString *)url {
    _url = url;
    return self;
}

- (NetworkingTool *)networkingBaseRequestWithUrl:(NSString *)url {
//    _url = [NSString stringWithFormat:@"%@%@", BASE_SERVER_ADDRESS,url];
    return self;
}

- (void)getRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData)successData requestFail:(RequestFail)requestFail {
    BADataEntity *entity = [[BADataEntity alloc]init];
    entity.urlString = _url;
    entity.needCache = NO;
    entity.parameters = parameters;
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        successData(response);
    } failureBlock:^(NSError *error) {
        requestFail(error);
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}

- (void)deleteRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail {
    BADataEntity *entity = [[BADataEntity alloc]init];
    entity.urlString = _url;
    entity.needCache = NO;
    entity.parameters = parameters;
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    [BANetManager ba_request_DELETEWithEntity:entity successBlock:^(id response) {
        if (successData) {
            successData(response);
        }
    } failureBlock:^(NSError *error) {
        if (requestFail) {
            requestFail(error);
        }
    } progressBlock:nil];
}

- (void)deleteJSONRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail {
    BADataEntity *entity = [[BADataEntity alloc]init];
    entity.urlString = _url;
    entity.needCache = NO;
    entity.parameters = parameters;
   
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    [BANetManager ba_request_DELETEJSONWithEntity:entity successBlock:^(id response) {
        if (successData) {
            successData(response);
        }
    } failureBlock:^(NSError *error) {
        if (requestFail) {
            requestFail(error);
        }
    } progressBlock:nil];
}

- (void)putJSONRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail {
    BADataEntity *entity = [[BADataEntity alloc]init];
    entity.urlString = _url;
    entity.needCache = NO;
    entity.parameters = parameters;
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    if ([parameters isKindOfClass:[NSMutableDictionary class]]) {
       
    }
    [BANetManager ba_request_PUTJSONWithEntity:entity successBlock:^(id response) {
        if (successData) {
            successData(response);
        }
    } failureBlock:^(NSError *error) {
        if (requestFail) {
            requestFail(error);
        }
    } progressBlock:nil];
}

- (void)putRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail {
    BADataEntity *entity = [[BADataEntity alloc]init];
    entity.urlString = _url;
    entity.needCache = NO;
    entity.parameters = parameters;
    if ([parameters isKindOfClass:[NSMutableDictionary class]]) {
        
    }
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    [BANetManager ba_request_PUTWithEntity:entity successBlock:^(id response) {
        if (successData) {
            successData(response);
        }
    } failureBlock:^(NSError *error) {
        if (requestFail) {
            requestFail(error);
        }
    } progressBlock:nil];
}

- (void)patchJSONRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData)successData requestFail:(RequestFail)requestFail {
    BADataEntity *entity = [[BADataEntity alloc]init];
    entity.urlString = _url;
    entity.needCache = NO;
    entity.parameters = parameters;
    if ([parameters isKindOfClass:[NSMutableDictionary class]]) {
        
    }
    
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    [BANetManager ba_request_PATCHJSONWithEntity:entity successBlock:^(id response) {
        if (successData) {
            successData(response);
        }
    } failureBlock:^(NSError *error) {
        if (requestFail) {
            requestFail(error);
        }
    } progressBlock:nil];
}

- (void)postRequestWithJSONParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail {
    BADataEntity *entity = [[BADataEntity alloc]init];
    entity.urlString = _url;
    entity.needCache = NO;
    entity.parameters = parameters;
    if ([parameters isKindOfClass:[NSMutableDictionary class]]) {
        
    }
    [BANetManager ba_request_POSTJSONWithEntity:entity successBlock:^(id response) {
        if (successData) {
             successData(response);
        }
    } failureBlock:^(NSError *error) {
        if (requestFail) {
             requestFail(error);
        }
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {}];
}

- (void)postRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData)successData requestFail:(RequestFail)requestFail {
    BADataEntity *entity = [[BADataEntity alloc]init];
    entity.urlString = _url;
    entity.needCache = NO;
    entity.parameters = parameters;
    if ([parameters isKindOfClass:[NSMutableDictionary class]]) {
        
    }
    // 如果打印数据不完整，是因为 Xcode 8 版本问题，请下断点打印数据
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        successData(response);
    } failureBlock:^(NSError *error) {
        requestFail(error);
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
}

- (void)downloadFileWithProgress:(RequestProgress)progress SuccessData:(RequestData)successData requestFail:(RequestFail)requestFail {
    BAFileDataEntity *entity = [[BAFileDataEntity alloc]init];
    entity.urlString = _url;
    entity.needCache = true;
    NSArray *fileName = [_url componentsSeparatedByString:@"/"];
    entity.fileName = fileName.lastObject;
    NSString *fullPath = [NSHomeDirectory() stringByAppendingString:[NSString stringWithFormat:@"/Documents/%@", fileName.lastObject]];
    entity.filePath = fullPath;
    [BANetManager ba_downLoadFileWithEntity:entity successBlock:^(id response) {
        if (successData) {
            successData(response);
        }
        [SVProgressHUD dismiss];
    } failureBlock:^(NSError *error) {
        if (requestFail) {
            requestFail(error);
        }
        [SVProgressHUD dismiss];
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        CGFloat value = (CGFloat)bytesProgress / (CGFloat)totalBytesProgress;
        NSString *pr =[NSString stringWithFormat:@"%.2f", value];
        [SVProgressHUD showProgress:pr.floatValue status:@"下载中..."];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    }];
}

- (void)upLoadingImagesWithSourceData:(NSMutableArray <PHAsset *>*)sourceData images:(NSMutableArray <UIImage *>*)images parameters:(NSMutableDictionary *)parameters progress:(RequestProgress)progress successData:(RequestData )successData requestFail:(RequestFail )requestFail {
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    imageEntity.imageArray = images;
    NSMutableArray *names = [NSMutableArray array];
    for (PHAsset *data in sourceData) {
        [names addObject:[data valueForKey:@"filename"]];
    }
    imageEntity.fileNames = names;
    imageEntity.urlString = _url;
    imageEntity.parameters = parameters;
    imageEntity.imageScale = 1;
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        [SVProgressHUD showSuccessWithStatus:@"上传成功"];
        if (successData) {
            successData(response);
        }
    } failurBlock:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"上传失败"];
        if (requestFail) {
            requestFail(error);
        }
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        CGFloat value = (CGFloat)bytesProgress / (CGFloat)totalBytesProgress;
        NSString *pr =[NSString stringWithFormat:@"%.2f", value];
        
        [SVProgressHUD showProgress:pr.floatValue status:@"上传中..."];
    }];
}

#pragma mark - download
- (void)networkingToolDownloadFileWithUrl:(NSString *)url successData:(RequestData )successData requestFail:(RequestFail )requestFail {
    BAFileDataEntity *entity = [[BAFileDataEntity alloc]init];
    entity.urlString = url;
    entity.fileName = url;
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:url];
    entity.filePath = fullPath;
    [BANetManager ba_downLoadFileWithEntity:entity successBlock:^(id response) {
        if (successData) {
            successData(response);
        }
        [SVProgressHUD dismiss];
    } failureBlock:^(NSError *error) {
        if (requestFail) {
            requestFail(error);
        }
        [SVProgressHUD dismiss];
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        CGFloat value = bytesProgress / totalBytesProgress;
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showProgress:value status:@"下载中..."];
    }];
}

#pragma mark - upLoad
- (void)networkingToolUploadFileWithUrl:(NSString *)url fileName:(NSString *)fileName filePath:(NSString *)filePath successData:(RequestData )successData requestFail:(RequestFail )requestFail {
    BAFileDataEntity *fileEntity = [BAFileDataEntity new];
    fileEntity.urlString = url;
    fileEntity.fileName = fileName;
    fileEntity.filePath = filePath;
    fileEntity.mineType = @"audio/wav";
    [BANetManager ba_uploadFileWithWithEntity:fileEntity successBlock:^(id response) {
        if (successData) {
            successData(response);
        }
        [SVProgressHUD dismiss];
    } failureBlock:^(NSError *error) {
        if (requestFail) {
            requestFail(error);
        }
        [SVProgressHUD dismiss];
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        CGFloat value = bytesProgress / totalBytesProgress;
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showProgress:value status:@"上传中..."];
    }];
}
@end
