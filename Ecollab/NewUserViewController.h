//
//  NewUserViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 11/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsManager.h"
#import "DashboardViewController.h"
#import "ServiceRequester.h"
@interface NewUserViewController : UIViewController<UITextFieldDelegate,ServiceRequesterProtocol>
@property (strong, nonatomic) IBOutlet UITextField *FirstNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *LastNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *EmailAddressTextField;
@property (strong, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *ConfirmPasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *CompanyNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *DesignationTextField;
@property (strong, nonatomic) IBOutlet UIButton *SignUpBtnOutlet;
- (IBAction)SignUpBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrlVwNewUser;




@end
