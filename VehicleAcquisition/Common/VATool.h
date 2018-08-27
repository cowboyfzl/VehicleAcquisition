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
+ (NSMutableArray *)vaToolGetClassPropertListWithClass:(Class )className;

/**
 清除缓存
 */
+ (void)vaToolClearFile;

/**
 读取缓存大小
 
 @return 返回大小(MB)
 */
+ (CGFloat )vaToolReadCacheSize;

/**
 限制输入框最大字数
 
 @param textField textField
 @param maxSL 最大字数
 */
+ (void)vaToolMaxStarwordsLengthWithTextField:(UITextField *)textField withMaxSL:(NSInteger )maxSL;


/**
 限制textView最大字数
 
 @param textView textView
 @param maxSL 最大字数
 */
+ (void)vaToolMaxStarwordsLengthWithTextView:(UITextView *)textView withMaxSL:(NSInteger )maxSL;

/**
 获取当前的VC
 
 @return vc
 */
+ (UIViewController *)vaToolGetCurrentVC;

/**
 时间戳转换成格式字符串
 
 @param time 时间戳
 @param format 格式化
 @return 格式化后的字符串
 */
+ (NSString *)vaToolformateTime:(NSString *)time format:(NSString *)format;

/**
 将格式化后的字符串转换成时间戳
 
 @param time 时间
 @return 时间戳
 */
+ (NSString *)vaToolConversionIntoATimestampWithString:(NSString *)time frmatterTime:(NSString *)frmatterTime;

/**
 汉字转拼音
 
 @param chinese 中文
 @return 拼音
 */
+ (NSString *)vaToolLowercaseSpellingWithChineseCharacters:(NSString *)chinese;

/**
 保存文件

 @param filePath 全路径
 @param arr 数组
 @return 是否成功
 */
+ (BOOL)vaToolSaveFile:(NSString *)filePath withData:(NSMutableArray *)arr;

/**
 字典转json

 @param dict 数据
 @return json
 */
+ (NSString *)vaToolConvertToJsonData:(NSDictionary *)dict;

/**
 自定义占位符

 @param text 内容
 @return 可变字符串
 */
+ (NSAttributedString *)vcToolPlaceholderWithText:(NSString *)text;

/**
 设置渐变色

 @param frame 覆盖尺寸
 @return 对象
 */
+ (CAGradientLayer *)vcToolGradientLayerWithFrame:(CGRect )frame;
@end
