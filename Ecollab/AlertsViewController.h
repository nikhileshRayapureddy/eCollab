//
//  AlertsViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlertsTableViewCell.h"
#import "ServiceRequester.h"
#import "NewBiologyRequestViewController.h"
#import "NewChemistryRequestViewController.h"
#import "TrackingStatusViewController.h"
#import "DiscussQuoteViewController.h"

@interface AlertsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ServiceRequesterProtocol>
{
    BOOL isRegretReject;
    NSString *strRequestRID;
}
@property (strong, nonatomic) IBOutlet UITableView *AlertsTableView;

@end
