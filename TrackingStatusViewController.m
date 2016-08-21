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
        self.lblStatus.text = [NSString stringWithFormat:@"%@",[dictOrderDetails objectForKey:@"ReqStatus"]];
        self.lblRequestNumber.text = [dictOrderDetails objectForKey:@"OrderNumber"];
        strRequestRID = [dictOrderDetails objectForKey:@"RID"];

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
    
    UIImageView *imgLogoGVK = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    imgLogoGVK.backgroundColor = [UIColor clearColor];
    imgLogoGVK.image = [UIImage imageNamed:@"gvk_whitelogo1.png"];
    imgLogoGVK.contentMode = UIViewContentModeScaleAspectFit;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:imgLogoGVK];
    self.navigationItem.rightBarButtonItem = rightBtn;
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
    cell.StatusTimeLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"CreatedDate"]];
    if (TableDataArray.count-1 == indexPath.row) {
        [cell.StatusProcessIndecatorLabel setHidden:YES];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
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
@end
