//
//  TrackingStatusViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackingStatusTableViewCell.h"
#import "StatusViewModeViewController.h"
#import "ServiceRequester.h"
#import "NewChemistryRequestViewController.h"
#import "NewBiologyRequestViewController.h"
#import "DiscussQuoteViewController.h"
@interface TrackingStatusViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ServiceRequesterProtocol>
{
    BOOL rejectOrRegrett;
    NSString *strRequestRID;
}
@property (strong, nonatomic) IBOutlet UITableView *StatusTableview;
@property (strong, nonatomic) NSMutableDictionary *MainDataDictionary;
@property (strong, nonatomic) NSMutableString *ItemType;
@property (weak, nonatomic) IBOutlet UIImageView *imgRequestLogo;
@property (weak, nonatomic) IBOutlet UILabel *lblRequestNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIImageView *imgRightArrow;

@end
