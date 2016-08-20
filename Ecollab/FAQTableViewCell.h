//
//  FAQTableViewCell.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 23/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface FAQTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *vwTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnArr;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIView *vwDetail;
@property (weak, nonatomic) IBOutlet UIButton *btnDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constHeightVwTitle;

@end
