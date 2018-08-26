//
//  VATool.m
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/25.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "VATool.h"

@implementation VATool
+ (NSMutableArray *)crmToolGetClassPropertListWithClass:(Class )className {
    u_int count;
    objc_property_t *properties  =class_copyPropertyList(className, &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i<count; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    free(properties);
    return propertiesArray;
}

+ (void)crmToolClearFile
{
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES ) firstObject];
    [self clearCacheWithFilePath:cachePath];
    [[[SDWebImageManager sharedManager]imageCache]clearMemory];
    [[[SDWebImageManager sharedManager] imageCache] clearDiskOnCompletion:nil];
}

+ (CGFloat)crmToolReadCacheSize {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains (NSCachesDirectory , NSUserDomainMask , YES) firstObject];
    return [self folderSizeAtPath :cachePath];
}

#pragma mark - 清除path文件夹下缓存大小
+ (BOOL)clearCacheWithFilePath:(NSString *)path{
    //拿到path路径的下一级目录的子文件夹
    NSArray *subPathArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSString *filePath = nil;
    NSError *error = nil;
    for (NSString *subPath in subPathArr)
    {
        filePath = [path stringByAppendingPathComponent:subPath];
        //删除子文件夹
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:&error];
        if (error) {
            return NO;
        }
    }
    return YES;
}

// 遍历文件夹获得文件夹大小，返回多少 M
+ (CGFloat)folderSizeAtPath:(NSString *) folderPath{
    
    NSFileManager * manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject]) != nil ){
        //获取文件全路径
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    CGFloat imageSize = [[SDWebImageManager sharedManager] imageCache].getSize;
    folderSize += imageSize;
    return folderSize/( 1024.0 * 1024.0);
    
}

// 计算 单个文件的大小
+ (NSInteger)fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil] fileSize];
    }
    return 0;
}

+ (void)crmToolMaxStarwordsLengthWithTextField:(UITextField *)textField withMaxSL:(NSInteger )maxSL {
    NSString *toBeString = textField.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > maxSL)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxSL];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:maxSL];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxSL)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    
}

+ (void)crmToolMaxStarwordsLengthWithTextView:(UITextView *)textView withMaxSL:(NSInteger )maxSL {
    NSString *toBeString = textView.text;
    
    //获取高亮部分
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    
    // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position)
    {
        if (toBeString.length > maxSL)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:maxSL];
            if (rangeIndex.length == 1)
            {
                textView.text = [toBeString substringToIndex:maxSL];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, maxSL)];
                textView.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}

+ (UIViewController *)crmToolGetCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [VATool getCurrentVCFrom:rootViewController];
    return currentVC;
}

//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [VATool getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [VATool getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}

+ (NSString *)crmToolformateTime:(NSString *)time format:(NSString *)format {
    NSTimeInterval tempTime = [time doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:tempTime];
    [formatter setDateFormat:format];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

+ (NSString *)crmToolConversionIntoATimestampWithString:(NSString *)time frmatterTime:(NSString *)frmatterTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:frmatterTime];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:time]; //------------将字符串按formatter转成nsdate
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return [NSString stringWithFormat:@"%ld", (long)timeSp];
}

+ (NSString *)crmToolLowercaseSpellingWithChineseCharacters:(NSString *)chinese {
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:chinese];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    //返回小写拼音
    return [str lowercaseString];
}
@end
