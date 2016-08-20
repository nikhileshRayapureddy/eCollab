//
//  StatusViewModeViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 15/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "StatusViewModeViewController.h"
#import "SelectAddressViewController.h"

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
//    labelTwo.text = [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Quantity"]];
    
    self.lblQuantityValue.text = [NSMutableString stringWithFormat:@"%@ %@",[LocalDataDictionary objectForKey:@"Quantity"],[LocalDataDictionary objectForKey:@"QuantityValue"]];
    LableThreeTwo.text= [NSMutableString stringWithFormat:@"%@",[LocalDataDictionary objectForKey:@"Purity"]];

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
    
}
@end
