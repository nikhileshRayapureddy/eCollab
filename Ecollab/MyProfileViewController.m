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
    [self designNavBar];

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
        
        if (base64String && [base64String isEqualToString:@""])
        {
            [ProfileImage setBackgroundImage:[UIImage imageNamed:@"default_profile1.png"] forState:UIControlStateNormal];
            self.imgProfileBg.image = [UIImage imageNamed:@""];
        }
        else
        {
            [ProfileImage setBackgroundImage:[UIImage imageWithData:data] forState:UIControlStateNormal];
            self.imgProfileBg.image = [UIImage imageWithData:data];
        }
        NSMutableArray *arr = [[NSMutableArray alloc]initWithObjects:dic, nil];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:arr forKey:@"Login"];
        [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"UserData"];
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
    
    if(_txtFldFirstName.isFirstResponder)
    {
        [_txtFldFirstName resignFirstResponder];
    }
    if(_txtFldLastName.isFirstResponder)
    {
        [_txtFldLastName resignFirstResponder];
    }
    if(_txtFldComapnyName.isFirstResponder)
    {
        [_txtFldComapnyName resignFirstResponder];
    }
    if(_txtFldDesignation.isFirstResponder)
    {
        [_txtFldDesignation resignFirstResponder];
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
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                   message:@"Profile saved Successfully."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        ServiceRequester *request = [ServiceRequester new];
        request.serviceRequesterDelegate =  self;
        [request requestForopGetUserDetailsService];
        request =  nil;

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

- (IBAction)btnProfileImageClicked:(UIButton *)sender {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:@"Add Photo!"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* PhotoFromGalleryAction = [UIAlertAction actionWithTitle:@"Photo From Gallery" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                                                       picker.delegate = self;
                                                                       picker.allowsEditing = YES;
                                                                       picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                                       
                                                                       [self presentViewController:picker animated:YES completion:NULL];
                                                                       
                                                                       
                                                                   }];
    UIAlertAction* TakeAPhotoAction = [UIAlertAction actionWithTitle:@"Take A Photo" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 
                                                                 if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                                                     
                                                                     UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                                           message:@"Device has no camera"
                                                                                                                          delegate:nil
                                                                                                                 cancelButtonTitle:@"OK"
                                                                                                                 otherButtonTitles: nil];
                                                                     
                                                                     [myAlertView show];
                                                                     
                                                                 } else {
                                                                     
                                                                     UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                                                     picker.delegate = self;
                                                                     picker.allowsEditing = YES;
                                                                     picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                                     
                                                                     [self presentViewController:picker animated:YES completion:NULL];
                                                                     
                                                                 }
                                                                 
                                                                 
                                                             }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                   handler:^(UIAlertAction * action) {
                                                   }];
    
    
    [alert addAction:PhotoFromGalleryAction];
    [alert addAction:TakeAPhotoAction];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    b64EncStr = nil;
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //self.imageView.image = chosenImage;
    
    [ProfileImage setBackgroundImage:chosenImage forState:UIControlStateNormal];
    self.imgProfileBg.image = chosenImage;
    
    NSData *imgData=UIImagePNGRepresentation(chosenImage);
    if ([imgData length]>2000) {
        CGSize newSize = CGSizeMake(100.0f, 100.0f);
        
        UIGraphicsBeginImageContext(newSize);
        [chosenImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        b64EncStr = [self encodeToBase64String:newImage];
    }
    else{
        b64EncStr = [self encodeToBase64String:chosenImage];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    
    NSMutableDictionary *dictRequest = [[NSMutableDictionary alloc]init];
    [dictRequest setObject:[[DetailsManager sharedManager]rID] forKey:@"RID"];
    [dictRequest setObject:b64EncStr forKey:@"Image"];
    [dictRequest setObject:@"0" forKey:@"Type"];
    
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopUpdateProfileImage:dictRequest];
    request =  nil;

    
}

-(void)requestReceivedopProfileImageUploadRequestResponse:(NSMutableDictionary *)aregistrationDict
{
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopGetUserDetailsService];
    request =  nil;
}
- (NSString *)encodeToBase64String:(UIImage *)image {
    
    
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
