//
//  DashboardViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 11/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReachUsViewController.h"
#import "AlertsViewController.h"
#import "SavedRequestsViewController.h"
#import "FAQVCViewController.h"
#import "MenuProfileTableViewCell.h"
#import "MenuLableTableViewCell.h"
#import "DetailsManager.h"
#import "SignOutTableViewCell.h"
#import "DisclaimerViewController.h"
#import "RequestAQuoteViewController.h"
#import "SavedRequestsViewController.h"
#import "RequestOrProjectTrackerViewController.h"
#import "MyProfileViewController.h"
#import "BaseViewController.h"
@interface DashboardViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *RequestAQuoteBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *RequesterOrProjectTrackerBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *SavedRequestsBtnOutlet;

@property (strong, nonatomic) IBOutlet UIButton *MyProfileBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *ReachUsBtnOutlet;

@property (strong, nonatomic) IBOutlet UIButton *AlertsBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *FAQBtnOutlet;

- (IBAction)RequestAQuoteBtnAction:(id)sender;
- (IBAction)RequesterOrProjectTrackerBtnAction:(id)sender;
- (IBAction)SavedRequestsBtnAction:(id)sender;
- (IBAction)MyProfileBtnAction:(id)sender;
- (IBAction)ReachUsBtnAction:(id)sender;
- (IBAction)AlertsBtnAction:(id)sender;
- (IBAction)FAQBtnAction:(id)sender;

@end
