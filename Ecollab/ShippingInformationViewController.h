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
#import "BaseViewController.h"
@interface ShippingInformationViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,ServiceRequesterProtocol>
{
    NSDictionary *dictDefaultAddressSelected;
}
@property (strong, nonatomic) IBOutlet UITableView *ShippingInformationTableview;
@property (strong, nonatomic) IBOutlet UIButton *AddNewAddressOutlet;
@property (strong, nonatomic) NSString *strRequestRID;
- (IBAction)AddNewAddressBtnAction:(id)sender;

@property (assign, nonatomic) BOOL isFromTracking;
- (IBAction)btnBackClicked:(UIButton *)sender;

@end
