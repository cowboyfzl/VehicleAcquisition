//
//  VATool.h
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/25.
//  Copyright © 2018年 blm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VATool : NSObject
/**
 获取属性列表
 
 @param className 类名
 @return 属性列表
 */
+ (NSMutableArray *)crmToolGetClassPropertListWithClass:(Class )className;

/**
 清除缓存
 */
+ (void)crmToolClearFile;

/**
 读取缓存大小
 
 @return 返回大小(MB)
 */
+ (CGFloat )crmToolReadCacheSize;

/**
 限制输入框最大字数
 
 @param textField textField
 @param maxSL 最大字数
 */
+ (void)crmToolMaxStarwordsLengthWithTextField:(UITextField *)textField withMaxSL:(NSInteger )maxSL;


/**
 限制textView最大字数
 
 @param textView textView
 @param maxSL 最大字数
 */
+ (void)crmToolMaxStarwordsLengthWithTextView:(UITextView *)textView withMaxSL:(NSInteger )maxSL;

/**
 获取当前的VC
 
 @return vc
 */
+ (UIViewController *)crmToolGetCurrentVC;

/**
 时间戳转换成格式字符串
 
 @param time 时间戳
 @param format 格式化
 @return 格式化后的字符串
 */
+ (NSString *)crmToolformateTime:(NSString *)time format:(NSString *)format;

/**
 将格式化后的字符串转换成时间戳
 
 @param time 时间
 @return 时间戳
 */
+ (NSString *)crmToolConversionIntoATimestampWithString:(NSString *)time frmatterTime:(NSString *)frmatterTime;

/**
 汉字转拼音
 
 @param chinese 中文
 @return 拼音
 */
+ (NSString *)crmToolLowercaseSpellingWithChineseCharacters:(NSString *)chinese;
@end
