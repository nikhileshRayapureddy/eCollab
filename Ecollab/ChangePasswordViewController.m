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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestReceivedopChangePasswordResponce:(NSMutableDictionary *)aregistrationDict{
    // show a message success or not
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                   message:@"Password Changes Successfully."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];

    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];


}


- (IBAction)ChangePasswordAction:(id)sender {
    
    
    if ([oldPassword.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please enter old Password"];
    }
    else if ([NewPassword.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please enter New Password"];
    }
    else if ([confirmPassword.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please Re-enter New Password"];
    }
    else if (![NewPassword.text isEqualToString:confirmPassword.text])
    {
        [self showAlertWithMessage:@"Old Password and new password doesn't match."];
    }
    else{
        [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];

        NSMutableDictionary *ChangePasswordDict = [NSMutableDictionary new];
        ChangePasswordDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"UID",oldPassword.text,@"OldPassword",confirmPassword.text,@"CPassword",NewPassword.text,@"Password",nil];
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
@end
