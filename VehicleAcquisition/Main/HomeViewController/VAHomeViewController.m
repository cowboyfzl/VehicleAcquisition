//
//  VAHomeViewController.m
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/25.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "VAHomeViewController.h"

@interface VAHomeViewController ()

@end

@implementation VAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)aaa:(id)sender {
    NSMutableArray *arr = [[VADataBase sharedDataBase]getAllUploadInfoModels];
    NSLog(@"%@", arr);
}

- (IBAction)ddd:(UIButton *)sender {
    UploadInfo *info = [[UploadInfo alloc]init];
    info.name = @"小米";
    info.address = @"萨达撒";
    info.imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"7.jpg"], 0.5);
    [[VADataBase sharedDataBase]addUploadInfoModel:info];
}
@end
