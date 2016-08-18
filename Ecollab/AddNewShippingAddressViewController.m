//
//  AddNewShippingAddressViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 17/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "AddNewShippingAddressViewController.h"

@interface AddNewShippingAddressViewController ()

@end

@implementation AddNewShippingAddressViewController
@synthesize Name,Pincode,Address,AddressOne,City,State,Country,Phone,Landmark,SubmitOutlet;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requestReceivedopInsertShippingAddressDetailsResponce:(NSMutableDictionary *)aregistrationDict{
    // show a message success or not
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)SubmitBtnAction:(id)sender {
    // here check you input validation
    NSMutableDictionary *inputDick =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"UID",Address.text,@"Address",AddressOne.text,@"Address1",City.text,@"City",Country.text,@"Country",State.text,@"State",Pincode.text,@"PinCode",@"0",@"ISDefault",Landmark.text,@"LandMark",Name.text,@"Name",Phone.text,@"MobileNumber", nil];
    
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopInsertShippingAddressDetailsService:inputDick];
    request =  nil;
}
@end
