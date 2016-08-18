//
//  LogInViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 10/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ForgotPasswordViewController.h"
#import "NewUserViewController.h"
#import "DashboardViewController.h"
#import "DetailsManager.h"
#import "ServiceRequester.h"
@interface LogInViewController : UIViewController<UITextFieldDelegate,ServiceRequesterProtocol>
@property (strong, nonatomic) IBOutlet UITextField *PasswordTextField;
@property (strong, nonatomic) IBOutlet UITextField *EmailTextField;
@property (strong, nonatomic) IBOutlet UIButton *SignInBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *NewUserBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *ForgotPasswordBtnOutlet;




- (IBAction)SignInBtnAction:(id)sender;
- (IBAction)NewUserBtnAction:(id)sender;
- (IBAction)ForgotPassworBtnAction:(id)sender;












@end
