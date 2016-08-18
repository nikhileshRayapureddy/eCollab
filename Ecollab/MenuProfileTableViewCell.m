//
//  MenuProfileTableViewCell.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 02/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "MenuProfileTableViewCell.h"

@implementation MenuProfileTableViewCell
@synthesize NameLabel,ProfileImage,EmailId;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [ProfileImage.layer setBorderWidth: 1.0];
    [ProfileImage.layer setCornerRadius:75.0f];
    [ProfileImage.layer setMasksToBounds:YES];
    [ProfileImage.layer setBorderColor:[[UIColor blackColor] CGColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
