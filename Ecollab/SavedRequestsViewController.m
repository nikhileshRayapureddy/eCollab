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
    NSMutableDictionary *dictSelectedRequest;
}


@end

@implementation SavedRequestsViewController
@synthesize SavedRequestsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self designNavBar];
    [self designTabBar];
    [self setSelected:1];

    dictSelectedRequest = [[NSMutableDictionary alloc]init];
    [SavedRequestsTableView setDelegate: self];
    [SavedRequestsTableView setDataSource: self];
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopSavedOrdersListService];
    request =  nil;
}

-(void)requestReceivedopSavedOrdersListResponce:(NSMutableDictionary *)aregistrationDict{
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    [listArray removeAllObjects];
    listArray = [aregistrationDict objectForKey:@"SavedOrdersList"];
    [SavedRequestsTableView reloadData];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
      return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else
    {
    return 75;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
    else
    {
        return listArray.count;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else{
        
        static NSString *CellIdentifier = @"SavedRequestsTableViewCellID";
        
        SavedRequestsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SavedRequestsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.PojectNameLabel.text =[[listArray objectAtIndex:indexPath.row]objectForKey:@"OrderNumber"];
        // based on type assign related image  biologysaved.png
        if ([[[listArray objectAtIndex:indexPath.row]objectForKey:@"Type"] intValue] == 0) {
            cell.ProjectTypeImageView.image = [UIImage imageNamed:@"chemistrysaved.png"];
        }else{
            cell.ProjectTypeImageView.image = [UIImage imageNamed:@"biologysaved.png"];
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
        CGPoint p = [longPress locationInView:SavedRequestsTableView];
        
        NSIndexPath *indexPath = [SavedRequestsTableView indexPathForRowAtPoint:p];
        if (indexPath == nil) {
            NSLog(@"long press on table view but not on a row");
        } else {

            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"eCollab"
                                                                           message:@"Do you want to delete?"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
                NSMutableDictionary *dictRequest = [[NSMutableDictionary alloc]init];
                NSMutableDictionary *dict =[listArray objectAtIndex:indexPath.row];
                
                [dictRequest setObject:[[DetailsManager sharedManager] rID] forKey:@"uid"];
                [dictRequest setObject:[dict objectForKey:@"RID"] forKey:@"rid"];
                [dictRequest setObject:[dict objectForKey:@"Type"] forKey:@"Type"];
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
    CGPoint p = [tap locationInView:SavedRequestsTableView];
    NSIndexPath *indexPath = [SavedRequestsTableView indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    } else {
        NSLog(@"%d",indexPath.row);
        NSMutableDictionary *dict =[listArray objectAtIndex:indexPath.row];
        NSLog(@"dict is %@",dict);
        Type = [NSMutableString stringWithFormat:@"%@",[[listArray objectAtIndex:indexPath.row]objectForKey:@"Type"]];
        
        
        NSMutableDictionary  *inputDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dict objectForKey:@"RID"],@"RID",Type,@"Type", nil];
        [self OrderDetails:inputDict];
    }


}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
-(void)OrderDetails:(NSMutableDictionary *)inputDict {
    dictSelectedRequest = inputDict;
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopRequestedQuoteDetailsService:inputDict];
    request =  nil;
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
            [request requestForopSavedOrdersListService];
            request =  nil;
            
        }];
        [alert addAction:okAction];

        [self presentViewController:alert animated:YES completion:nil];
        

    }

}
-(void)requestReceivedopRequestedQuoteDetailsResponce:(NSMutableDictionary *)aregistrationDict
{
    // Note please navigate with data dictionary
    if ([Type intValue] == 0) {
        NewChemistryRequestViewController *NCRVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewChemistryRequestViewController"];
        NSArray *arr = [aregistrationDict objectForKey:@"RequestedQuoteList"];
        if(arr.count != 0)
        {
            NSMutableDictionary *dict = [arr objectAtIndex:0];
            NCRVCtrlObj.dictSavedChemestryData = dict;
        }
        NCRVCtrlObj.isFromRequestAQuote = NO;

        [self.navigationController pushViewController:NCRVCtrlObj animated:YES];
        
    }else{
        
        NewBiologyRequestViewController *NBRVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewBiologyRequestViewController"];
        NBRVCtrlObj.isFromRequestAQuote = NO;
        NBRVCtrlObj.shouldUpdateRequest = YES;
        NSArray *arr = [aregistrationDict objectForKey:@"RequestedQuoteList"];
        if(arr.count != 0)
        {
            NSMutableDictionary *dict = [arr objectAtIndex:0];
            NBRVCtrlObj.dictSavedOrderDetails = dict;
        }
        NBRVCtrlObj.strRIDForSavedRequest = [dictSelectedRequest objectForKey:@"RID"];
        [self.navigationController pushViewController:NBRVCtrlObj animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
