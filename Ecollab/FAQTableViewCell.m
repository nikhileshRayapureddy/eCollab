//
//  FAQTableViewCell.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 23/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "FAQTableViewCell.h"

@implementation FAQTableViewCell
@synthesize FAQLabelOutlet;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [FAQLabelOutlet.layer setBorderWidth: 1.0];
    [FAQLabelOutlet.layer setCornerRadius:10.0f];
    [FAQLabelOutlet.layer setMasksToBounds:YES];
    [FAQLabelOutlet.layer setBorderColor:[[UIColor blackColor] CGColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
