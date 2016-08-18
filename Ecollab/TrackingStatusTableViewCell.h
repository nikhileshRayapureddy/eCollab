//
//  TrackingStatusTableViewCell.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrackingStatusTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *StatusImage;
@property (strong, nonatomic) IBOutlet UILabel *StatusLabel;
@property (strong, nonatomic) IBOutlet UILabel *StatusTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *StatusProcessIndecatorLabel;

@end
