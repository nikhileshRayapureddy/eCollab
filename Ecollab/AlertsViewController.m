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
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestFopUserAlertsOrNotificationsService];
    request =  nil;

}
-(void)requestReceivedopUserAlertsOrNotificationsResponce:(NSMutableDictionary *)aregistrationDict{
    notificationListArray = [aregistrationDict objectForKey:@"NotificationsOrAlertsResult"];
    [AlertsTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
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
    if ([[[notificationListArray objectAtIndex:indexPath.row]objectForKey:@"Type"] intValue] == 0) {
        cell.ProjectTypeImageView.image = [UIImage imageNamed:@"biologysaved.png"];
    }else{
        cell.ProjectTypeImageView.image = [UIImage imageNamed:@"chemistrysaved.png"];
    }
    
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
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

    if ([OrderType intValue]== 0) {
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
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
