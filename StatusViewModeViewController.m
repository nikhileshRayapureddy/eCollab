//
//  StatusViewModeViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 15/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "StatusViewModeViewController.h"

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

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@",PlaceOrder);
    NSLog(@"%@",inputDataDictionary);
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    NSMutableArray *DataArray = [inputDataDictionary objectForKey:@"RequestedQuoteList"];
    LocalDataDictionary = [DataArray objectAtIndex:0];
    [self dataDisplaying];
}
-(void)dataDisplaying{
    LabelOne.text = [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"OrderNumber"]];
    labelTwo.text = [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Quantity"]];
    LabelTrhee.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Purity"]];
    LabelFour.text= [NSMutableString stringWithFormat:@"Exp_Delivery_Date"];
    LabelFive.text= [NSMutableString stringWithFormat:@"EstimatedDelivaryDate"];
    LabelSix.text= [NSMutableString stringWithFormat:@"REMARKS"];//[NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Comments"]];
    Labelseven.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Comments"]];
    LabelEight.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"jonuralref"]];
    Labelnine.text= [NSMutableString stringWithFormat:@"PRICE(%@)",[LocalDataDictionary objectForKey:@"Currency"]];
    LabelTen.text= [NSMutableString stringWithFormat:@"QUOTATION COMMENTS"];//[NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@""]];
    LabelEleven.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"AdminComments"]];
    LableThreeTwo.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Purity"]];
    LabelFourTwo.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Exp_Delivery_Date"]];
    LabelFiveTwo.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"EstimatedDelivaryDate"]];
    labelNineTwo.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Price"]];
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
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
   // [request requestForopRequestedQuoteDetailsService:inputDict];
    request =  nil;
}
- (IBAction)RejectQuoteBtnAction:(id)sender {
    
}
@end
