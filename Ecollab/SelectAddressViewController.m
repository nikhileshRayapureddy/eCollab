//
//  SelectAddressViewController.m
//  Ecollab
//
//  Created by Kiran Kumar on 20/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "SelectAddressViewController.h"
#import "ShippingInformationViewController.h"

@interface SelectAddressViewController ()

@end

@implementation SelectAddressViewController
@synthesize strRequestRID;
- (void)viewDidLoad {
    [super viewDidLoad];
    dictDefaultAddress = [[NSMutableDictionary alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopGetShippingAddressDetailsService];
    request =  nil;
    
}

-(void)requestReceivedopGetUserAddressListRequestResponce:(NSMutableDictionary *)aregistrationDict
{
    NSMutableArray *arrAddresses = [aregistrationDict valueForKey:@"UserAddressDetailsResult"];
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    BOOL isFound = NO;
    for (NSDictionary *dictAddress in arrAddresses)
    {
        NSNumber *ISDefault = [dictAddress valueForKey:@"ISDefault"];
        BOOL defaultAddress = ISDefault.boolValue;
        if(defaultAddress == YES)
        {
            isFound = YES;
            dictDefaultAddress = dictAddress;
            break;
        }
    }
    if(isFound == YES)
    {
        [self bindDefaultAddress];
    }
    else
    {
        ShippingInformationViewController *SIVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ShippingInformationViewController"];
        SIVCtrlObj.isFromTracking = YES;
        [self.navigationController pushViewController:SIVCtrlObj animated:NO];
    }
}

-(void)bindDefaultAddress
{
    self.lblName.text = [dictDefaultAddress objectForKey:@"Name"];
    self.lblNumber.text = [dictDefaultAddress objectForKey:@"MobileNumber"];
    self.lblAddress1.text = [NSString stringWithFormat:@"%@ %@ %@",[dictDefaultAddress objectForKey:@"Address"],[dictDefaultAddress objectForKey:@"Address1"],[dictDefaultAddress objectForKey:@"City"]];
    self.lblAddress2.text = [NSString stringWithFormat:@"%@ %@ %@",[dictDefaultAddress objectForKey:@"State"],[dictDefaultAddress objectForKey:@"Country"],[dictDefaultAddress objectForKey:@"Pincode"]];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnChangeAddressClicked:(UIButton *)sender {
    ShippingInformationViewController *SIVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ShippingInformationViewController"];
    SIVCtrlObj.isFromTracking = YES;
    [self.navigationController pushViewController:SIVCtrlObj animated:YES];
}
- (IBAction)btnSubmitClicked:(UIButton *)sender {
    
    NSMutableDictionary *dictRequest = [[NSMutableDictionary alloc]init];
    [dictRequest setObject:@"0" forKey:@"Type"];
    [dictRequest setObject:[dictDefaultAddress objectForKey:@"RID"] forKey:@"AddressID"];
    [dictRequest setObject:@"" forKey:@"RejectedComments"];
    [dictRequest setObject:strRequestRID forKey:@"RID"];
    
    
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopPlaceChemistryRequestService:dictRequest];
    request = nil;
    
}

-(void)requestReceivedopPlaceChemistryRequestResponce:(NSMutableDictionary *)aregistrationDict;
{
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    NSString *messageString=[aregistrationDict objectForKey:@"SuccessString"];
    // Check email validation
    if ([[aregistrationDict objectForKey:@"SuccessCode"]intValue] != 200) {
        // show an alert with messageString
    }
    else{
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                           message:messageString
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[DashboardViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }];
            
            
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }

}
@end
