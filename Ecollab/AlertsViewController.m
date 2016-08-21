//
//  AlertsViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "AlertsViewController.h"

@interface AlertsViewController (){
    NSMutableArray *notificationListArray;
    NSMutableString   *OrderStatus;
    NSMutableString   *OrderType;
    NSMutableString *PlaceOrder;
}

@end

@implementation AlertsViewController
@synthesize AlertsTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    [AlertsTableView setDelegate: self];
    [AlertsTableView setDataSource: self];
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestFopUserAlertsOrNotificationsService];
    request =  nil;
    [self designNavBar];

}
-(void)requestReceivedopUserAlertsOrNotificationsResponce:(NSMutableDictionary *)aregistrationDict{
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    notificationListArray = [aregistrationDict objectForKey:@"NotificationsOrAlertsResult"];
    [AlertsTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return notificationListArray.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AlertsTableViewCellID";
    
    AlertsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[AlertsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.ProjectNameLabel.text =[[notificationListArray objectAtIndex:indexPath.row]objectForKey:@"OrderNumber"];
    cell.PojectStatuLabel.text =[[notificationListArray objectAtIndex:indexPath.row]objectForKey:@"Notification"];

    // based on type assign related image
    if ([[[notificationListArray objectAtIndex:indexPath.row]objectForKey:@"OrderType"] intValue] == 1) {
        cell.ProjectTypeImageView.image = [UIImage imageNamed:@"biologysaved.png"];
    }else{
        cell.ProjectTypeImageView.image = [UIImage imageNamed:@"chemistrysaved.png"];
    }
    
    if([[[notificationListArray objectAtIndex:indexPath.row]objectForKey:@"OrderStatus"] intValue] == 1)
    {
        cell.imgRightArrow.hidden = YES;
    }
    else
    {
        cell.imgRightArrow.hidden = NO;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"notification %@",notificationListArray);
    NSMutableDictionary *dict =[notificationListArray objectAtIndex:indexPath.row];
    NSMutableString *Type = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"OrderType"]];
    OrderStatus = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"OrderStatus"]];
    OrderType = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"OrderType"]];
    PlaceOrder = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"PlaceOrder"]];
    NSMutableDictionary  *inputDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"OrderID"],@"RID",Type,@"Type", nil];
    
    NSNumber *regretted = [dict valueForKey:@"RegretStatus"];
    BOOL isRegretted = regretted.boolValue;
    
    NSNumber *rejected = [dict valueForKey:@"RejectStatus"];
    BOOL isRejected = rejected.boolValue;
    
    if(isRegretted == YES || isRejected == YES)
    {
        isRegretReject = YES;
    }
    else
    {
        isRegretReject = NO;
    }
    strRequestRID = [dict objectForKey:@"RID"];
    [self OrderDetails:inputDict];

}
-(void)OrderDetails:(NSMutableDictionary *)inputDict {
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopRequestedQuoteDetailsService:inputDict];
    request =  nil;
}
-(void)requestReceivedopRequestedQuoteDetailsResponce:(NSMutableDictionary *)aregistrationDict
{
    // Note please navigate with data dictionary
    {
        
        if(OrderType.intValue == 0)
        {
            switch (OrderStatus.intValue) {
                case 0:
                {
                    NewChemistryRequestViewController *NCRVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewChemistryRequestViewController"];
                    NCRVCtrlObj.isFromTracking = YES;
                    NCRVCtrlObj.isFromRequestAQuote = NO;
                    NSArray *arr = [aregistrationDict objectForKey:@"RequestedQuoteList"];
                    if(arr.count != 0)
                    {
                        NSMutableDictionary *dict = [arr objectAtIndex:0];
                        NCRVCtrlObj.dictSavedChemestryData = dict;
                    }
                    
                    [self.navigationController pushViewController:NCRVCtrlObj animated:YES];
                }
                    break;
                case 1:
                {
                    
                }
                    break;
                case 2:
                {
                    StatusViewModeViewController *TSVMVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"StatusViewModeViewController"];
                    TSVMVCtrlObj.PlaceOrder = [NSMutableString stringWithFormat:@"%@",PlaceOrder];
                    TSVMVCtrlObj.inputDataDictionary= aregistrationDict;
                    TSVMVCtrlObj.strRequestRID = strRequestRID;
                    TSVMVCtrlObj.isRegrettedOrRejected = isRegretReject;
                    [self.navigationController pushViewController:TSVMVCtrlObj animated:YES];
                }
                    break;
                case 3:
                {
                    StatusViewModeViewController *TSVMVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"StatusViewModeViewController"];
                    TSVMVCtrlObj.PlaceOrder = [NSMutableString stringWithFormat:@"%@",PlaceOrder];
                    TSVMVCtrlObj.inputDataDictionary= aregistrationDict;
                    TSVMVCtrlObj.isRegrettedOrRejected = isRegretReject;
                    TSVMVCtrlObj.strRequestRID = strRequestRID;
                    [self.navigationController pushViewController:TSVMVCtrlObj animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
        else
        {
            switch (OrderStatus.intValue) {
                case 0:
                {
                    NewBiologyRequestViewController *NBRVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewBiologyRequestViewController"];
                    NBRVCtrlObj.isFromRequestAQuote = NO;
                    NBRVCtrlObj.shouldUpdateRequest = NO;
                    NBRVCtrlObj.isFromTracking = YES;
                    NSArray *arr = [aregistrationDict objectForKey:@"RequestedQuoteList"];
                    if(arr.count != 0)
                    {
                        NSMutableDictionary *dict = [arr objectAtIndex:0];
                        NBRVCtrlObj.dictSavedOrderDetails = dict;
                    }
                    [self.navigationController pushViewController:NBRVCtrlObj animated:YES];
                }
                    break;
                case 1:
                {
                    
                }
                    break;
                case 2:
                {
                    DiscussQuoteViewController *TSVMVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"DiscussQuoteViewController"];
                    NSArray *arr = [aregistrationDict objectForKey:@"RequestedQuoteList"];
                    TSVMVCtrlObj.isRjectOrRegretted = isRegretReject;
                    TSVMVCtrlObj.placeOrder = PlaceOrder;
                    TSVMVCtrlObj.strRequestRID = strRequestRID;
                    if(arr.count != 0)
                    {
                        NSMutableDictionary *dict = [arr objectAtIndex:0];
                        TSVMVCtrlObj.DataDict = dict;
                    }
                    [self.navigationController pushViewController:TSVMVCtrlObj animated:YES];
                }
                    break;
                case 3:
                {
                    DiscussQuoteViewController *TSVMVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"DiscussQuoteViewController"];
                    TSVMVCtrlObj.placeOrder = PlaceOrder;
                    TSVMVCtrlObj.isRjectOrRegretted = isRegretReject;
                    TSVMVCtrlObj.strRequestRID = strRequestRID;
                    NSArray *arr = [aregistrationDict objectForKey:@"RequestedQuoteList"];
                    if(arr.count != 0)
                    {
                        NSMutableDictionary *dict = [arr objectAtIndex:0];
                        TSVMVCtrlObj.DataDict = dict;
                    }
                    [self.navigationController pushViewController:TSVMVCtrlObj animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
    }
    
/*    if ([OrderType intValue]== 0) {
        //OrderType = 0
            if( [OrderStatus intValue] == 0 || [OrderStatus intValue] == 1 ){
                // chemistry req view non editable
                NewChemistryRequestViewController *NCRVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewChemistryRequestViewController"];
                [self.navigationController pushViewController:NCRVCtrlObj animated:YES];
            }else{
                // confirm quote editablw
                StatusViewModeViewController *TSVMVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"StatusViewModeViewController"];
                TSVMVCtrlObj.PlaceOrder = [NSMutableString stringWithFormat:@"%@",PlaceOrder];
                TSVMVCtrlObj.inputDataDictionary= aregistrationDict;
                [self.navigationController pushViewController:TSVMVCtrlObj animated:YES];

            }
    }else{
       //OrderType = 1
            if( [OrderStatus intValue] == 0 || [OrderStatus intValue] == 1 ){
                // discuss quote
                // without discuss button
                //DiscussQuoteViewController.h
                DiscussQuoteViewController *DQVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"DiscussQuoteViewController"];
                DQVCtrlObj.DataDict = aregistrationDict;
                [self.navigationController pushViewController:DQVCtrlObj animated:YES];
            }else{
                // discuss quote
                // with discuss button
                //DiscussQuoteViewController.h
                DiscussQuoteViewController *DQVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"DiscussQuoteViewController"];
                DQVCtrlObj.DataDict = aregistrationDict;
                [self.navigationController pushViewController:DQVCtrlObj animated:YES];
            }
    }
    */
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
