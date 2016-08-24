//
//  ForgotPasswordViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 11/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "ForgotPasswordViewController.h"

@interface ForgotPasswordViewController (){

}

@end

@implementation ForgotPasswordViewController
@synthesize ForgotPasswordTextField,SubmitBtnOutlet;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    btnBack.frame = CGRectMake(0, 0, 180, 44);
    btnBack.backgroundColor = [UIColor clearColor];
    [btnBack setTitle:@"  FORGOT PASSWORD" forState:UIControlStateNormal];
    [btnBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBack setImage:[UIImage imageNamed:@"btnBack.png"] forState:UIControlStateNormal];
    btnBack.titleLabel.font = [UIFont systemFontOfSize:15];
    [btnBack addTarget:self action:@selector(btnBackClicked:) forControlEvents:UIControlEventTouchUpInside];
    btnBack.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIView *vwLeftItem = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 180, 44)];
    vwLeftItem.backgroundColor = [UIColor clearColor];
    [vwLeftItem addSubview:btnBack];
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithCustomView:vwLeftItem];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    
}
- (void)btnBackClicked:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requestReceivedopForgotPasswordResponce:(NSMutableDictionary *)aregistrationDict{
    [EcollabLoader hideLoaderForView:self.view animated:YES];
      NSLog(@"%@",aregistrationDict);
    NSString *messageString=[aregistrationDict objectForKey:@"SuccessString"];
    // Check email validation
    if ([[aregistrationDict objectForKey:@"SuccessCode"]intValue] != 200) {
        [self showAlertWithMessage:messageString];
        ForgotPasswordTextField.text=@"";
    }
    else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                       message:@"Password has been sent successfully to your registered email."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        

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

- (IBAction)SubmitBtnAction:(id)sender {
    [ForgotPasswordTextField resignFirstResponder];
    if ([ForgotPasswordTextField.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please enter email address."];
    }
    else if (![[DetailsManager sharedManager] validEmail:ForgotPasswordTextField.text])
    {
        [self showAlertWithMessage:@"Please enter a valid email address."];
        ForgotPasswordTextField.text=@"";
    }else{
        [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
        ServiceRequester *request = [ServiceRequester new];
        request.serviceRequesterDelegate =  self;
        [request requestForopForgotPassword:ForgotPasswordTextField.text];
        request =  nil;
    }
}
@end
