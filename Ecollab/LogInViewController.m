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
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    
    [EmailTextField setDelegate:self];
    [PasswordTextField setDelegate:self];
    
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

- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.view endEditing:YES];
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
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -65.0f;  //set the -215.0f to your required value
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

- (IBAction)SignInBtnAction:(id)sender {
    
    if ([EmailTextField.text isEqualToString:@""]||[PasswordTextField.text isEqualToString:@""]){
        // shwo an alert //Fields Can't Be Empty//
    }else if (![[DetailsManager sharedManager] validEmail:EmailTextField.text]) {
        // shwo an alert @"Invalid Email ID. Please Try Again"
        PasswordTextField.text=@"";
    }else{
        //NSMutableDictionary *inputDick = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"sivvalasanthu@gmail.com",@"EmailID",@"Gvkbio@123",@"Password",@"0",@"ISGvkEmployee", nil];
        //NSMutableDictionary *inputDick = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"sudheer.addala@gmail.com",@"EmailID",@"Gvkbio@12",@"Password",@"0",@"ISGvkEmployee", nil];
        NSMutableDictionary *inputDick =[NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",EmailTextField.text],@"EmailID",[NSString stringWithFormat:@"%@",PasswordTextField.text],@"Password",@"0",@"ISGvkEmployee", nil];
    
        ServiceRequester *request = [ServiceRequester new];
        request.serviceRequesterDelegate =  self;
        [request requestForLoginService:inputDick];
        request =  nil;
    }
}
//login request recived with a dictionary of data
-(void)requestReceivedLoginResponce:(NSMutableDictionary *)aregistrationDict{
    
    NSLog(@"%@",aregistrationDict);
    NSMutableArray *arr = [aregistrationDict objectForKey:@"Login"];
    NSDictionary *dic = [arr objectAtIndex:0];
    NSLog(@"%@",[dic objectForKey:@"SuccessCode"]);
    
    if([[dic objectForKey:@"SuccessCode"] intValue]!= 200)
    {
        //SuccessString = "Sorry, your login credentials are invalid.";
        PasswordTextField.text=@"";
    }else{
        
        [[[DetailsManager sharedManager]rID]setString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"RID"]]];
        
        DashboardViewController *DVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
        DVCtrlObj.userData = aregistrationDict;
        [self.navigationController pushViewController:DVCtrlObj animated:YES];
    
    }
}


- (IBAction)NewUserBtnAction:(id)sender {
    NewUserViewController *NUVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewUserViewController"];
    [self.navigationController pushViewController:NUVCtrlObj animated:YES];
}

- (IBAction)ForgotPassworBtnAction:(id)sender {
    ForgotPasswordViewController *FPVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ForgotPasswordViewController"];
    [self.navigationController pushViewController:FPVCtrlObj animated:YES];
}

/*
 - (void)viewDidLoad
 
 - (void)viewWillAppear:(BOOL)animated
 
 - (void)viewDidAppear:(BOOL)animated
 
 - (void)viewWillDisappear:(BOOL)animated
 
 - (void)viewDidDisappear:(BOOL)animated
 
 - (void)viewDidUnload

 */
@end
