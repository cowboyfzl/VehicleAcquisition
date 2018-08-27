//
//  VAHomeViewController.m
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/25.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "VAHomeViewController.h"
#import "TLCityPickerController.h"

@interface VAHomeViewController ()
@property (nonatomic, assign) NSInteger value;
@end

@implementation VAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)aaa:(UIButton *)sender {
    TLCityPickerController *cityPickerVC= [[TLCityPickerController alloc]init];
    [self.navigationController pushViewController:cityPickerVC animated:true];
}
@end
