//
//  Constant.h
//  VehicleAcquisition
//
//  Created by blm on 2018/8/24.
//  Copyright © 2018年 blm. All rights reserved.
//

#ifndef Constant_h
#define Constant_h
/// weak
#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
/// 角度
#define DEGREES_TO_RADIANS(x) ((x)/180.0*M_PI)
/// 返回按钮间距
#define RETURNSPACER 15
/// 导航栏高度
#define NAVIGATIONHEIGHT 64
/// 圆角
#define CORNERRADIUS 4.0
/// 屏幕高度
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
/// 屏幕宽度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/// 延时
#define DELAYETIME 0.2
/// 提示时间
#define TIPTIME 2
/// IPX高度
#define IPXHEIGHT 812
/// iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/// 苹果4
#define iPhone4Height ([UIScreen mainScreen].bounds.size.height == 480)
#define iPhone4Width ([UIScreen mainScreen].bounds.size.height == 320)
/// 按照比例设置尺寸
#define kHeight(R) (iPhone4Height?(R):((R)*(SCREEN_HEIGHT)/667))
#define kWidth(R) (iPhone4Width?(R):((R)*(SCREEN_WIDTH)/375))
/// 转换为字符串
#define TEXT_STRING(x) [NSString stringWithFormat:@"%@",x]
/// 判断字段时候为空的情况
#define IF_NULL_TO_STRING(x) ([(x) isEqual:[NSNull null]]||(x)==nil)? @"":TEXT_STRING(x)
/// 获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
/// 密码
#define PASSWORD @"111111"

#pragma mark - 颜色
/// 渐变色左
#define GRADIENTCOLORLEFT [UIColor colorWithHex:0x00daff]
/// 渐变色右
#define GRADIENTCOLORRIGHT [UIColor colorWithHex:0x1c95f9]
/// 边框颜色
#define BORDERCOLOR [UIColor colorWithHex:0xdddddd]

#endif /* Constant_h */
