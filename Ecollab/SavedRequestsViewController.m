//
//  SavedRequestsViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "SavedRequestsViewController.h"

@interface SavedRequestsViewController (){
    NSMutableArray *listArray;
    NSMutableString *Type;
}

@end

@implementation SavedRequestsViewController
@synthesize SavedRequestsTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    [SavedRequestsTableView setDelegate: self];
    [SavedRequestsTableView setDataSource: self];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopSavedOrdersListService];
    request =  nil;
}
-(void)requestReceivedopSavedOrdersListResponce:(NSMutableDictionary *)aregistrationDict{
    listArray = [aregistrationDict objectForKey:@"SavedOrdersList"];
    [SavedRequestsTableView reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return listArray.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SavedRequestsTableViewCellID";
    
    SavedRequestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[SavedRequestsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.PojectNameLabel.text =[[listArray objectAtIndex:indexPath.row]objectForKey:@"OrderNumber"];
    // based on type assign related image  biologysaved.png
    if ([[[listArray objectAtIndex:indexPath.row]objectForKey:@"Type"] intValue] == 0) {
        cell.ProjectTypeImageView.image = [UIImage imageNamed:@"biologysaved.png"];
    }else{
        cell.ProjectTypeImageView.image = [UIImage imageNamed:@"chemistrysaved.png"];
    }
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *dict =[listArray objectAtIndex:indexPath.row];
    NSLog(@"dict is %@",dict);
    Type = [NSMutableString stringWithFormat:@"%@",[[listArray objectAtIndex:indexPath.row]objectForKey:@"Type"]];
    
    
 NSMutableDictionary  *inputDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"RID"],@"RID",Type,@"Type", nil];
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
    if ([Type intValue] == 0) {
        NewChemistryRequestViewController *NCRVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewChemistryRequestViewController"];
        [self.navigationController pushViewController:NCRVCtrlObj animated:YES];
        
    }else{
        
        NewBiologyRequestViewController *NBRVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewBiologyRequestViewController"];
        NBRVCtrlObj.isFromRequestAQuote = NO;
        NSArray *arr = [aregistrationDict objectForKey:@"RequestedQuoteList"];
        if(arr.count != 0)
        {
            NSMutableDictionary *dict = [arr objectAtIndex:0];
            NBRVCtrlObj.dictSavedOrderDetails = dict;
        }
        [self.navigationController pushViewController:NBRVCtrlObj animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
