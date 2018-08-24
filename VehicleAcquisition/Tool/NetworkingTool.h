//
//  NetworkingTool.h
//  PropertyCRM
//
//  Created by blm on 2018/4/28.
//  Copyright © 2018年 blm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BANetManager_OC.h"

typedef void (^RequestData)(id data);
typedef void (^RequestFail)(NSError *error);
typedef void (^RequestProgress)(NSString *progress);
@interface NetworkingTool : NSObject
/**
 *创建Request的对象方法
 */
+ (instancetype)shareRequest;

/**
 设置网络
 */
- (void)netWorkingConfig;

/////////////////////链式调用////////////////
// 线调用url再选择请求方式
/**
 没有基类URL

 @param url 链接
 @return 对象
 */
- (NetworkingTool *)networkingSplicingRequestWithUrl:(NSString *)url;

/**
 有基类的URL

 @param url 链接
 @return 对象
 */
- (NetworkingTool *)networkingBaseRequestWithUrl:(NSString *)url;


/**
 get请求

 @param parameters 参数
 @param successData 成功
 @param requestFail 失败
 */
- (void)getRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail;

/**
 post请求
 
 @param parameters 参数
 @param successData 成功
 @param requestFail 失败
 */
- (void)postRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail;

/**
 把json包裹到请求体的post请求
 
 @param parameters 参数
 @param successData 成功
 @param requestFail 失败
 */
- (void)postRequestWithJSONParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail;

/**
 DELETE请求

 @param parameters 参数
 @param successData 成功
 @param requestFail 失败
 */
- (void)deleteRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail;

/**
 PUTJSON请求
 
 @param parameters 参数
 @param successData 成功
 @param requestFail 失败
 */
- (void)putJSONRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail;

/**
 PUT请求
 
 @param parameters 参数
 @param successData 成功
 @param requestFail 失败
 */
- (void)putRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail;

/**
 PATCHJSON请求
 
 @param parameters 参数
 @param successData 成功
 @param requestFail 失败
 */
- (void)patchJSONRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail;

/**
 DELETEJSON请求
 
 @param parameters 参数
 @param successData 成功
 @param requestFail 失败
 */
- (void)deleteJSONRequestWithParameters:(NSMutableDictionary *)parameters successData:(RequestData )successData requestFail:(RequestFail )requestFail;

/**
 下载请求
 
 @param progress 进度
 @param successData 成功
 @param requestFail 失败
 */
- (void)downloadFileWithProgress:(RequestProgress)progress SuccessData:(RequestData )successData requestFail:(RequestFail )requestFail;

/**
 上传图片请求
 
 @param sourceData 图片些
 @param progress 进度
 @param successData 成功
 @param requestFail 失败
 */
- (void)upLoadingImagesWithSourceData:(NSMutableArray <PHAsset *>*)sourceData images:(NSMutableArray <UIImage *>*)images parameters:(NSMutableDictionary *)parameters progress:(RequestProgress)progress successData:(RequestData )successData requestFail:(RequestFail )requestFail;


/////////////////////普通请求////////////////

/**
 文件下载

 @param url 链接
 @param successData 成功回调
 @param requestFail 失败回调
 */
- (void)networkingToolDownloadFileWithUrl:(NSString *)url successData:(RequestData )successData requestFail:(RequestFail )requestFail;

/**
 上传文件

 @param url 链接
 @param fileName 文件名
 @param filePath 文件路径
 @param successData 成功回调
 @param requestFail 失败回调
 */
- (void)networkingToolUploadFileWithUrl:(NSString *)url fileName:(NSString *)fileName filePath:(NSString *)filePath successData:(RequestData )successData requestFail:(RequestFail )requestFail;
@end
