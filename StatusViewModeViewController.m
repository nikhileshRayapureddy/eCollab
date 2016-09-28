//
//  StatusViewModeViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 15/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "StatusViewModeViewController.h"
#import "SelectAddressViewController.h"
#import "RequestOrProjectTrackerViewController.h"
@interface StatusViewModeViewController (){
    NSMutableDictionary *LocalDataDictionary;
    NSDictionary *dictLocalDefaultAddress;
    float commentsHeight;
    
}

@end

@implementation StatusViewModeViewController
@synthesize inputDataDictionary,PlaceOrder;
@synthesize StatusScrollView;
@synthesize StatuImgOne,StatusImgTwo,StatuImgThree,StatusImgFour,StatusImgFive,StatusImgsix,StatusImgnine,statusImgTen,StausImgEight;
@synthesize LabelOne,labelTwo,LabelTrhee,LabelFour,LabelFive,LabelSix,Labelseven,LabelEight,Labelnine,LabelTen,LabelEleven,LableThreeTwo,LabelFiveTwo,labelNineTwo,LabelFourTwo;
@synthesize PlaceOrderBtnOutlet,RejectQuoteBtnOutlet;
@synthesize strRequestRID;
@synthesize isRegrettedOrRejected;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    commentsHeight = 0;
    NSLog(@"%@",PlaceOrder);
    NSLog(@"%@",inputDataDictionary);
    dictLocalDefaultAddress = [[NSDictionary alloc]init];
    NSMutableArray *DataArray = [inputDataDictionary objectForKey:@"RequestedQuoteList"];
    LocalDataDictionary = [DataArray objectAtIndex:0];
    [self dataDisplaying];
    LabelFour.adjustsFontSizeToFitWidth = YES;
    LabelFive.adjustsFontSizeToFitWidth = YES;
    [self designNavBar];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    if (commentsHeight > 40)
    {
        StatusScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 625 + (commentsHeight - 40));
    }
    else
    {
        StatusScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 625);
    }
    
}

    

-(void)dataDisplaying{
    LabelOne.text = [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"OrderNumber"]];
//    labelTwo.text = [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Quantity"]];
    NSString *strQuantityUnit = @"";
    if([[LocalDataDictionary objectForKey:@"QuantityID"] integerValue] == 0 || [[LocalDataDictionary objectForKey:@"QuantityID"] integerValue] == 1)
    {
        strQuantityUnit = @"mg";
    }
    else if([[LocalDataDictionary objectForKey:@"QuantityID"] integerValue] == 2)
    {
        strQuantityUnit = @"g";
    }
    else if([[LocalDataDictionary objectForKey:@"QuantityID"] integerValue] == 3)
    {
        strQuantityUnit = @"kg";
    }
        
    self.lblQuantityValue.text = [NSMutableString stringWithFormat:@"%@ %@",[LocalDataDictionary objectForKey:@"Quantity"],strQuantityUnit];
    LableThreeTwo.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"PurityValue"]];

    LabelSix.text= [NSMutableString stringWithFormat:@"REMARKS"];//[NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Comments"]];
    
    NSString *strComments = [LocalDataDictionary objectForKey:@"Comments"];
    
    if (strComments.length)
    {
        CGRect rect = [strComments boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 26, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:Labelseven.font} context:nil];
        
        commentsHeight = ceilf(rect.size.height);
        self.viewRemarksHeightConstraint.constant = commentsHeight;

    }
    
    Labelseven.text= [strComments stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    LabelEight.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"jonuralref"]];
    if(!LabelEight.text.length)
    {
        LabelEight.text = @"JOURNAL REFERENCE";
    }
    Labelnine.text= [NSMutableString stringWithFormat:@"PRICE(%@)",[LocalDataDictionary objectForKey:@"Currency"]];
    LabelTen.text= [NSMutableString stringWithFormat:@"QUOTATION COMMENTS"];//[NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@""]];
    LabelEleven.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"AdminComments"]];
//    LabelFourTwo.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Exp_Delivery_Date"]];
    NSString *strExpected = [self convertDateFormat:[LocalDataDictionary objectForKey:@"Exp_Delivery_Date"]] ;
    NSString *strEstimated = [self convertDateFormat:[LocalDataDictionary objectForKey:@"EstimatedDelivaryDate"]];
    NSArray *arrExpected = [strExpected componentsSeparatedByString:@" "];
    NSArray *arrEstimated = [strEstimated componentsSeparatedByString:@" "];
    if(arrExpected.count > 0)
    {
        LabelFourTwo.text = [arrExpected objectAtIndex:0];
    }
    if(arrEstimated.count > 0)
    {
        LabelFiveTwo.text = [arrEstimated objectAtIndex:0];
    }
    
//    LabelFiveTwo.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"EstimatedDelivaryDate"]];
    labelNineTwo.text= [NSMutableString stringWithFormat:@"%.2f",[[LocalDataDictionary objectForKey:@"Price"] floatValue]];
    
    self.viewRemarksValue.layer.borderWidth = 1.0;
    self.viewCommentsValue.layer.borderWidth = 1.0;
    
    self.viewRemarksValue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.viewCommentsValue.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    if(PlaceOrder.intValue == 0)
    {
        PlaceOrderBtnOutlet.hidden = NO;
        RejectQuoteBtnOutlet.hidden = NO;
    }
    else
    {
        PlaceOrderBtnOutlet.hidden = YES;
        RejectQuoteBtnOutlet.hidden = YES;
    }
    
    if(isRegrettedOrRejected)
    {
        PlaceOrderBtnOutlet.hidden = YES;
        RejectQuoteBtnOutlet.hidden = YES;
    }
}

-(NSString*)convertDateFormat:(NSString*)strDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDate *expdate = [df dateFromString:strDate];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MMM/yyyy"];
    NSLog(@"%@",[dateFormat stringFromDate:expdate]);
    return [dateFormat stringFromDate:expdate];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)PlaceOrderBtnAction:(id)sender {
  /*  /opPlaceChemistryRequest
    
    (Chemistry Placer Order)
    RID : Req ID
    Type : 0
    RejectedComments : ""
    AddressID : Address ID from Address list
    (/opGetUserAddressDetails?uid={uid}) uid = Login user id
 */
    //[NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"OrderNumber"]];
 // NSMutableDictionary  *inputDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[tempDict objectForKey:@"RID"],@"RID",ItemType,@"Type", nil];
    
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
    if(arrAddresses.count != 0)
    {
        for (NSDictionary *dictAddress in arrAddresses)
        {
            NSNumber *ISDefault = [dictAddress valueForKey:@"ISDefault"];
            BOOL defaultAddress = ISDefault.boolValue;
            if(defaultAddress == YES)
            {
                isFound = YES;
                SelectAddressViewController *SAVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectAddressViewController"];
                SAVCtrlObj.strRequestRID = strRequestRID;
                [[NSUserDefaults standardUserDefaults]setObject:strRequestRID forKey:@"strRequestRID"];
                SAVCtrlObj.dictDefaultAddress = dictAddress;
                [self.navigationController pushViewController:SAVCtrlObj animated:NO];
                break;
            }
        }
        if(isFound == YES)
        {
//            [self bindDefaultAddress];
        }
        else
        {
            if (arrAddresses.count ==1)
            {
                
                [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
                NSDictionary *dictAddress = [arrAddresses objectAtIndex:0];
// here check you input validation
                NSMutableDictionary *inputDick =[NSMutableDictionary dictionaryWithObjectsAndKeys:[[DetailsManager sharedManager]rID],@"UID",[dictAddress valueForKey:@"Address"],@"Address",[dictAddress valueForKey:@"Address1"],@"Address1",[dictAddress valueForKey:@"City"],@"City",[dictAddress valueForKey:@"Country"],@"Country",[dictAddress valueForKey:@"State"],@"State",[dictAddress valueForKey:@"Pincode"],@"PinCode",@"1",@"ISDefault",[dictAddress valueForKey:@"LandMark"],@"LandMark",[dictAddress valueForKey:@"Name"],@"Name",[dictAddress valueForKey:@"MobileNumber"],@"MobileNumber",[dictAddress valueForKey:@"RID"],@"RID", nil];
                ServiceRequester *request = [ServiceRequester new];
                request.serviceRequesterDelegate =  self;
                dictLocalDefaultAddress = dictAddress;
                [request requestForopUpdateShippingAddressDetailsService:inputDick];
                request =  nil;
            }
            else
            {
                ShippingInformationViewController *SIVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ShippingInformationViewController"];
                SIVCtrlObj.isFromTracking = YES;
                SIVCtrlObj.strRequestRID = strRequestRID;
                [[NSUserDefaults standardUserDefaults]setObject:strRequestRID forKey:@"strRequestRID"];
                [self.navigationController pushViewController:SIVCtrlObj animated:NO];
            }
            
        }
    }
    else
    {
        AddNewShippingAddressViewController *SIVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewShippingAddressViewController"];
        SIVCtrlObj.isEdit = NO;
        [self.navigationController pushViewController:SIVCtrlObj animated:NO];
    }
}

-(void)requestReceivedopUpdateShippingAddressDetailsResponce:(NSMutableDictionary *)aregistrationDict;
{
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    SelectAddressViewController *SAVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectAddressViewController"];
    SAVCtrlObj.strRequestRID = strRequestRID;
    [[NSUserDefaults standardUserDefaults]setObject:strRequestRID forKey:@"strRequestRID"];
    SAVCtrlObj.dictDefaultAddress = dictLocalDefaultAddress;
    [self.navigationController pushViewController:SAVCtrlObj animated:NO];
    //    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)RejectQuoteBtnAction:(id)sender {
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopLoadMasterService];
    request =  nil;

}

-(void)requestReceivedopLoadMasterResponce:(NSMutableDictionary *)aregistrationDict{
    NSLog(@"%@",aregistrationDict);
    NSLog(@"%@",[aregistrationDict objectForKey:@"SuccessCode"]);
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    if([[aregistrationDict objectForKey:@"SuccessCode"] intValue]== 200)
    {
        NSArray *serviceArray = [aregistrationDict objectForKey:@"RejectStatusMaster"];
        if(rejectView)
        {
            rejectView.delegate = nil;
            [rejectView removeFromSuperview];
            rejectView = nil;
        }
        rejectView = [[RejectedReasonsCustomView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        rejectView.delegate = self;
        rejectView.strRequestId = strRequestRID;
        [rejectView.arrTitles addObjectsFromArray:serviceArray];
        [rejectView reloadData];
        rejectView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:rejectView];
    }
    
        
}

-(void)showAlert:(NSString *)message
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)removePopUp
{
    if(rejectView)
    {
        rejectView.delegate = nil;
        [rejectView removeFromSuperview];
        rejectView = nil;
    }
}

-(void)rejectResponseRecieved:(NSMutableDictionary *)dictResponse
{
    NSString *messageString=[dictResponse objectForKey:@"SuccessString"];
    // Check email validation
    if ([[dictResponse objectForKey:@"SuccessCode"]intValue] != 200) {
        // show an alert with messageString
        [self showAlert:messageString];
    }
    else{
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                           message:@"You have cancelled this request."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self removePopUp];
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[RequestOrProjectTrackerViewController class]])
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
- (IBAction)btnBackClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
