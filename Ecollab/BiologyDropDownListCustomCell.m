//
//  BiologyDropDownListCustomCell.m
//  eCollab
//
//  Created by Kiran Kumar on 24/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "BiologyDropDownListCustomCell.h"

@implementation BiologyDropDownListCustomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self =   [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect accessoryViewFrame = self.accessoryView.frame;
    accessoryViewFrame.origin.x = CGRectGetWidth(self.bounds) - CGRectGetWidth(accessoryViewFrame);
    accessoryViewFrame.origin.y = -5;
    self.accessoryView.frame = accessoryViewFrame;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self =   [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
