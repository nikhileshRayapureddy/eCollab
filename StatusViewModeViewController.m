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
    NSLog(@"%@",PlaceOrder);
    NSLog(@"%@",inputDataDictionary);
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
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
    StatusScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 625);
}

    -(void)designNavBar
    {
        self.navigationController.navigationBar.hidden = NO;
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:237.0/255.0 green:27.0/255.0 blue:36.0/255.0 alpha:1.0];
        self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        UIImageView *imgLogoEcoLab = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
        imgLogoEcoLab.backgroundColor = [UIColor clearColor];
        imgLogoEcoLab.image = [UIImage imageNamed:@"ecolablogo.png"];
        imgLogoEcoLab.contentMode = UIViewContentModeScaleAspectFit;
        self.navigationItem.titleView = imgLogoEcoLab;
        
        UIImageView *imgLogoGVK = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
        imgLogoGVK.backgroundColor = [UIColor clearColor];
        imgLogoGVK.image = [UIImage imageNamed:@"gvk_whitelogo1.png"];
        imgLogoGVK.contentMode = UIViewContentModeScaleAspectFit;
        
        UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:imgLogoGVK];
        self.navigationItem.rightBarButtonItem = rightBtn;
    }
    

-(void)dataDisplaying{
    LabelOne.text = [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"OrderNumber"]];
//    labelTwo.text = [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Quantity"]];
    
    self.lblQuantityValue.text = [NSMutableString stringWithFormat:@"%@ %@",[LocalDataDictionary objectForKey:@"Quantity"],[LocalDataDictionary objectForKey:@"QuantityValue"]];
    LableThreeTwo.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"PurityValue"]];

    LabelSix.text= [NSMutableString stringWithFormat:@"REMARKS"];//[NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Comments"]];
    Labelseven.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Comments"]];
    LabelEight.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"jonuralref"]];
    Labelnine.text= [NSMutableString stringWithFormat:@"PRICE(%@)",[LocalDataDictionary objectForKey:@"Currency"]];
    LabelTen.text= [NSMutableString stringWithFormat:@"QUOTATION COMMENTS"];//[NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@""]];
    LabelEleven.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"AdminComments"]];
//    LabelFourTwo.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Exp_Delivery_Date"]];
    NSString *strExpected = [LocalDataDictionary objectForKey:@"Exp_Delivery_Date"];
    NSString *strEstimated = [LocalDataDictionary objectForKey:@"EstimatedDelivaryDate"];
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
    SelectAddressViewController *SAVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectAddressViewController"];
    SAVCtrlObj.strRequestRID = strRequestRID;
    [self.navigationController pushViewController:SAVCtrlObj animated:YES];
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
@end
