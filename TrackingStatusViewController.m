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
    if(TableDataArray.count > 0)
    {
        NSDictionary *dictOrderDetails = [TableDataArray objectAtIndex:0];
        NSString *status = [NSString stringWithFormat:@"STATUS : %@",[dictOrderDetails objectForKey:@"ReqStatus"]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:status];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0,7)];
        self.lblStatus.attributedText = str;
        self.lblRequestNumber.text = [dictOrderDetails objectForKey:@"OrderNumber"];
        strRequestRID = [dictOrderDetails objectForKey:@"RID"];
        self.lblStatus.adjustsFontSizeToFitWidth = YES;
        self.lblRequestNumber.adjustsFontSizeToFitWidth = YES;
    }
    if([ItemType  isEqual: @"0"])
    {
        self.imgRequestLogo.image = [UIImage imageNamed:@"chemistrysaved.png"];
    }
    else
    {
        self.imgRequestLogo.image = [UIImage imageNamed:@"biologysaved.png"];
    }
    [self designNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super numberOfSectionsInTableView:tableView];
    }
    else
    {
    return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
    else
    {
    return TableDataArray.count;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else
    {

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
    if([ItemType isEqual:@"0"])
    {
        if(indexPath.row == 0)
        {
            NSNumber *regretted = [tempDict valueForKey:@"ISRegretted"];
            BOOL isRegretted = regretted.boolValue;

            NSNumber *rejected = [tempDict valueForKey:@"ISRejected"];
            BOOL isRejected = rejected.boolValue;
            
            if(isRegretted || isRejected)
            {
                cell.StatusImage.image = [UIImage imageNamed:@"crossred.png"];
            }
            else
            {
                NSNumber *projectStatus = [tempDict valueForKey:@"ProjectStatus"];
                int projectStat = projectStatus.intValue;
                if(projectStat == 3)
                {
                    cell.StatusImage.image = [UIImage imageNamed:@"orangetracksubnew.png"];
                }
                else if(projectStat == 7)
                {
                    cell.StatusImage.image = [UIImage imageNamed:@"tick.png"];
                }
                else
                {
                    cell.StatusImage.image = [UIImage imageNamed:@"orangecircle.png"];
                }
            }
        }
        else
        {
            cell.StatusImage.image = [UIImage imageNamed:@"tick.png"];
        }
    }
    else
    {
        if(indexPath.row == 0)
        {
            NSNumber *regretted = [tempDict valueForKey:@"ISRegretted"];
            BOOL isRegretted = regretted.boolValue;
            
            NSNumber *rejected = [tempDict valueForKey:@"ISRejected"];
            BOOL isRejected = rejected.boolValue;
            
            if(isRegretted || isRejected)
            {
                cell.StatusImage.image = [UIImage imageNamed:@"crossred.png"];
            }
            else
            {
                NSNumber *projectStatus = [tempDict valueForKey:@"ProjectStatus"];
                int projectStat = projectStatus.intValue;
                if(projectStat == 3)
                {
                    NSNumber *placeOrder = [tempDict valueForKey:@"PlaceOrder"];
                    BOOL isPlaceOrder = placeOrder.boolValue;
                    if(isPlaceOrder == YES)
                    {
                        cell.StatusImage.image = [UIImage imageNamed:@"tick.png"];
                    }
                    else
                    {
                        cell.StatusImage.image = [UIImage imageNamed:@"orangetracksubnew.png"];
                    }
                }
                else
                {
                    cell.StatusImage.image = [UIImage imageNamed:@"orangecircle.png"];
                }
            }
        }
        else
        {
            cell.StatusImage.image = [UIImage imageNamed:@"tick.png"];
        }
    }
    
    switch ([[tempDict valueForKey:@"ProjectStatus"] intValue] ) {
        case 0:
            cell.imgRightArrow.hidden = NO;
            break;
        case 2:
            cell.imgRightArrow.hidden = NO;
            break;
        case 3:
            cell.imgRightArrow.hidden = NO;
            break;
        default:
            cell.imgRightArrow.hidden = YES;
            break;
    }

    cell.StatusLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"ReqStatus"]];
    cell.StatusLabel.adjustsFontSizeToFitWidth = YES;
        cell.StatusTimeLabel.adjustsFontSizeToFitWidth = YES;
    cell.StatusTimeLabel.text = [NSMutableString stringWithFormat:@"%@",[self convertDateFormat:[tempDict objectForKey:@"CreatedDate"]]];
    if (TableDataArray.count-1 == indexPath.row) {
        [cell.StatusProcessIndecatorLabel setHidden:YES];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    }
}

-(NSString*)convertDateFormat:(NSString*)strDate
{
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"MM/dd/yyyy hh:mm:ss a"];
    NSDate *expdate = [df dateFromString:strDate];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MMM/yyyy hh:mm:ss a"];
    NSLog(@"%@",[dateFormat stringFromDate:expdate]);
    return [dateFormat stringFromDate:expdate];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSMutableDictionary *inputDict ;
        ProjectStatus = [[TableDataArray objectAtIndex:indexPath.row] objectForKey:@"ProjectStatus"];
        PlaceOrder = [[TableDataArray objectAtIndex:indexPath.row] objectForKey:@"PlaceOrder"];
        NSNumber *regret = [[TableDataArray objectAtIndex:indexPath.row] objectForKey:@"ISRegretted"];
        NSNumber *reject = [[TableDataArray objectAtIndex:indexPath.row] objectForKey:@"ISRejected"];
        
        if(regret.boolValue == YES || reject.boolValue == YES)
        {
            rejectOrRegrett = YES;
        }
        else
        {
            rejectOrRegrett = NO;
        }
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
}
-(void)OrderDetails:(NSMutableDictionary *)inputDict {
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopRequestedQuoteDetailsService:inputDict];
    request =  nil;
}
-(void)requestReceivedopRequestedQuoteDetailsResponce:(NSMutableDictionary *)aregistrationDict
{

    if(ItemType.intValue == 0)
    {
        switch (ProjectStatus.intValue) {
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
                TSVMVCtrlObj.isRegrettedOrRejected = rejectOrRegrett;
                [self.navigationController pushViewController:TSVMVCtrlObj animated:YES];
            }
                break;
            case 3:
            {
                StatusViewModeViewController *TSVMVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"StatusViewModeViewController"];
                TSVMVCtrlObj.PlaceOrder = [NSMutableString stringWithFormat:@"%@",PlaceOrder];
                TSVMVCtrlObj.inputDataDictionary= aregistrationDict;
                TSVMVCtrlObj.isRegrettedOrRejected = rejectOrRegrett;
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
        switch (ProjectStatus.intValue) {
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
                TSVMVCtrlObj.isRjectOrRegretted = rejectOrRegrett;
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
                TSVMVCtrlObj.isRjectOrRegretted = rejectOrRegrett;
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
- (IBAction)btnBackClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
