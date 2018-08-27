//
//  VCPasswordViewController.m
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/25.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "VCPasswordViewController.h"
#import "VAHomeViewController.h"
#import "BaseNavigationController.h"
@interface VCPasswordViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *pwTextField;
@end

@implementation VCPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}

#pragma mark - 设置UI
- (void)loadUI {
    [_doneButton.layer addSublayer:[VATool vcToolGradientLayerWithFrame:_doneButton.bounds]];
    _doneButton.layer.cornerRadius = _doneButton.height / 2;
    _doneButton.layer.masksToBounds = true;
    
    _lineView.layer.cornerRadius = _lineView.height / 2;
    _lineView.layer.borderColor = BORDERCOLOR.CGColor;
    _lineView.layer.borderWidth = 1;
    
    _pwTextField.attributedPlaceholder = [VATool vcToolPlaceholderWithText:@"输入使用口令"];
}

#pragma mark - 点击确定
- (IBAction)enterTap:(UIButton *)sender {
    if ([_pwTextField.text isEqualToString:PASSWORD]) {
        
        VAHomeViewController *homeVC = [[VAHomeViewController alloc]initWithNibName:NSStringFromClass([VAHomeViewController class]) bundle:nil];
        [self hh_presentCircleVC:homeVC point:_doneButton.center completion:nil];
    } else {
        [HUDTipView HUDTipInitWithTime:TIPTIME withTitle:@"密码错误" withSuccessblock:^{}];
    }
}


@end
