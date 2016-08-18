//
//  RequestOrProjectTableViewCell.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 23/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "RequestOrProjectTableViewCell.h"

@implementation RequestOrProjectTableViewCell
@synthesize RequestOrProjectStatusLabel,RequestOrProjectType,RequestOrProjectNameLabel,RequestOrProjectIDLabel,StatuImageOne,StatusImageTwo,StatusImageThree,StatusImageFour,StatusLabelOne,StatusLabelTwo,StatusLabelThree,StatusStageFourLabel;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
