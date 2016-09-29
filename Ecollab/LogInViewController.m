//
//  LogInViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 10/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "LogInViewController.h"


@interface LogInViewController ()
{
}
@end

@implementation LogInViewController
@synthesize EmailTextField,PasswordTextField,SignInBtnOutlet,NewUserBtnOutlet,ForgotPasswordBtnOutlet;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [EmailTextField setDelegate:self];
    [PasswordTextField setDelegate:self];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    EmailTextField.text = @"p.venkat.it@gmail.com";
//    PasswordTextField.text =@"Gvkbio@1";
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.view endEditing:YES];
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

- (IBAction)SignInBtnAction:(id)sender {
    [self.view endEditing:YES];
    [EmailTextField resignFirstResponder];
    [PasswordTextField resignFirstResponder];

    if ([EmailTextField.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please enter email address."];
    }
    else if (![[DetailsManager sharedManager] validEmail:EmailTextField.text])
    {
        [self showAlertWithMessage:@"Please enter valid email address."];
        PasswordTextField.text=@"";
    }
    else if([PasswordTextField.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please enter password."];
    }
    else
    {
        NSMutableDictionary *inputDick =[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",EmailTextField.text],@"EmailID",[NSString stringWithFormat:@"%@",PasswordTextField.text],@"Password",@"0",@"ISGvkEmployee", nil];
        [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
        ServiceRequester *request = [ServiceRequester new];
        request.serviceRequesterDelegate =  self;
        [request requestForLoginService:inputDick];
        request =  nil;
    }
}
//login request recived with a dictionary of data
-(void)requestReceivedLoginResponce:(NSMutableDictionary *)aregistrationDict{
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    NSLog(@"%@",aregistrationDict);
    NSMutableArray *arr = [aregistrationDict objectForKey:@"Login"];
    NSDictionary *dic = [arr objectAtIndex:0];
    NSLog(@"%@",[dic objectForKey:@"SuccessCode"]);
    
    if([[dic objectForKey:@"SuccessCode"] intValue]!= 200)
    {
        //SuccessString = "Sorry, your login credentials are invalid.";
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                       message:[dic objectForKey:@"SuccessString"]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];

        PasswordTextField.text=@"";
    }else{
        
        [[[DetailsManager sharedManager]rID]setString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"RID"]]];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"ISLOGGEDIN"];
        [[NSUserDefaults standardUserDefaults] setObject:aregistrationDict forKey:@"UserData"];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@",[dic objectForKey:@"RID"]] forKey:@"USERLOGGEDINID"];
        DashboardViewController *DVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
        DVCtrlObj.userData = aregistrationDict;
        [self.navigationController pushViewController:DVCtrlObj animated:YES];
    
    }
}


- (IBAction)NewUserBtnAction:(id)sender {
    [self.view endEditing:YES];
    [EmailTextField resignFirstResponder];
    [PasswordTextField resignFirstResponder];

    NewUserViewController *NUVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewUserViewController"];
    [self.navigationController pushViewController:NUVCtrlObj animated:YES];
}

- (IBAction)ForgotPassworBtnAction:(id)sender {
    [self.view endEditing:YES];
    [EmailTextField resignFirstResponder];
    [PasswordTextField resignFirstResponder];

    ForgotPasswordViewController *FPVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    [self.navigationController pushViewController:FPVCtrlObj animated:YES];
}
@end
