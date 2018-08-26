//
//  HUDTipView.h
//  Life
//
//  Created by 法正磊 on 16/6/1.
//  Copyright © 2016年 LiuLei. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef void(^successBlock)(void);

@interface HUDTipView : UIView


@property (nonatomic, copy) NSString *titleStr;

+ (void )HUDTipInitWithTime:(CGFloat )time withTitle:(NSString *)title withSuccessblock:(successBlock)block;

@end
