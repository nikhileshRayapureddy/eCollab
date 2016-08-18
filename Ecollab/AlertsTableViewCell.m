//
//  AlertsTableViewCell.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "AlertsTableViewCell.h"

@implementation AlertsTableViewCell
@synthesize PojectStatuLabel,ProjectTypeImageView,ProjectNameLabel;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
