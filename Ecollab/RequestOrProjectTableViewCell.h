//
//  RequestOrProjectTableViewCell.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 23/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestOrProjectTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *RequestOrProjectStatusLabel;
@property (strong, nonatomic) IBOutlet UIImageView *RequestOrProjectType;
@property (strong, nonatomic) IBOutlet UILabel *RequestOrProjectNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *RequestOrProjectIDLabel;
@property (strong, nonatomic) IBOutlet UIImageView *StatuImageOne;
@property (strong, nonatomic) IBOutlet UIImageView *StatusImageTwo;
@property (strong, nonatomic) IBOutlet UIImageView *StatusImageThree;
@property (strong, nonatomic) IBOutlet UIImageView *StatusImageFour;

@property (strong, nonatomic) IBOutlet UILabel *StatusLabelOne;
@property (strong, nonatomic) IBOutlet UILabel *StatusLabelTwo;
@property (strong, nonatomic) IBOutlet UILabel *StatusLabelThree;

@property (strong, nonatomic) IBOutlet UILabel *StatusStageOneLabel;
@property (strong, nonatomic) IBOutlet UILabel *StatusStageTwoLabel;
@property (strong, nonatomic) IBOutlet UILabel *StatusStageThreeLabel;
@property (strong, nonatomic) IBOutlet UILabel *StatusStageFourLabel;
//StatusImagethree
@end
