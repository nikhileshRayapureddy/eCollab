//
//  MyProfileViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController (){
    NSDictionary *dic;
}

@end

@implementation MyProfileViewController
@synthesize NameLabel,ProfileImage,EmailLabel,FirstNameLabel,LastNameLabel,EmailAddressLabel,DesignationLabel,CompanyNameLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    //ProfileImage
    [ProfileImage.layer setBorderWidth: 1.0];
    [ProfileImage.layer setCornerRadius:70.f];//((ProfileImage.frame.size.width)/2)
    [ProfileImage.layer setMasksToBounds:YES];
    [ProfileImage.layer setBorderColor:[[UIColor blackColor] CGColor]];

    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopGetUserDetailsService];
    request =  nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requestReceivedopGetUserDetailsResponce:(NSMutableDictionary *)aregistrationDict{
    NSMutableArray *arr = [aregistrationDict objectForKey:@"GetUserDetailsResult"];
    dic = [arr objectAtIndex:0];
    NSLog(@"%@",[dic objectForKey:@"SuccessCode"]);
    
    if([[dic objectForKey:@"SuccessCode"] intValue]!= 200)
    {
        // show some message unable to get usre details
    }else{
        NameLabel.text = [dic objectForKey:@"FirstName"];
        EmailLabel.text = [dic objectForKey:@"EmailID"];
        FirstNameLabel.text = [dic objectForKey:@"FirstName"];
        LastNameLabel.text =[dic objectForKey:@"LastName"];
        EmailAddressLabel.text =[dic objectForKey:@"EmailID"];
        DesignationLabel.text =[dic objectForKey:@"Designation"];
        CompanyNameLabel.text = [dic objectForKey:@"CompanyName"];
        
        NSMutableString *base64String = [NSMutableString stringWithFormat:@"%@",[dic objectForKey:@"Image"]];
        NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
        if(data != nil)
        {
            [ProfileImage setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
        }
    }

}
- (IBAction)editPersonalDetailAction:(id)sender {
    EditPersonalDetailsViewController *EPDVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"EditPersonalDetailsViewController"];
    EPDVCtrlObj.userDataDict = [dic mutableCopy];
    [self.navigationController pushViewController:EPDVCtrlObj animated:YES];
}

- (IBAction)ChangePasswordBtnAction:(id)sender {
    ChangePasswordViewController *CPVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePasswordViewController"];
    [self.navigationController pushViewController:CPVCtrlObj animated:YES];
}

- (IBAction)ShippingAddressBtnAction:(id)sender {
    ShippingInformationViewController *SIVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ShippingInformationViewController"];
    [self.navigationController pushViewController:SIVCtrlObj animated:YES];
}

- (IBAction)DisclimerBtnAction:(id)sender {
    DisclaimerViewController *DVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"DisclaimerViewController"];
    [self.navigationController pushViewController:DVCtrlObj animated:YES];
}

- (IBAction)AboutUsBtnAction:(id)sender {
    AboutUsViewController *AUVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
    [self.navigationController pushViewController:AUVCtrlObj animated:YES];
}

- (IBAction)LogoutBtnAction:(id)sender {
    [self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:1] animated:YES];

}
@end
