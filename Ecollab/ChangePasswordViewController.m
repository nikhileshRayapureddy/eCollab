//
//  ChangePasswordViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
@synthesize oldPassword,NewPassword,confirmPassword,ChangePasswordOutlet,CancelOutlet;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self designNavBar];
}
-(void)designNavBar
{
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:237.0/255.0 green:27.0/255.0 blue:36.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *imgLogoEcoLab = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    imgLogoEcoLab.backgroundColor = [UIColor clearColor];
    imgLogoEcoLab.image = [UIImage imageNamed:@"ecolablogo.png"];
    imgLogoEcoLab.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = imgLogoEcoLab;
    
    UIImageView *imgLogoGVK = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    imgLogoGVK.backgroundColor = [UIColor clearColor];
    imgLogoGVK.image = [UIImage imageNamed:@"gvk_whitelogo1.png"];
    imgLogoGVK.contentMode = UIViewContentModeScaleAspectFit;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:imgLogoGVK];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestReceivedopChangePasswordResponce:(NSMutableDictionary *)aregistrationDict{
    // show a message success or not
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    
    if ([[aregistrationDict objectForKey:@"SuccessCode"]intValue] != 200) {
        
        [self showAlertWithMessage:[aregistrationDict objectForKey:@"SuccessString"]];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                       message:[aregistrationDict objectForKey:@"SuccessString"]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}


- (IBAction)ChangePasswordAction:(id)sender {
    
    [oldPassword resignFirstResponder];
    [NewPassword resignFirstResponder];
    [confirmPassword resignFirstResponder];
    if ([oldPassword.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Enter old password."];
    }
    else if (oldPassword.text.length < 8)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if (oldPassword.text.length > 12)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if ([NewPassword.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Enter new password."];
    }
    else if (NewPassword.text.length < 8)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if (NewPassword.text.length > 12)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if ([confirmPassword.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Enter confirm password."];
    }
    else if (confirmPassword.text.length < 8)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if (confirmPassword.text.length > 12)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if (![NewPassword.text isEqualToString:confirmPassword.text])
    {
        [self showAlertWithMessage:@"Old Password and new password doesn't match."];
    }
    else{
        [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];

        NSMutableDictionary *ChangePasswordDict = [NSMutableDictionary new];
        ChangePasswordDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[DetailsManager sharedManager]rID],@"UID",oldPassword.text,@"OldPassword",confirmPassword.text,@"CPassword",NewPassword.text,@"Password",nil];
        if ([confirmPassword.text isEqualToString:NewPassword.text])
        {
            ServiceRequester *request = [ServiceRequester new];
            request.serviceRequesterDelegate = self;
            [request requestForopChangePasswordService:ChangePasswordDict];
            request = nil;
        }
    }
}

-(void)showAlertWithMessage:(NSString*)strMsg
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                   message:strMsg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)CancelPasswordClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
@end
