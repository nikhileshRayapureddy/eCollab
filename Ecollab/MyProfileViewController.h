//
//  MyProfileViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShippingInformationViewController.h"
#import "DisclaimerViewController.h"
#import "AboutUsViewController.h"
#import "ChangePasswordViewController.h"
#import "ServiceRequester.h"
#import "BaseViewController.h"

@interface MyProfileViewController : BaseViewController<ServiceRequesterProtocol,UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    NSString *b64EncStr;

}
@property (strong, nonatomic) IBOutlet UIButton *ProfileImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrlVwProfile;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfileBg;


@property (weak, nonatomic) IBOutlet UITextField *txtFldFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtFldComapnyName;
@property (weak, nonatomic) IBOutlet UITextField *txtFldDesignation;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;



@property (strong, nonatomic) IBOutlet UIButton *editPersonalDetailOutlet;
@property (strong, nonatomic) IBOutlet UIButton *ChangePasswordBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *ShippingAddressBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *DisclimerBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *AboutUsBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *LogoutBtnOutlet;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveProfile;
@property (weak, nonatomic) IBOutlet UIView *vwFirstNam;
@property (weak, nonatomic) IBOutlet UIView *vwLastName;
@property (weak, nonatomic) IBOutlet UIView *vwEmailId;
@property (weak, nonatomic) IBOutlet UIView *vwCompanyName;
@property (weak, nonatomic) IBOutlet UIView *vwDesignation;

- (IBAction)btnSaveProfileClicked:(UIButton *)sender;

- (IBAction)ChangePasswordBtnAction:(id)sender;
- (IBAction)ShippingAddressBtnAction:(id)sender;
- (IBAction)DisclimerBtnAction:(id)sender;
- (IBAction)AboutUsBtnAction:(id)sender;
- (IBAction)LogoutBtnAction:(id)sender;
- (IBAction)btnProfileImageClicked:(UIButton *)sender;

- (IBAction)btnBackClicked:(UIButton *)sender;

@end
