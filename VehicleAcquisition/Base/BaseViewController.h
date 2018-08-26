//
//  BaseViewController.h
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/25.
//  Copyright © 2018年 blm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
@property (nonatomic, assign) BOOL isHidenBackButton;

@property (nonatomic, assign) NSInteger topMargin;

@property (nonatomic, assign) NSInteger bottomMargin;

- (void)setTitle:(NSString *)title withColor:(UIColor *)color withSize:(UIFont *)font withIsHideNavi:(BOOL )hide;

/**
 返回上一级菜单
 */
- (void)retrunVC;

@end
