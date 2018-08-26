//
//  VCPasswordViewController.m
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/25.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "VCPasswordViewController.h"
#import "VAHomeViewController.h"
@interface VCPasswordViewController ()
@property (nonatomic, strong) PassWordView *passWordView;
@end

@implementation VCPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadUI];
}

- (void)loadUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [[IQKeyboardManager sharedManager] setEnable:false];
    self.passWordView = [[PassWordView instance]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - super.topMargin - super.bottomMargin)];
    _passWordView.titleLabel.text = @"请输入交易密码，用于身份验证";
    [self.view addSubview:_passWordView];
    @WeakObj(self)
    self.passWordView.viewConfirmBlock=^(NSString *text) {
        if ([text isEqualToString:PASSWORD]) {
            VAHomeViewController *homeVC = [[VAHomeViewController alloc]initWithNibName:NSStringFromClass([VAHomeViewController class]) bundle:nil];
            [selfWeak hh_presentCircleVC:homeVC point:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2) completion:nil];
        } else {
            [HUDTipView HUDTipInitWithTime:TIPTIME withTitle:@"密码错误" withSuccessblock:^{
                [selfWeak.passWordView clearText];
            }];
        }
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
