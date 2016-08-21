//
//  NewUserViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 11/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "NewUserViewController.h"
@interface NewUserViewController (){
    NSInteger textfieldTag;
}

@end

@implementation NewUserViewController
@synthesize FirstNameTextField,LastNameTextField,EmailAddressTextField,PasswordTextField,CompanyNameTextField,DesignationTextField,SignUpBtnOutlet,ConfirmPasswordTextField;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    [FirstNameTextField setDelegate:self];
    [LastNameTextField setDelegate:self];
    [EmailAddressTextField setDelegate:self];
    [PasswordTextField setDelegate:self];
    [ConfirmPasswordTextField setDelegate:self];
    [CompanyNameTextField setDelegate:self];
    [DesignationTextField setDelegate:self];
    textfieldTag=0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Keyboard hiding when user clicked on anywhere in the view
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
// Called when the view is about to made visible. Default does nothing
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    if(textfieldTag >= 50){
        [UIView animateWithDuration:0.3 animations:^{
            CGRect f = self.view.frame;
            f.origin.y = -150.0f;  //set the -215.0f to your required value
            self.view.frame = f;
        }];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textfieldTag=textField.tag;
    return YES;
}
-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;//64.0f
        self.view.frame = f;
    }];
}
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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

- (IBAction)SignUpBtnAction:(id)sender {
    
    if([FirstNameTextField.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please enter first name."];
    }
    else if ([LastNameTextField.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please enter last name."];
    }
    else if ([EmailAddressTextField.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please enter email address."];
    }
    else if (![[DetailsManager sharedManager] validEmail:EmailAddressTextField.text])
    {
        [self showAlertWithMessage:@"Please enter valid email address."];
        EmailAddressTextField.text=@"";
    }
    else if ([PasswordTextField.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please enter password."];
    }
    else if (PasswordTextField.text.length < 8)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if (PasswordTextField.text.length > 12)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if ([ConfirmPasswordTextField.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please enter confirm password. Or Enter confirm password."];
    }
    else if (ConfirmPasswordTextField.text.length < 8)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if(ConfirmPasswordTextField.text.length > 12)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if (![PasswordTextField.text isEqualToString:ConfirmPasswordTextField.text])
    {
        [self showAlertWithMessage:@"Password and Confirm Password does not match."];
        PasswordTextField.text=@"";
        ConfirmPasswordTextField.text=@"";
    }
    else
    {
        NSMutableDictionary *inputDick = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",FirstNameTextField.text],@"FirstName",[NSString stringWithFormat:@"%@",LastNameTextField.text],@"LastName",[NSString stringWithFormat:@"%@",EmailAddressTextField.text],@"EmailID",[NSString stringWithFormat:@"%@",PasswordTextField.text],@"Password",[NSString stringWithFormat:@"%@",ConfirmPasswordTextField.text],@"ConfirmPassword",[NSString stringWithFormat:@"%@",CompanyNameTextField.text],@"CompanyName",[NSString stringWithFormat:@"%@",DesignationTextField.text],@"Designation",@"1",@"CreatedBy",@"0",@"ISMobileUser",@"0",@"ISGvkEmployee",@"A1J2C3",@"RefaralCode", nil];
        
        ServiceRequester *request = [ServiceRequester new];
        request.serviceRequesterDelegate =  self;
        [request requestForopCreatedUserService:inputDick];
        request =  nil;

    }
    
//    if ([FirstNameTextField.text isEqualToString:@""]||[LastNameTextField.text isEqualToString:@""]||[EmailAddressTextField.text isEqualToString:@""]||[PasswordTextField.text isEqualToString:@""]||[ConfirmPasswordTextField.text isEqualToString:@""]||[CompanyNameTextField.text isEqualToString:@""]||[DesignationTextField.text isEqualToString:@""]) {
//        //show @"Please Enter All Fields"
//    }
//    if (![[DetailsManager sharedManager] validEmail:EmailAddressTextField.text]) {
//        // show @"Enter Valid Email Id"
//        EmailAddressTextField.text=@"";
//    }else if (![ConfirmPasswordTextField.text isEqualToString:PasswordTextField.text])
//    {
////show @"Password and Confrim Password Are Not Same"
//        PasswordTextField.text=@"";
//        ConfirmPasswordTextField.text=@"";
//    }else{
//    
//    }
}
-(void)requestReceivedopCreatedUserResponce:(NSMutableDictionary *)aregistrationDict{
            NSLog(@"%@",aregistrationDict);
    NSMutableArray *arr = [aregistrationDict objectForKey:@"CreateUserList"];
    NSDictionary *dic = [arr objectAtIndex:0];
    NSLog(@"%@",[dic objectForKey:@"SuccessCode"]);
    
    if([[dic objectForKey:@"SuccessCode"] intValue]!= 200)
    {
        //SuccessString = "Sorry, your login credentials are invalid.";
        PasswordTextField.text=@"";
    }else{
//        DashboardViewController *DVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
//        [self.navigationController pushViewController:DVCtrlObj animated:YES];
        
        // show alert controller and navigate user to login view controller
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
