//
//  TLCityPickerController.m
//  VehicleAcquisition
//
//  Created by blm on 2018/8/24.
//  Copyright © 2018年 blm. All rights reserved.
//

#import "TLCityPickerController.h"
#import "TLCityHeaderView.h"
#import "TLCityGroupCell.h"

@interface TLCityPickerController () <TLCityGroupCellDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong) NSMutableArray *cityData;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *arraySection;
@property (nonatomic, copy) NSString *currentCity;
@end
static NSInteger const Section1Height = 60;
static NSInteger const CellHeight = 45;
@implementation TLCityPickerController
@synthesize data = _data;
@synthesize commonCitys = _commonCitys;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"选择城市"];
    
    [self.tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
    [self.tableView setSectionIndexColor:[UIColor blackColor]];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    [self.tableView registerClass:[TLCityGroupCell class] forCellReuseIdentifier:@"TLCityGroupCell"];
    [self.tableView registerClass:[TLCityHeaderView class] forHeaderFooterViewReuseIdentifier:@"TLCityHeaderView"];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.edgesForExtendedLayout=UIRectEdgeNone;
        // Fallback on earlier versions
    }
    [self setBaseData];
    [self setlocationParam];
}

- (void)setBaseData {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"cityData" ofType:@"plist"]];
        for (NSDictionary *groupDic in array) {
            TLCityGroup *group = [[TLCityGroup alloc] init];
            group.groupName = [groupDic objectForKey:@"initial"];
            for (NSDictionary *dic in [groupDic objectForKey:@"citys"]) {
                TLCity *city = [[TLCity alloc] init];
                city.cityName = [dic objectForKey:@"name"];
                city.shortName = [dic objectForKey:@"shortName"];
                NSString *pinyin = [VATool vaToolLowercaseSpellingWithChineseCharacters:dic[@"name"]];
                NSArray *pinArr = [pinyin componentsSeparatedByString:@" "];
                NSString *initials = @"";
                for (NSString *content in pinArr) {
                    initials = [initials stringByAppendingString:[content substringFromIndex:1]];
                }
                pinyin = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
                city.pinyin = pinyin;
                city.initials = initials;
                city.cityId  = dic[@"id"];
                [group.arrayCitys addObject:city];
                [self.cityData addObject:city];
            }
            [self.arraySection addObject:group.groupName];
            [self.data addObject:group];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
}

- (void)setlocationParam {
    if ([self checkLoaction]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        // 设置定位精确度
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        // 通知代理器移动多少米通知更新
        _locationManager.distanceFilter = 10;
        // 或者没有筛选器的默认设置
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager startUpdatingLocation];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation *location = locations.firstObject;
    
    CLLocation *newLocation=[[CLLocation alloc]initWithLatitude:location.coordinate.latitude longitude: location.coordinate.longitude];
    CLGeocoder *geocoder=[[CLGeocoder alloc] init];
    @WeakObj(self)
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray* placemarks,NSError* error)
     {
         CLPlacemark * placemark = [placemarks objectAtIndex:0];
         NSDictionary *dic = placemark.addressDictionary;
         if (dic.allValues.count) {
             selfWeak.currentCity = dic[@"City"];
         }
         [selfWeak.tableView reloadData];
     }];
}

- (BOOL)checkLoaction {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status) {
        //无权限
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"定位服务未开启" message:@"请在系统设置中开启定位服务 设置 > 隐私 > 定位服务 > 车辆采集" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {}];
        
        UIAlertAction *done = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if([[UIApplication sharedApplication] canOpenURL:url]) {
                NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        
        [alertController addAction:cancel];
        [alertController addAction:done];
        [[VATool vaToolGetCurrentVC] presentViewController:alertController animated:true completion:nil];
        return NO;
    }
    else{
        return YES;
    }
    
}


#pragma mark UITableViewDa taSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.data.count) {
        return self.data.count + 1;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section  == 0) {
        return 1;
    }
    TLCityGroup *group = [self.data objectAtIndex:section - 1];
    return group.arrayCitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TLCityGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TLCityGroupCell"];
        [cell setCurrentCityName:_currentCity];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    TLCityGroup *group = [self.data objectAtIndex:indexPath.section - 1];
    TLCity *city =  [group.arrayCitys objectAtIndex:indexPath.row];
    [cell.textLabel setText:city.cityName];
    
    return cell;
}

#pragma mark UITableViewDelegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }
    TLCityHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TLCityHeaderView"];
    NSString *title = [_arraySection objectAtIndex:section];
    [headerView setTitle:title];
    return headerView;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return Section1Height;
    }
    return CellHeight;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0f;
    }
    return 23.5f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (_currentCity.length) {
            for (TLCity *city in self.cityData) {
                if ([city.cityName isEqualToString:_currentCity]) {
                    [self didSelctedCity:city];
                    break;
                }
            }
        }
        return;
    }
    TLCityGroup *group = [self.data objectAtIndex:indexPath.section - 1];
    TLCity *city = [group.arrayCitys objectAtIndex:indexPath.row];
    [self didSelctedCity:city];
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.arraySection;
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index ;
}

#pragma mark TLCityGroupCellDelegate
- (void) cityGroupCellDidSelectCity:(TLCity *)city
{
    if ([_delegate respondsToSelector:@selector(cityPickerController:didSelectHotCity:)]) {
        [_delegate cityPickerController:self didSelectHotCity:city];
    }
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark TLSearchResultControllerDelegate
- (void) searchResultControllerDidSelectCity:(TLCity *)city
{
    
    [self didSelctedCity:city];
}

#pragma mark - Event Response
- (void) cancelButtonDown:(UIBarButtonItem *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerControllerDidCancel:)]) {
        [_delegate cityPickerControllerDidCancel:self];
    }
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - Private Methods
- (void) didSelctedCity:(TLCity *)city
{
    if (_delegate && [_delegate respondsToSelector:@selector(cityPickerController:didSelectCity:)]) {
        [_delegate cityPickerController:self didSelectCity:city];
    }
    [self.navigationController popViewControllerAnimated:true];
}

#pragma mark - Setter
- (void) setCommonCitys:(NSMutableArray *)commonCitys
{
    _commonCitys = commonCitys;
    if (commonCitys != nil && commonCitys.count > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:commonCitys forKey:COMMON_CITY_DATA_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (NSMutableArray *) data
{
    if (_data == nil) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (NSMutableArray *) cityData
{
    if (_cityData == nil) {
        _cityData = [[NSMutableArray alloc] init];
    }
    return _cityData;
}

- (NSMutableArray *) arraySection
{
    if (_arraySection == nil) {
        _arraySection = [[NSMutableArray alloc] initWithObjects:@"当前城市", nil];
    }
    return _arraySection;
}

- (NSMutableArray *) commonCitys
{
    if (_commonCitys == nil) {
        NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:COMMON_CITY_DATA_KEY];
        _commonCitys = (array == nil ? [[NSMutableArray alloc] init] : [[NSMutableArray alloc] initWithArray:array copyItems:YES]);
    }
    return _commonCitys;
}

@end
