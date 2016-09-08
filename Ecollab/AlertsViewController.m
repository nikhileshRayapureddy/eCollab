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
    [AlertsTableView setDelegate: self];
    [AlertsTableView setDataSource: self];
    [self designNavBar];
    [self designTabBar];
    [self setSelected:-1];
    
    //http://183.82.107.118:55666/eCollab/GvkWCF.svc/opGetUserNotified?uid=2&rid=286976&isviewed=1


}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getAllAlerts];
}
-(void)getAllAlerts
{
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestFopUserAlertsOrNotificationsService];
    request =  nil;

}
-(void)sendAlertViewedToServer:(NSString*)strRID
{
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request sendAlertViewedToServerWithRID:strRID];
    request =  nil;
}
-(void)requestReceivedopUserAlertsOrNotificationsResponce:(NSMutableDictionary *)aregistrationDict{
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    [notificationListArray removeAllObjects];
    notificationListArray = [aregistrationDict objectForKey:@"NotificationsOrAlertsResult"];
    [AlertsTableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
       return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else
    {
        return 83;
    }

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super numberOfSectionsInTableView:tableView];
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
    else
    {
        return notificationListArray.count;
    }
}

// Customize the appearance of table view cells.
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else
    {
        static NSString *CellIdentifier = @"AlertsTableViewCellID";
        
        AlertsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AlertsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSDictionary *dict = [notificationListArray objectAtIndex:indexPath.row];
        
        if (![[dict valueForKey:@"OrderNumber"] isKindOfClass:[NSNull class]])
        {
            cell.ProjectNameLabel.text =[dict valueForKey:@"OrderNumber"];
        }
        if (![[dict valueForKey:@"Notification"] isKindOfClass:[NSNull class]])
        {
            cell.PojectStatuLabel.text =[dict valueForKey:@"Notification"];
        }
        if (![[dict valueForKey:@"OrderType"] isKindOfClass:[NSNull class]])
        {
            // based on type assign related image
            if ([[[notificationListArray objectAtIndex:indexPath.row]objectForKey:@"OrderType"] intValue] == 1) {
                cell.ProjectTypeImageView.image = [UIImage imageNamed:@"biologysaved.png"];
            }else{
                cell.ProjectTypeImageView.image = [UIImage imageNamed:@"chemistrysaved.png"];
            }
        }
        if (![[dict valueForKey:@"OrderStatus"] isKindOfClass:[NSNull class]])
        {
            if([[[notificationListArray objectAtIndex:indexPath.row]objectForKey:@"OrderStatus"] intValue] == 0 || [[[notificationListArray objectAtIndex:indexPath.row]objectForKey:@"OrderStatus"] intValue] == 2 || [[[notificationListArray objectAtIndex:indexPath.row]objectForKey:@"OrderStatus"] intValue] == 3)
            {
                cell.imgRightArrow.hidden = NO;
                NSNumber *ISViewed = [dict valueForKey:@"ISViewed"];

                if (ISViewed.intValue == 0)
                {
                    cell.imgRightArrow.image = [UIImage imageNamed:@"redarrowup.png"];
                }
                else
                {
                    cell.imgRightArrow.image = [UIImage imageNamed:@"eyeIcon.png"];
                }
            }
            else
            {
                cell.imgRightArrow.hidden = NO;
                NSNumber *ISViewed = [dict valueForKey:@"ISViewed"];

                if (ISViewed.intValue == 0)
                {
                    cell.imgRightArrow.image = [UIImage imageNamed:@""];
                }
                else
                {
                    cell.imgRightArrow.image = [UIImage imageNamed:@"eyeIcon.png"];
                }
            }
        }
        
        
        

        
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellTapped:)];
        tapGestureRecognizer.numberOfTapsRequired = 1;
        tapGestureRecognizer.numberOfTouchesRequired = 1;
        cell.tag = indexPath.row;
        [cell addGestureRecognizer:tapGestureRecognizer];
        
        
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]
                                              initWithTarget:self action:@selector(handleLongPress:)];
        lpgr.minimumPressDuration = 1.0; //seconds
        [cell addGestureRecognizer:lpgr];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)longPress
{
    
    if(longPress.state == UIGestureRecognizerStateBegan)
    {
        CGPoint p = [longPress locationInView:AlertsTableView];
        
        NSIndexPath *indexPath = [AlertsTableView indexPathForRowAtPoint:p];
        if (indexPath == nil) {
            NSLog(@"long press on table view but not on a row");
        } else {
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"eCollab"
                                                                           message:@"Do you want to delete?"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
                NSMutableDictionary *dictRequest = [[NSMutableDictionary alloc]init];
                NSMutableDictionary *dict =[notificationListArray objectAtIndex:indexPath.row];
                
                [dictRequest setObject:[[DetailsManager sharedManager] rID] forKey:@"uid"];
                [dictRequest setObject:[dict objectForKey:@"RID"] forKey:@"rid"];
                [dictRequest setObject:@"2" forKey:@"Type"];
                NSLog(@"%d",indexPath.row);
                ServiceRequester *request = [ServiceRequester new];
                request.serviceRequesterDelegate =  self;
                [request requestForopDeleteRequest:dictRequest];
                request =  nil;
                
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            
            [alert addAction:okAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            
            
            
        }
    }
}

-(void)cellTapped:(UITapGestureRecognizer*)tap
{
    // Your code here
    CGPoint p = [tap locationInView:AlertsTableView];
    NSIndexPath *indexPath = [AlertsTableView indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    } else {
        NSLog(@"%d",indexPath.row);
        [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
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
        strRequestRID = [dict objectForKey:@"OrderID"];
        strViewedRID = [dict objectForKey:@"RID"];
        [self OrderDetails:inputDict];
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        NSLog(@"notification %@",notificationListArray);
    }

}
-(void)requestReceivedopDeleteReqestResponce:(NSMutableDictionary *)aregistrationDict
{
    NSString *strStatusCode = [aregistrationDict objectForKey:@"SuccessCode"];
    if([strStatusCode  isEqual: @"200"])
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success"
                                                                       message:[aregistrationDict objectForKey:@"SuccessString"]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            ServiceRequester *request = [ServiceRequester new];
            request.serviceRequesterDelegate =  self;
            [request requestFopUserAlertsOrNotificationsService];
            request =  nil;
        }];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
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
        [self sendAlertViewedToServer:strViewedRID];
        [EcollabLoader hideLoaderForView:self.view animated:YES];
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
                    [self getAllAlerts];

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
                    [self getAllAlerts];

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
                    [self getAllAlerts];
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
                    [self getAllAlerts];
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


- (IBAction)btnBackClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
