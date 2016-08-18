//
//  EditPersonalDetailsViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "EditPersonalDetailsViewController.h"

@interface EditPersonalDetailsViewController ()

@end

@implementation EditPersonalDetailsViewController
@synthesize FirstNameTF,LastNameTF,EmailTF,CompanyNameTF,SaveBtnOutlet,userDataDict,DesignationTF;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    NSLog(@"%@",userDataDict);
    FirstNameTF.text = [userDataDict objectForKey:@"FirstName"];
    LastNameTF.text = [userDataDict objectForKey:@"LastName"];
    EmailTF.text = [userDataDict objectForKey:@"EmailID"];
    CompanyNameTF.text = [userDataDict objectForKey:@"CompanyName"];
    DesignationTF.text = [userDataDict objectForKey:@"Designation"];
}
-(void)requestReceivedopSaveUserDetailsResponce:(NSMutableDictionary *)aregistrationDict{
    // show a message success or not
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SavebtnAction:(id)sender {
    if (![FirstNameTF.text isEqualToString:@""]) {
        [userDataDict setObject:FirstNameTF.text forKey:@"FirstName"];
    }
    if (![LastNameTF.text isEqualToString:@""]){
        [userDataDict setObject:LastNameTF.text forKey:@"LastName"];
    }
    if (![EmailTF.text isEqualToString:@""]){
        [userDataDict setObject:EmailTF.text forKey:@"EmailID"];
    }
    if (![CompanyNameTF.text isEqualToString:@""]){
        [userDataDict setObject:CompanyNameTF.text forKey:@"CompanyName"];
    }
    if (![DesignationTF.text isEqualToString:@""]){
        [userDataDict setObject:DesignationTF.text forKey:@"Designation"];
    }
    [userDataDict setObject:@"0" forKey:@"ISMobileUser"];
    //ISGvkEmployee
    [userDataDict setObject:@"0" forKey:@"ISGvkEmployee"];

    
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopSaveUserDetailsService:userDataDict];
    request =  nil;

}
@end
