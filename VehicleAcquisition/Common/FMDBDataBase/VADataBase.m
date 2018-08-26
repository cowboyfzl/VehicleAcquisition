//
//  FMDBDataBase.m
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/26.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "VADataBase.h"
@interface VADataBase ()
{
    FMDatabase  *_db;
}
@end
static VADataBase *_DBCtl = nil;
static NSString *const UploadInfoName = @"UploadInfo";
@implementation VADataBase
#pragma mark - 初始化
+ (instancetype)sharedDataBase {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_DBCtl == nil) {
            _DBCtl = [[VADataBase alloc] init];
            [_DBCtl initDataBase];
        }
    });
    return _DBCtl;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    if (_DBCtl == nil) {
        _DBCtl = [super allocWithZone:zone];
    }
    return _DBCtl;
}

- (id)copy{
    return self;
}

- (id)mutableCopy{
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone{
    return self;
}

-(void)initDataBase{
    // 获得Documents目录路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    // 文件路径
    NSString *filePath = [documentsPath stringByAppendingPathComponent:@"UploadInfo.sqlite"];
    // 实例化FMDataBase对象
    _db = [FMDatabase databaseWithPath:filePath];
    [_db open];
    if (![_db open]) {
        NSLog(@"db open fail");
        return;
    }
    
    //数据库中创建表（可创建多张）
    NSString *newPropertyModel = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id INTEGER PRIMARY KEY AUTOINCREMENT, name text, address text, imageData blob);", UploadInfoName];
    
    BOOL result = [_db executeUpdate:newPropertyModel];
  
    if (result) {
        NSLog(@"create table success1");
        
    }
    
    [_db close];
}

- (void)addUploadInfoModel:(UploadInfo *)model {
    [_db open];
    BOOL result = [_db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@ (name, address, imageData) VALUES (?,?,?)", UploadInfoName],model.name, model.address ,model.imageData];
    if (result) {
        NSLog(@"成功");
    }
    
    [_db close];
}

- (void)deleteTable {
    [_db open];

    BOOL result = [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@", UploadInfoName]];
    if (result) {
        NSLog(@"%@", [NSString stringWithFormat:@"delete from '%@' success", UploadInfoName]);
    }
    
    [_db close];
}

- (void)deleteUploadInfoModelWithId:(NSInteger)idValue {
    [_db open];
   
    BOOL result = [_db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE id = ?", UploadInfoName], @(idValue)];
    if (result) {
        NSLog(@"%@", [NSString stringWithFormat:@"delete from '%@' success ", UploadInfoName]);
    }
    
    [_db close];
}

- (void)updateDateWithModel:(UploadInfo *)model {
    [_db open];
    BOOL result =  [_db executeUpdate:[NSString stringWithFormat:@"UPDATE '%@' SET name = ? ,address = ?, imageData = ? WHERE id = ? ", UploadInfoName] ,model.address, model.imageData, model.id];
    if (result) {
        NSLog(@"%@", [NSString stringWithFormat:@"update from '%@' success ", UploadInfoName]);
    }
    [_db close];
}

- (NSMutableArray <UploadInfo *> *)getAllUploadInfoModels {
    [_db open];
    FMResultSet *res = [_db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@", UploadInfoName]];
    NSMutableArray<UploadInfo *> *arr = [NSMutableArray array];
    while ([res next]) {
        UploadInfo *model = [self uploadInfoModelWithFMDB:res];
        [arr addObject:model];
    }
    
    [_db close];
    return arr;
}

#pragma mark - res转成模型
- (UploadInfo *)uploadInfoModelWithFMDB:(FMResultSet *)res {
    UploadInfo *model = [[UploadInfo alloc] init];
    model.name = [res stringForColumn:@"name"];
    model.address = [res stringForColumn:@"address"];
    model.imageData = [res dataForColumn:@"imageData"];
    return model;
}
@end
