//
//  AlertsTableViewCell.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertsTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *ProjectNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *PojectStatuLabel;

@property (strong, nonatomic) IBOutlet UIImageView *ProjectTypeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imgRightArrow;

@end
