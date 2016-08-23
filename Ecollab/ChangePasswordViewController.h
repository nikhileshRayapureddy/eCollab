//
//  ChangePasswordViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceRequester.h"
@interface ChangePasswordViewController : UIViewController<ServiceRequesterProtocol>
@property (strong, nonatomic) IBOutlet UITextField *oldPassword;
@property (strong, nonatomic) IBOutlet UITextField *NewPassword;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
@property (strong, nonatomic) IBOutlet UIButton *ChangePasswordOutlet;
@property (strong, nonatomic) IBOutlet UIButton *CancelOutlet;
- (IBAction)ChangePasswordAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *CancelPasswordAction;
- (IBAction)CancelPasswordClicked:(UIButton *)sender;

@end
