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
    [FirstNameTextField setDelegate:self];
    [LastNameTextField setDelegate:self];
    [EmailAddressTextField setDelegate:self];
    [PasswordTextField setDelegate:self];
    [ConfirmPasswordTextField setDelegate:self];
    [CompanyNameTextField setDelegate:self];
    [DesignationTextField setDelegate:self];
    textfieldTag=0;
    [self designNavBar];
    
}
-(void)designNavBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1.0];
    
    UIImageView *imgLogoGVK = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    imgLogoGVK.backgroundColor = [UIColor clearColor];
    imgLogoGVK.image = [UIImage imageNamed:@"gvklogo1.png"];
    imgLogoGVK.contentMode = UIViewContentModeScaleAspectFit;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:imgLogoGVK];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(0, 0, 80, 44);
    btnBack.backgroundColor = [UIColor clearColor];
    [btnBack setTitle:@"  SIGN UP" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBack setImage:[UIImage imageNamed:@"btnBack.png"] forState:UIControlStateNormal];
    btnBack.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnBack addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
 
    UIView *vwLeftItem = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 44)];
    vwLeftItem.backgroundColor = [UIColor clearColor];
    [vwLeftItem addSubview:btnBack];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:vwLeftItem];
    self.navigationItem.leftBarButtonItem = leftBtn;

    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == FirstNameTextField || textField == LastNameTextField)
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength == 20)
        {
            if (textField == FirstNameTextField)
            {
            [self showAlertWithMessage:@"First name should be less than 20 characters."];
            }
            else
            {
                [self showAlertWithMessage:@"Last name should be less than 20 characters."];
            }
        }
        return newLength <= 20;
    }
    return YES;
}

- (void)btnBackClicked:(UIButton*)sender {
    [self.view endEditing:YES];
    [FirstNameTextField resignFirstResponder];
    [LastNameTextField resignFirstResponder];
    [EmailAddressTextField resignFirstResponder];
    [PasswordTextField resignFirstResponder];
    [ConfirmPasswordTextField resignFirstResponder];
    [CompanyNameTextField resignFirstResponder];
    [DesignationTextField resignFirstResponder];

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    _scrlVwNewUser.contentSize = CGSizeMake(_scrlVwNewUser.frame.size.width, 611);
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

#pragma mark - keyboard movements
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    textfieldTag=textField.tag;
    return YES;
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
    [self.view endEditing:YES];
    [FirstNameTextField resignFirstResponder];
    [LastNameTextField resignFirstResponder];
    [EmailAddressTextField resignFirstResponder];
    [PasswordTextField resignFirstResponder];
    [ConfirmPasswordTextField resignFirstResponder];
    [CompanyNameTextField resignFirstResponder];
    [DesignationTextField resignFirstResponder];

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
        [self showAlertWithMessage:@"Please enter confirm password."];
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
        [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
        ServiceRequester *request = [ServiceRequester new];
        request.serviceRequesterDelegate =  self;
        [request requestForopCreatedUserService:inputDick];
        request =  nil;

    }
}
-(void)requestReceivedopCreatedUserResponce:(NSMutableDictionary *)aregistrationDict{
            NSLog(@"%@",aregistrationDict);
    NSMutableArray *arr = [aregistrationDict objectForKey:@"CreateUserList"];
    NSDictionary *dic = [arr objectAtIndex:0];
    NSLog(@"%@",[dic objectForKey:@"SuccessCode"]);
    [EcollabLoader hideLoaderForView:self.view animated:YES];
   
    if([[dic objectForKey:@"SuccessCode"] intValue]!= 200)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                       message:[dic objectForKey:@"SuccessString"]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];

        PasswordTextField.text=@"";
    }else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                       message:@"Account created successfully. Please activate your account by following the link sent at your mail id."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];

        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];

    }
}
@end
