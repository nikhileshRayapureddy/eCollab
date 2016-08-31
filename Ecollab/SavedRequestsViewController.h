//
//  SavedRequestsViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SavedRequestsTableViewCell.h"
#import "ServiceRequester.h"
#import "NewBiologyRequestViewController.h"
#import "NewChemistryRequestViewController.h"
#import "BaseViewController.h"

@interface SavedRequestsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,ServiceRequesterProtocol>
@property (strong, nonatomic) IBOutlet UITableView *SavedRequestsTableView;
- (IBAction)btnBackClicked:(UIButton *)sender;

@end
