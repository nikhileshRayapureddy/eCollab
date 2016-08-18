//
//  MyProfileViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditPersonalDetailsViewController.h"
#import "ShippingInformationViewController.h"
#import "DisclaimerViewController.h"
#import "AboutUsViewController.h"
#import "ChangePasswordViewController.h"
#import "ServiceRequester.h"
@interface MyProfileViewController : UIViewController<ServiceRequesterProtocol>
@property (strong, nonatomic) IBOutlet UIButton *ProfileImage;
@property (strong, nonatomic) IBOutlet UILabel *NameLabel;
@property (strong, nonatomic) IBOutlet UILabel *EmailLabel;
@property (strong, nonatomic) IBOutlet UILabel *FirstNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *LastNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *EmailAddressLabel;
@property (strong, nonatomic) IBOutlet UILabel *CompanyNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *DesignationLabel;





@property (strong, nonatomic) IBOutlet UIButton *editPersonalDetailOutlet;
@property (strong, nonatomic) IBOutlet UIButton *ChangePasswordBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *ShippingAddressBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *DisclimerBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *AboutUsBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *LogoutBtnOutlet;

- (IBAction)editPersonalDetailAction:(id)sender;
- (IBAction)ChangePasswordBtnAction:(id)sender;
- (IBAction)ShippingAddressBtnAction:(id)sender;
- (IBAction)DisclimerBtnAction:(id)sender;
- (IBAction)AboutUsBtnAction:(id)sender;
- (IBAction)LogoutBtnAction:(id)sender;


@end
