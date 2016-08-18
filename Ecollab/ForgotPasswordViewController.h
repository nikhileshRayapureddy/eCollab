//
//  ForgotPasswordViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 11/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsManager.h"
#import "ServiceRequester.h"
@interface ForgotPasswordViewController : UIViewController<UITextFieldDelegate,ServiceRequesterProtocol>

@property (strong, nonatomic) IBOutlet UITextField *ForgotPasswordTextField;
@property (strong, nonatomic) IBOutlet UIButton *SubmitBtnOutlet;

- (IBAction)SubmitBtnAction:(id)sender;

@end
