//
//  ShippingInformationTableViewCell.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 17/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShippingInformationTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *AddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *AddressTwoLabel;
@property (strong, nonatomic) IBOutlet UILabel *PinCodeLabel;
@property (strong, nonatomic) IBOutlet UIButton *EditAddressBtnOutlet;

@end
