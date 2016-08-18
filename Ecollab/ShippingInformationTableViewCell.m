//
//  ShippingInformationTableViewCell.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 17/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "ShippingInformationTableViewCell.h"

@implementation ShippingInformationTableViewCell
@synthesize NameLabel,AddressLabel,AddressTwoLabel,PinCodeLabel,EditAddressBtnOutlet;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
