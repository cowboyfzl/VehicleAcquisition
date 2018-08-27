//
//  VACheckDataViewController.m
//  VehicleAcquisition
//
//  Created by 法正磊 on 2018/8/25.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "VACheckDataViewController.h"
#import "VAHomeViewController.h"
@interface VACheckDataViewController ()

@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;
@property (nonatomic, strong) CAShapeLayer *animationLayer;
@property (weak, nonatomic) IBOutlet UIView *animationView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipLabelWidth;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonWidth;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@end
static NSInteger const ButtonWidth = 80;
static NSInteger const TipWidth = 87;
@implementation VACheckDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAnimationIsRemove:true];
    });
}

#pragma mark - 设置UI
- (void)setUI {
    _reloadButton.layer.cornerRadius = CORNERRADIUS;
    _animationLayer = [CAShapeLayer layer];
    _animationLayer.backgroundColor = [UIColor whiteColor].CGColor;
    _animationLayer.bounds = CGRectMake(0, 0, 10, 20);
    _animationLayer.position = CGPointMake(SCREEN_WIDTH / 2, 50);
    _animationLayer.cornerRadius = CORNERRADIUS;
    _animationLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    [_animationLayer addAnimation:[self getAnimation] forKey:nil];
    
    _replicatorLayer = [CAReplicatorLayer layer];
    _replicatorLayer.bounds = CGRectMake(0, 0, 300, 200);
    _replicatorLayer.position = CGPointMake(SCREEN_WIDTH / 2, _animationView.height / 2);
    [_replicatorLayer addSublayer:_animationLayer];
    _replicatorLayer.instanceCount = 18;
    _replicatorLayer.instanceDelay = 0.1;
    _replicatorLayer.instanceAlphaOffset = -0.01;
    CGFloat angle = DEGREES_TO_RADIANS(20);
    _replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    [_animationView.layer addSublayer:_replicatorLayer];
}

- (CABasicAnimation *)getAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform";
    basicAnimation.duration = 1.8;
    basicAnimation.repeatCount = HUGE;
    basicAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
    basicAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3, 0.3, 0.3)];
    return basicAnimation;
}

#pragma mark - 重新加载点击
- (IBAction)loadInitialData:(UIButton *)sender {
    [self removeAnimationIsRemove:false];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        VAHomeViewController *homeVC = [[VAHomeViewController alloc]initWithNibName:NSStringFromClass([VAHomeViewController class]) bundle:nil];
        [self hh_presentCircleVC:homeVC point:CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2) completion:nil];
        
    });
}

#pragma mark - 设置网络错误重新加载的动画
- (void)removeAnimationIsRemove:(BOOL )remove {
    if (remove) {
        [self.animationLayer removeFromSuperlayer];
        self.tipLabelWidth.constant = 0;
        [UIView animateWithDuration:DELAYETIME animations:^{
            [self.animationView layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.reloadButton.hidden = false;
            self.buttonWidth.constant = ButtonWidth;
            [UIView animateWithDuration:DELAYETIME animations:^{
                [self.animationView layoutIfNeeded];
            }];
        }];
    } else {
        [_replicatorLayer addSublayer:_animationLayer];
        [_animationLayer addAnimation:[self getAnimation] forKey:nil];
        self.buttonWidth.constant = 0;
        [UIView animateWithDuration:DELAYETIME animations:^{
            [self.animationView layoutIfNeeded];
        } completion:^(BOOL finished) {
            self.reloadButton.hidden = false;
            self.tipLabelWidth.constant = TipWidth;
            [UIView animateWithDuration:DELAYETIME animations:^{
                [self.animationView layoutIfNeeded];
            }];
        }];
    }
}

@end
