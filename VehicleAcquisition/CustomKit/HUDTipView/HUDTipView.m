//
//  HUDTipView.m
//  Life
//
//  Created by 法正磊 on 16/6/1.
//  Copyright © 2016年 PaodeKuai. All rights reserved.
//

#define FontSize 13

#define Offset 10

#define TipViewHeight 32

#import "HUDTipView.h"


@interface HUDTipView ()

//  提示语
@property (strong, nonatomic) NSString *promptTitle;

//  提示Lable
@property (strong, nonatomic) UILabel *promptLable;

//  时间
@property (assign, nonatomic) CGFloat time;

@property (nonatomic, copy) successBlock block;

@end

@implementation HUDTipView

+ (void )HUDTipInitWithTime:(CGFloat )time withTitle:(NSString *)title withSuccessblock:(successBlock)block{
    
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    HUDTipView *showView= [[HUDTipView alloc]init];
    CGPoint center = window.center;
    showView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.4];
    center = CGPointMake(center.x, center.y);
    showView.center = center;
    showView.layer.cornerRadius = CORNERRADIUS;
    showView.layer.masksToBounds = true;
    [window addSubview:showView];
    showView.time = time;
    showView.tag = 1000;
    showView.promptTitle = title;
    showView.block = block;
}

- (void)setPromptTitle:(NSString *)promptTitle{
    
    CGRect titleRect = [promptTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kHeight(FontSize)]} context:nil];
    
    self.bounds = CGRectMake(0, 0, titleRect.size.width+Offset*2, TipViewHeight);
    
    
    
    UILabel *tipLabel = [[UILabel alloc]init];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.font = [UIFont systemFontOfSize:kHeight(FontSize)];
    tipLabel.text = promptTitle;
    tipLabel.frame = CGRectMake(Offset, TipViewHeight/2-(FontSize+2)/2, titleRect.size.width, FontSize+2);
    [self addSubview:tipLabel];
    
    
    [UIView animateWithDuration:.5 delay:_time options:UIViewAnimationOptionLayoutSubviews animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        if (self.block) {
            self.block();
            
        }
       
        [self removeFromSuperview];
    }];

}

- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        
    }
    return self;
}


@end
