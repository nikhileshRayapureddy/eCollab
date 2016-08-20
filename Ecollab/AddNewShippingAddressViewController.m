//
//  AddNewShippingAddressViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 17/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "AddNewShippingAddressViewController.h"

@interface AddNewShippingAddressViewController ()<UITextFieldDelegate>

@end

@implementation AddNewShippingAddressViewController
@synthesize Name,Pincode,Address,AddressOne,City,State,Country,Phone,Landmark,SubmitOutlet;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_isEdit)
    {
        [self bindData];
    }
}
-(void)viewDidLayoutSubviews
{
    [self.scrlVw setContentSize:CGSizeMake(self.scrlVw.frame.size.width, 520)];
}
-(void)bindData
{
    Name.text = [self.dictAddress valueForKey:@"Name"];
    Pincode.text = [self.dictAddress valueForKey:@"Pincode"];
    Address.text = [self.dictAddress valueForKey:@"Address"];
    AddressOne.text = [self.dictAddress valueForKey:@"Address1"];
    City.text = [self.dictAddress valueForKey:@"City"];
    State.text = [self.dictAddress valueForKey:@"State"];
    Country.text = [self.dictAddress valueForKey:@"Country"];
    Phone.text = [self.dictAddress valueForKey:@"MobileNumber"];
    Landmark.text = [self.dictAddress valueForKey:@"LandMark"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requestReceivedopInsertShippingAddressDetailsResponce:(NSMutableDictionary *)aregistrationDict{
    // show a message success or not
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                   message:@"Added Address successfully."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)SubmitBtnAction:(id)sender {
    
    if (Pincode.text.length < 6)
    {
        [self showAlertWithMessage:@"Pincode should be 6 digits"];
    }
    else if (Phone.text.length < 10)
    {
        [self showAlertWithMessage:@"Phone number should be 10 digits"];
    }
    else
    {
        [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
        if (_isEdit)
        {
            // here check you input validation
            NSMutableDictionary *inputDick =[NSMutableDictionary dictionaryWithObjectsAndKeys:[[DetailsManager sharedManager]rID],@"UID",Address.text,@"Address",AddressOne.text,@"Address1",City.text,@"City",Country.text,@"Country",State.text,@"State",Pincode.text,@"PinCode",@"0",@"ISDefault",Landmark.text,@"LandMark",Name.text,@"Name",Phone.text,@"MobileNumber",[_dictAddress valueForKey:@"RID"],@"RID", nil];
            
            ServiceRequester *request = [ServiceRequester new];
            request.serviceRequesterDelegate =  self;
            [request requestForopUpdateShippingAddressDetailsService:inputDick];
            request =  nil;
        }
        else
        {
            // here check you input validation
            NSMutableDictionary *inputDick =[NSMutableDictionary dictionaryWithObjectsAndKeys:[[DetailsManager sharedManager]rID],@"UID",Address.text,@"Address",AddressOne.text,@"Address1",City.text,@"City",Country.text,@"Country",State.text,@"State",Pincode.text,@"PinCode",@"0",@"ISDefault",Landmark.text,@"LandMark",Name.text,@"Name",Phone.text,@"MobileNumber", nil];
            
            ServiceRequester *request = [ServiceRequester new];
            request.serviceRequesterDelegate =  self;
            [request requestForopInsertShippingAddressDetailsService:inputDick];
            request =  nil;
        }
    }
}

-(void)requestReceivedopUpdateShippingAddressDetailsResponce:(NSData *)data
{
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                   message:@"Updated Address successfully."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];


}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == Pincode)
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 6;
    }
    else if (textField == Phone)
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 10;
    }
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

@end
