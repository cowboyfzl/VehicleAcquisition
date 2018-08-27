//
//  TLCityPickerDelegate.h
//  VehicleAcquisition
//
//  Created by blm on 2018/8/24.
//  Copyright © 2018年 blm. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TLCity;
@class TLCityPickerController;

@protocol TLCityPickerDelegate <NSObject>

- (void) cityPickerController:(TLCityPickerController *)cityPickerViewController
                    didSelectCity:(TLCity *)city;

- (void)cityPickerController:(TLCityPickerController *)cityPickerViewController
                didSelectHotCity:(TLCity *)city;

- (void) cityPickerControllerDidCancel:(TLCityPickerController *)cityPickerViewController;

@end

@protocol TLCityGroupCellDelegate <NSObject>

- (void) cityGroupCellDidSelectCity:(TLCity *)city;

@end

@protocol TLSearchResultControllerDelegate <NSObject>

- (void) searchResultControllerDidSelectCity:(TLCity *)city;

@end
