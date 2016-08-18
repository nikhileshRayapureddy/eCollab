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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestReceivedopChangePasswordResponce:(NSMutableDictionary *)aregistrationDict{
    // show a message success or not
    [self.navigationController popViewControllerAnimated:YES];

}


- (IBAction)ChangePasswordAction:(id)sender {
    if ([oldPassword.text isEqualToString:@""]||[NewPassword.text isEqualToString:@""]||[confirmPassword.text isEqualToString:@""]) {
        //show an alert
    }else{
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
@end
