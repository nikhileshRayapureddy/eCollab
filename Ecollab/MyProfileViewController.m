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
@synthesize scrlVwProfile,ProfileImage;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self designTabBar];
    [self setSelected:3];

    [ProfileImage.layer setBorderWidth: 1.0];
    [ProfileImage.layer setBorderColor:[[UIColor blackColor] CGColor]];
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];

    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopGetUserDetailsService];
    request =  nil;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self designNavBar];
}
-(void)designNavBar
{
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


-(void)viewDidLayoutSubviews
{
    scrlVwProfile.contentSize = CGSizeMake(scrlVwProfile.contentSize.width, 650);
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
        _lblUserName.text = [dic objectForKey:@"FirstName"];
        _lblEmail.text = [dic objectForKey:@"EmailID"];
        _txtFldFirstName.text = [dic objectForKey:@"FirstName"];
        _txtFldLastName.text =[dic objectForKey:@"LastName"];
        _txtFldEmail.text =[dic objectForKey:@"EmailID"];
        _txtFldDesignation.text =[dic objectForKey:@"Designation"];
        _txtFldComapnyName.text = [dic objectForKey:@"CompanyName"];
        
        NSMutableString *base64String = [NSMutableString stringWithFormat:@"%@",[dic objectForKey:@"Image"]];
        NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
        if(data != nil)
        {
            [ProfileImage setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
            self.imgProfileBg.image = [UIImage imageWithData:data];
        }
    }
    [EcollabLoader hideLoaderForView:self.view animated:YES];


}
- (IBAction)btnSaveProfileClicked:(UIButton *)sender {
    NSMutableDictionary *dictUser = [[NSMutableDictionary alloc]init];
    if (![_txtFldFirstName.text isEqualToString:@""]) {
        [dictUser setObject:_txtFldFirstName.text forKey:@"FirstName"];
    }
    if (![_txtFldLastName.text isEqualToString:@""]){
        [dictUser setObject:_txtFldLastName.text forKey:@"LastName"];
    }
    if (![_txtFldEmail.text isEqualToString:@""]){
        [dictUser setObject:_txtFldEmail.text forKey:@"EmailID"];
    }
    if (![_txtFldComapnyName.text isEqualToString:@""]){
        [dictUser setObject:_txtFldComapnyName.text forKey:@"CompanyName"];
    }
    if (![_txtFldDesignation.text isEqualToString:@""]){
        [dictUser setObject:_txtFldDesignation.text forKey:@"Designation"];
    }
    [dictUser setObject:@"0" forKey:@"ISMobileUser"];
    //ISGvkEmployee
    [dictUser setObject:@"0" forKey:@"ISGvkEmployee"];
    [dictUser setObject:[[DetailsManager sharedManager]rID] forKey:@"RID"];
    [dictUser setObject:@"" forKey:@"Image"];

    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopSaveUserDetailsService:dictUser];
    request =  nil;
}
-(void)requestReceivedopSaveUserDetailsResponce:(NSMutableDictionary *)aregistrationDict{
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                   message:@"Profile saved Successfully."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];

    // show a message success or not
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
