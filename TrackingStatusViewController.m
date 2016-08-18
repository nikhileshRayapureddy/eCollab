//
//  TrackingStatusViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "TrackingStatusViewController.h"

@interface TrackingStatusViewController (){
    NSMutableArray *TableDataArray;
    NSString *ProjectStatus ;
    NSString *PlaceOrder ;
}

@end

@implementation TrackingStatusViewController
@synthesize StatusTableview,MainDataDictionary,ItemType;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    
    NSLog(@"%@",MainDataDictionary);
    NSLog(@"%@",ItemType);
    TableDataArray = [[[[MainDataDictionary objectForKey:@"TrackSelecctedOrderDetailsResult"] reverseObjectEnumerator] allObjects]mutableCopy];
    NSLog(@"%@",TableDataArray);
    [StatusTableview setDelegate:self];
    [StatusTableview setDataSource:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return TableDataArray.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"TrackingStatusTableViewCellID";
    
    TrackingStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TrackingStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    /*
     @property (strong, nonatomic) IBOutlet UIImageView *StatusImage;
     @property (strong, nonatomic) IBOutlet UILabel *StatusLabel;
     @property (strong, nonatomic) IBOutlet UILabel *StatusTimeLabel;
     @property (strong, nonatomic) IBOutlet UILabel *StatusProcessIndecatorLabel;
     */
    NSDictionary *tempDict = [TableDataArray objectAtIndex:indexPath.row];
    //CreatedDate
    cell.imageView.image = [UIImage imageNamed:@""];
    cell.StatusLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"ReqStatus"]];
    cell.StatusTimeLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"CreatedDate"]];
    if (TableDataArray.count-1 == indexPath.row) {
        [cell.StatusProcessIndecatorLabel setHidden:YES];
    }

return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *inputDict ;
    ProjectStatus = [[TableDataArray objectAtIndex:indexPath.row] objectForKey:@"ProjectStatus"];
    PlaceOrder = [[TableDataArray objectAtIndex:indexPath.row] objectForKey:@"PlaceOrder"];
    NSDictionary * tempDict = [TableDataArray objectAtIndex:indexPath.row];
    
    
    inputDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[tempDict objectForKey:@"RID"],@"RID",ItemType,@"Type", nil];
    
    if ([ProjectStatus intValue] == 3)
    {
        [self OrderDetails:inputDict];
        
    }else if ([ProjectStatus intValue] == 2)
    {
        [self OrderDetails:inputDict];

    }else
    {
        [self OrderDetails:inputDict];
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

    
    if ([ProjectStatus intValue] == 3) {
        
        //PlaceOrder = 0
        // edit mode
        
        //PlaceOrder = 1
        //view mode
        StatusViewModeViewController *TSVMVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"StatusViewModeViewController"];
        TSVMVCtrlObj.PlaceOrder = [NSMutableString stringWithFormat:@"%@",PlaceOrder];
        TSVMVCtrlObj.inputDataDictionary= aregistrationDict;
        [self.navigationController pushViewController:TSVMVCtrlObj animated:YES];

    }else if ([ProjectStatus intValue] == 2){
            //PlaceOrder = 0
            // edit mode
        
            //PlaceOrder = 1
            //view mode
            
        StatusViewModeViewController *TSVMVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"StatusViewModeViewController"];
        TSVMVCtrlObj.PlaceOrder = [NSMutableString stringWithFormat:@"%@",PlaceOrder];
        TSVMVCtrlObj.inputDataDictionary= aregistrationDict;
        [self.navigationController pushViewController:TSVMVCtrlObj animated:YES];
    }else
    {
        // Note please navigate with data dictionary

        // always view mode
        if ([ItemType intValue] == 0) {
            NewChemistryRequestViewController *NCRVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewChemistryRequestViewController"];
            [self.navigationController pushViewController:NCRVCtrlObj animated:YES];
        }else{
            // navigate bilogy NewBiologyRequestViewController.h
            // discuss quote
            // without discuss button
            DiscussQuoteViewController *DQVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"DiscussQuoteViewController"];
            DQVCtrlObj.DataDict = aregistrationDict;
            [self.navigationController pushViewController:DQVCtrlObj animated:YES];
        }
    }


}
@end
