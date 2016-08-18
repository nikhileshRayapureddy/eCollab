//
//  AddNewShippingAddressViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 17/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceRequester.h"
@interface AddNewShippingAddressViewController : UIViewController<ServiceRequesterProtocol>
@property (strong, nonatomic) IBOutlet UITextField *Name;
@property (strong, nonatomic) IBOutlet UITextField *Pincode;
@property (strong, nonatomic) IBOutlet UITextField *Address;
@property (strong, nonatomic) IBOutlet UITextField *AddressOne;
@property (strong, nonatomic) IBOutlet UITextField *City;

@property (strong, nonatomic) IBOutlet UITextField *State;
@property (strong, nonatomic) IBOutlet UITextField *Country;
@property (strong, nonatomic) IBOutlet UITextField *Phone;

@property (strong, nonatomic) IBOutlet UITextField *Landmark;
@property (strong, nonatomic) IBOutlet UIButton *SubmitOutlet;
- (IBAction)SubmitBtnAction:(id)sender;

@end
