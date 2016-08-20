//
//  ShippingInformationViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShippingInformationTableViewCell.h"
#import "AddNewShippingAddressViewController.h"
@interface ShippingInformationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ServiceRequesterProtocol>
@property (strong, nonatomic) IBOutlet UITableView *ShippingInformationTableview;
@property (strong, nonatomic) IBOutlet UIButton *AddNewAddressOutlet;
- (IBAction)AddNewAddressBtnAction:(id)sender;

@property (assign, nonatomic) BOOL isFromTracking;

@end
