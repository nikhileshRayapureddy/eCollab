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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    [self designNavBar];
}
-(void)designNavBar
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
    
    UIImageView *imgLogoGVK = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
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
-(void)requestReceivedopForgotPasswordResponce:(NSMutableDictionary *)aregistrationDict{
      NSLog(@"%@",aregistrationDict);
    NSString *messageString=[aregistrationDict objectForKey:@"SuccessString"];
    // Check email validation
    if ([[aregistrationDict objectForKey:@"SuccessCode"]intValue] != 200) {
        [self showAlertWithMessage:messageString];
        ForgotPasswordTextField.text=@"";
    }
    else{
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                       message:messageString
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
    if ([ForgotPasswordTextField.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Please enter email address."];
    }
    else if (![[DetailsManager sharedManager] validEmail:ForgotPasswordTextField.text])
    {
        [self showAlertWithMessage:@"Please enter a valid email address."];
        ForgotPasswordTextField.text=@"";
    }else{
        ServiceRequester *request = [ServiceRequester new];
        request.serviceRequesterDelegate =  self;
        [request requestForopForgotPassword:ForgotPasswordTextField.text];
        request =  nil;
    }
}
@end
