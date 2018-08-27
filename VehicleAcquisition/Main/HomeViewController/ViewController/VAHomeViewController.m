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
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *borderViews;
@property (weak, nonatomic) IBOutlet UITextField *collectorTextField;
@property (weak, nonatomic) IBOutlet UITextField *batchTextField;
@property (weak, nonatomic) IBOutlet UIButton *collectorButton;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (weak, nonatomic) IBOutlet UIView *toBeView;

@end

@implementation VAHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
}

- (void)setUI {
    [_collectorButton.layer addSublayer:[VATool vcToolGradientLayerWithFrame:_collectorButton.bounds]];
    _collectorButton.layer.cornerRadius = _collectorButton.height / 2;
    _collectorButton.layer.masksToBounds = true;
    for (UIView *view in _borderViews) {
        view.layer.cornerRadius = view.height / 2;
        view.layer.borderColor = BORDERCOLOR.CGColor;
        view.layer.borderWidth = 1;
    }
    
    _collectorTextField.attributedPlaceholder = [VATool vcToolPlaceholderWithText:@"请选择采集人员"];
    
    _batchTextField.attributedPlaceholder = [VATool vcToolPlaceholderWithText:@"请选择批次"];
    
    _toBeView.layer.cornerRadius = _toBeView.height / 2;
    _shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_shadowView.bounds cornerRadius:_shadowView.height / 2].CGPath;
    _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(1, 2);
    _shadowView.layer.shadowOpacity = 0.5;
}

- (IBAction)collectionTap:(UITapGestureRecognizer *)sender {
}

- (IBAction)batchTap:(UITapGestureRecognizer *)sender {
}

- (IBAction)collectionButtonTap:(UIButton *)sender {
}

- (IBAction)toBeSubmittedTap:(UITapGestureRecognizer *)sender {
}

- (IBAction)aaa:(UIButton *)sender {
    TLCityPickerController *cityPickerVC= [[TLCityPickerController alloc]init];
    [self.navigationController pushViewController:cityPickerVC animated:true];
}
@end
