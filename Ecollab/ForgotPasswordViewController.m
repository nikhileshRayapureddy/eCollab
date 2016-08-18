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
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];

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
        // show an alert with messageString
        ForgotPasswordTextField.text=@"";
    }
    else{
        // show alert controller and navigate user to login view controller
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (IBAction)SubmitBtnAction:(id)sender {
    if ([ForgotPasswordTextField.text isEqualToString:@""]){
        // show alert pwd not empy
    }else if (![[DetailsManager sharedManager] validEmail:ForgotPasswordTextField.text]) {
        //show an alert @"Invalid Email ID. Please Try Again"
        ForgotPasswordTextField.text=@"";
    }else{
        ServiceRequester *request = [ServiceRequester new];
        request.serviceRequesterDelegate =  self;
        [request requestForopForgotPassword:@"sudheer.addala@gmail.com"];
        request =  nil;
    }
}
@end