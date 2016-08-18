//
//  RequestOrProjectTrackerViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestOrProjectTableViewCell.h"
#import "ServiceRequester.h"
#import "TrackingStatusViewController.h"
@interface RequestOrProjectTrackerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceRequesterProtocol>
@property (strong, nonatomic) IBOutlet UITableView *RequestOrProjectTableView;
@property (strong, nonatomic) IBOutlet UIButton *RequestedQuotesBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *OnGoingProjectsBtnOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *StatusIMGOne;
@property (strong, nonatomic) IBOutlet UIImageView *StatusIMGTwo;
@property (strong, nonatomic) IBOutlet UIImageView *StatusIMGThree;
@property (strong, nonatomic) IBOutlet UIImageView *StatusIMGFour;
@property (strong, nonatomic) IBOutlet UILabel *QuotationProcessOrProjectsCycleLabel;
@property (strong, nonatomic) IBOutlet UILabel *StatusLabelOne;
@property (strong, nonatomic) IBOutlet UILabel *StatusLabelTwo;
@property (strong, nonatomic) IBOutlet UILabel *StatusLabelThree;
@property (strong, nonatomic) IBOutlet UILabel *StatusLabelFour;
- (IBAction)RequestedQuotesBtnAction:(id)sender;
- (IBAction)OnGoingProjectsBtnAction:(id)sender;

@end
