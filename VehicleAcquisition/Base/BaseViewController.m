//
//  BaseViewController.m
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/25.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic, assign) BOOL isHide;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bottomMargin = 0;
    _topMargin = 0;
    if (SCREEN_HEIGHT == IPXHEIGHT) {
        _bottomMargin = 34;
        _topMargin = 24;
    }
    //self.view.backgroundColor = BGCOLOR;
    self.navigationController.navigationBar.translucent = false;
    //self.navigationController.navigationBar.barTintColor = THEMECOLOR;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self showBackButton];
    [self setIsExtendLayout:NO];
    [self yd_removeNavgationBarLine];
}

- (void)showBackButton {
    if (!_isHidenBackButton) {
        UIButton * backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        backBtn.backgroundColor = [UIColor clearColor];
        
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        NSString *imageName = @"common_return_icon";
        backBtn.frame = CGRectMake(0, 0, 30, 40);
        [backBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        backBtn.adjustsImageWhenHighlighted = false;
        backBtn.showsTouchWhenHighlighted = false;
        [backBtn addTarget:self action:@selector(retrunVC) forControlEvents:UIControlEventTouchUpInside];
        //self.navigationItem.leftBarButtonItem = [UIBarButtonItem a]
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -RETURNSPACER;//ios7以后右边距默认值18px，负数相当于右移，正数左移
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItems = @[negativeSpacer, backItem];
    }
    
}

- (void)setIsExtendLayout:(BOOL)isExtendLayout {
    
    if (!isExtendLayout) {
        [self initializeSelfVCSetting];
    }
}

- (void)initializeSelfVCSetting {
    
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

- (void)retrunVC {
    [self.navigationController popViewControllerAnimated:true];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:_isHide animated:true];
}

- (void)setTitle:(NSString *)title withColor:(UIColor *)color withSize:(UIFont *)font withIsHideNavi:(BOOL )hide {
    _isHide = hide;
    if (!font) {
        font = [UIFont systemFontOfSize:18];
    }
    UILabel *titleLalbel = [[UILabel alloc]init];
    titleLalbel.font = font;
    titleLalbel.textColor = color;
    titleLalbel.text = title;
    [titleLalbel sizeToFit];
    self.navigationItem.titleView = titleLalbel;
}

#pragma mark - private
/**
 *  去除nav 上的line
 */
- (void)yd_removeNavgationBarLine {
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
                
                NSArray *list2=imageView.subviews;
                
                for (id obj2 in list2) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *imageView2=(UIImageView *)obj2;
                        
                        imageView2.hidden=YES;
                        
                    }
                }
            }
        }
    }
}

@end
