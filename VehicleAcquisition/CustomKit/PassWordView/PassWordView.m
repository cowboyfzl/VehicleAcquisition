//
//  PassWordView.m
//  CcDemo
//
//  Created by 崔璨 on 2017/8/7.
//  Copyright © 2017年 cccc. All rights reserved.
//

#import "PassWordView.h"
#import "PassWordCollectionViewCell.h"
#define kCornerRadius 10
#define kCount 6
#define kBtnColor  [UIColor colorWithRed:20/255.0 green:155/255.0 blue:213/255.0 alpha:1.0]

#define  kHighlighted [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]
static NSString *reuseIdentifier = @"PassWordCollectionViewCell";
@interface PassWordView()
<
UITextFieldDelegate,
UICollectionViewDataSource,
UICollectionViewDelegate
>
@property (nonatomic , assign) NSInteger count;
@property (strong , nonatomic) NSMutableArray *textArr;
@property (nonatomic , assign) NSString *saveTextStr;
@property (nonatomic, assign) BOOL isSend;
@end
@implementation PassWordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(PassWordView *)instance
{
    NSArray *nibView=[[NSBundle mainBundle]loadNibNamed:@"PassWordView" owner:self options:nil];
    return [nibView objectAtIndex:0];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置默认值
        self.frame = frame;
        self.backgroundColor = [[UIColor brownColor]colorWithAlphaComponent:0.0];
        self.textArr = [NSMutableArray array];
        self.count = kCount;
        self.saveTextStr = @"";

        [self setViews];
        
    }
    return self;
}
-(void)setViews
{
    _isSend = true;
    self.textView.frame = CGRectMake(0, 0, self.frame.size.width*0.9, self.frame.size.height*0.3);
    self.textView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.textView.backgroundColor = [UIColor whiteColor];
    
    self.textField.frame = CGRectMake(0, 0, self.textView.frame.size.width*0.8, (self.textView.frame.size.height-self.confirmBtn.frame.size.height)*0.3);
    self.textField.center = CGPointMake(self.textView.frame.size.width/2,(self.textView.frame.size.height-self.confirmBtn.frame.size.height)/2 );
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.textField.backgroundColor = [UIColor clearColor];
    self.textField.delegate = self;
    [self.textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.textField becomeFirstResponder];
    
    self.passWordCollectionV.frame = self.textField.frame;
    self.passWordCollectionV.dataSource = self;
    self.passWordCollectionV.delegate = self;
    self.passWordCollectionV.scrollEnabled = NO;
    self.passWordCollectionV.layer.masksToBounds = YES;
    self.passWordCollectionV.layer.cornerRadius = 1;
    self.passWordCollectionV.layer.borderColor = kThemeColor.CGColor;
    self.passWordCollectionV.layer.borderWidth = 1;
    [self.passWordCollectionV registerClass:[PassWordCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    UITapGestureRecognizer *keyboardUpTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(KeyboardUp)];
    [self.passWordCollectionV addGestureRecognizer:keyboardUpTap];
    
    UITapGestureRecognizer *keyboardDownTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(KeyboardDown)];
    [self.textView addGestureRecognizer:keyboardDownTap];
    
 
}
-(void)KeyboardUp
{
    [self.textField becomeFirstResponder];
}
-(void)KeyboardDown
{
    [self.textField resignFirstResponder];
}
- (void)textFieldDidChange:(UITextField *)textField {
    [self.textArr removeAllObjects];
    NSLog(@"textField:%@",textField.text);
    self.saveTextStr = textField.text;
    
    for (int i = 0; i < textField.text.length; i ++) {
        NSRange range;
        range.location = i;
        range.length = 1;
        NSString *tempString = [textField.text substringWithRange:range];
        [self.textArr addObject:tempString];
    }
    
    if (_textField.text.length >= self.count) {
        if (_isSend) {
            if (self.viewConfirmBlock) {
                self.viewConfirmBlock(self.saveTextStr);
                _isSend = false;
            }
        }
    }
    
    [self.passWordCollectionV reloadData];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
    if ([string isEqualToString:@""]) {
        _isSend = true;
        NSLog(@"删除");
        return YES;
    }
    if (self.textField.text.length >= self.count)
    {
       
        NSLog(@"此时的self.textArr:%@",self.textArr);
        return NO;
    }
    
    return YES;
}

- (void)clearText {
    _isSend = true;
    _textField.text = @"";
    [_textArr removeAllObjects];
    [_passWordCollectionV reloadData];
}

- (void)buttonBackGroundHighlighted:(UIButton *)sender
{
    sender.backgroundColor = kHighlighted;
}
//取消
-(void)cancel:(UIButton *)sender
{
    sender.backgroundColor = [UIColor redColor];
    [self removeFromSuperview];
    self.saveTextStr = @"";
    [self.textArr removeAllObjects];
    self.textField.text = @"";
    [self.passWordCollectionV reloadData];
    
    if (self.viewCancelBlock) {
        self.viewCancelBlock();
    }
    
}
//确定
-(void)confirm:(UIButton *)sender
{
    sender.backgroundColor = kBtnColor;
    if (self.viewConfirmBlock) {
        self.viewConfirmBlock(self.saveTextStr);
    }
}
#pragma mark - UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    PassWordCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
        if (self.textArr.count == 0) {
        cell.circleImageV.backgroundColor = [UIColor whiteColor];
    }else{
        
     if (indexPath.row <= self.textArr.count - 1) {
        cell.circleImageV.backgroundColor = [UIColor grayColor];
    }else{
        cell.circleImageV.backgroundColor = [UIColor whiteColor];
    }
        
    }
    return cell;
    
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(collectionView.frame.size.width/self.count, collectionView.frame.size.height);
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
// 两行之间的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}

// 两个cell之间的最小间距，是由API自动计算的，只有当间距小于该值时，cell会进行换行
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
}

@end
