//
//  ChangePasswordViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceRequester.h"
#import "BaseViewController.h"
@interface ChangePasswordViewController : BaseViewController<ServiceRequesterProtocol>
@property (weak, nonatomic) IBOutlet UIScrollView *scrlVwChangePwd;

@property (strong, nonatomic) IBOutlet UITextField *oldPassword;
@property (strong, nonatomic) IBOutlet UITextField *NewPassword;
@property (strong, nonatomic) IBOutlet UITextField *confirmPassword;
@property (strong, nonatomic) IBOutlet UIButton *ChangePasswordOutlet;
@property (strong, nonatomic) IBOutlet UIButton *CancelOutlet;
- (IBAction)ChangePasswordAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *CancelPasswordAction;
- (IBAction)CancelPasswordClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *vwNewPwdStrenngth;
@property (weak, nonatomic) IBOutlet UILabel *lblNewPwdStrenngth;
@property (weak, nonatomic) IBOutlet UIView *vwCNFNewPwdStrenngth;
@property (weak, nonatomic) IBOutlet UILabel *lblCNFNewPwdStrenngth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conslblNewPwdStrenngthHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constlblCNFNewPwdStrenngthHeight;

- (IBAction)btnBackClicked:(UIButton *)sender;

@end
