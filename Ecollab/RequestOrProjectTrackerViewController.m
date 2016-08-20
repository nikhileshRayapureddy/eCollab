//
//  RequestOrProjectTrackerViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "RequestOrProjectTrackerViewController.h"

@interface RequestOrProjectTrackerViewController (){
    NSMutableDictionary *UserProjectTrackerDetailsResult;
    NSMutableArray *RequestedQuotesArray,*OnGoingProjectsArray;
    int TableFlag;
    NSMutableString *ItemType;
}

@end

@implementation RequestOrProjectTrackerViewController
@synthesize RequestOrProjectTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    TableFlag = 0;
    [RequestOrProjectTableView setDelegate:self];
    [RequestOrProjectTableView setDataSource:self];
    [_RequestedQuotesBtnOutlet setBackgroundImage:[UIImage imageNamed:@"requestquote.jpg"] forState:UIControlStateNormal];//requestquote.jpg
    [_OnGoingProjectsBtnOutlet setBackgroundImage:[UIImage imageNamed:@"on-going-1.png"] forState:UIControlStateNormal];//ongoingprojexts.jpg

//
//    ServiceRequester *request = [ServiceRequester new];
//    request.serviceRequesterDelegate =  self;
//    [request requestFopGetProjectTrackerDetailsService];
//    request =  nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestFopGetProjectTrackerDetailsService];
    request =  nil;

}
-(void)requestReceivedopGetProjectTrackerDetailsResponce:(NSMutableDictionary *)aregistrationDict{
    UserProjectTrackerDetailsResult = aregistrationDict;
    NSMutableArray * UserProjectTrackerArray = [UserProjectTrackerDetailsResult objectForKey:@"UserProjectTrackerDetailsResult"];
    OnGoingProjectsArray = [NSMutableArray new];
    RequestedQuotesArray = [NSMutableArray new];

    for (int counter=0; counter<UserProjectTrackerArray.count; counter++) {
        NSMutableDictionary * tempDict = [UserProjectTrackerArray objectAtIndex:counter];
        if ([[tempDict objectForKey:@"PlaceOrder"] intValue]==1 && [[tempDict objectForKey:@"ItemType"] intValue] == 0) {
            [OnGoingProjectsArray addObject:[UserProjectTrackerArray objectAtIndex:counter]];
            [RequestedQuotesArray addObject:[UserProjectTrackerArray objectAtIndex:counter]];
        }else{
            [RequestedQuotesArray addObject:[UserProjectTrackerArray objectAtIndex:counter]];
        }
    }
    NSLog(@"%lu     %lu",(unsigned long)RequestedQuotesArray.count,(unsigned long)OnGoingProjectsArray.count);
    [RequestOrProjectTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (TableFlag == 0) {
        return RequestedQuotesArray.count;
    }else{
        return OnGoingProjectsArray.count;
    }
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"RequestOrProjectTableViewCellID";
    //RequestOrProjectTableViewCell
    RequestOrProjectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[RequestOrProjectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //chemistry.png
    //biology.png biologysaved.png
    if (TableFlag == 0) {
        // request
        NSMutableDictionary * tempDict =[RequestedQuotesArray objectAtIndex:indexPath.row];
        NSLog(@"QQQQQQ = %@",[tempDict objectForKey:@"QuoteStatus"]);
        
        if ([[tempDict objectForKey:@"ItemType"] intValue]==0) {
            cell.RequestOrProjectType.image = [UIImage imageNamed:@"chemistrysaved.png"];
            cell.RequestOrProjectNameLabel.text = [NSMutableString stringWithFormat:@"CHEMISTRY"];
        }else{
            cell.RequestOrProjectType.image = [UIImage imageNamed:@"biologysaved.png"];
            cell.RequestOrProjectNameLabel.text = [NSMutableString stringWithFormat:@"BIOLOGY"];
        }
        
        cell.RequestOrProjectIDLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"OrderNumber"]];
        
        
        if ([[tempDict objectForKey:@"ISRegretted"] intValue] == 1) {
            cell.RequestOrProjectStatusLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"RegrettedStatus"]];
        }else if ([[tempDict objectForKey:@"ISRejected"] intValue] == 1) {
            cell.RequestOrProjectStatusLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"RejectComments"]];
        }else{
            cell.RequestOrProjectStatusLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"QuoteStatusDesc"]];
        }
        //orangecircle.png
        //tick.png

        if ([[tempDict objectForKey:@"QuoteStatus"] intValue]== 0) {
            // orange image
            cell.StatuImageOne.image = [UIImage imageNamed:@"orangecircle.png"];
            cell.StatusImageTwo.image = [UIImage imageNamed:@"graycircle.png"];
            cell.StatusImageThree.image = [UIImage imageNamed:@"graycircle.png"];
            cell.StatusImageFour.image = [UIImage imageNamed:@"graycircle.png"];
        }else if ([[tempDict objectForKey:@"QuoteStatus"] intValue]== 1) {
            // green image
            cell.StatuImageOne.image = [UIImage imageNamed:@"tick.png"];
            // orange image
            cell.StatusImageTwo.image = [UIImage imageNamed:@"orangecircle.png"];
            cell.StatusImageThree.image = [UIImage imageNamed:@"graycircle.png"];
            cell.StatusImageFour.image = [UIImage imageNamed:@"graycircle.png"];

        }else if ([[tempDict objectForKey:@"QuoteStatus"] intValue]== 2) {
            // green image
            cell.StatuImageOne.image = [UIImage imageNamed:@"tick.png"];
            // green image
            cell.StatusImageTwo.image = [UIImage imageNamed:@"tick.png"];
            // orange image
            cell.StatusImageThree.image = [UIImage imageNamed:@"orangecircle.png"];
            cell.StatusImageFour.image = [UIImage imageNamed:@"graycircle.png"];

        }else  if ([[tempDict objectForKey:@"QuoteStatus"] intValue]== 3)
        {
            if([[tempDict valueForKey:@"PlaceOrder"] intValue] == 0 )
            {
                cell.StatuImageOne.image = [UIImage imageNamed:@"tick.png"];
                cell.StatusImageTwo.image = [UIImage imageNamed:@"tick.png"];
                cell.StatusImageThree.image = [UIImage imageNamed:@"tick.png"];
                cell.StatusImageFour.image = [UIImage imageNamed:@"orangecircle.png"];
            }
            else
            {
                cell.StatuImageOne.image = [UIImage imageNamed:@"tick.png"];
                cell.StatusImageTwo.image = [UIImage imageNamed:@"tick.png"];
                cell.StatusImageThree.image = [UIImage imageNamed:@"tick.png"];
                cell.StatusImageFour.image = [UIImage imageNamed:@"tick.png"];
            }
        }
        else
        {
            // green image
            cell.StatuImageOne.image = [UIImage imageNamed:@"tick.png"];
            cell.StatusImageTwo.image = [UIImage imageNamed:@"tick.png"];
            cell.StatusImageThree.image = [UIImage imageNamed:@"tick.png"];
            cell.StatusImageFour.image = [UIImage imageNamed:@"tick.png"];

        }
        cell.StatusStageOneLabel.text = [NSMutableString stringWithFormat:@"RECEIVED"];
        cell.StatusStageTwoLabel.text = [NSMutableString stringWithFormat:@"UNDER PROCESS"];
        cell.StatusStageThreeLabel.text = [NSMutableString stringWithFormat:@"QUOTE SENT"];
        cell.StatusStageFourLabel.text = [NSMutableString stringWithFormat:@"ACCEPTANCE"];

    }else{
        // ongoing
        NSMutableDictionary * tempDict =[OnGoingProjectsArray objectAtIndex:indexPath.row];
        NSLog(@"QQQQQQ = %@",[tempDict objectForKey:@"QuoteStatus"]);
        if ([[tempDict objectForKey:@"ItemType"] intValue]==0) {
            cell.RequestOrProjectType.image = [UIImage imageNamed:@"chemistrysaved.png"];
            cell.RequestOrProjectNameLabel.text = [NSMutableString stringWithFormat:@"CHEMISTRY"];
        }
//            else{
//            cell.RequestOrProjectType.image = [UIImage imageNamed:@"biologysaved.png"];
//            cell.RequestOrProjectNameLabel.text = [NSMutableString stringWithFormat:@"BIOLOGY"];
//        }
        cell.RequestOrProjectIDLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"OrderNumber"]];
        
        if ([[tempDict objectForKey:@"ISRegretted"] intValue] == 1) {
            cell.RequestOrProjectStatusLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"RegrettedStatus"]];
        }else if ([[tempDict objectForKey:@"ISRejected"] intValue] == 1) {
            cell.RequestOrProjectStatusLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"RejectComments"]];
        }else{
            cell.RequestOrProjectStatusLabel.text = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"ProjectStatusDesc"]];
        }
        
        if ([[tempDict objectForKey:@"ProjectStatus"] intValue]== 0) {
            // orange image
            cell.StatuImageOne.image = [UIImage imageNamed:@"orangecircle.png"];
            
            cell.StatusImageTwo.image = [UIImage imageNamed:@"graycircle.png"];
            cell.StatusImageThree.image = [UIImage imageNamed:@"graycircle.png"];
            cell.StatusImageFour.image = [UIImage imageNamed:@"graycircle.png"];
        }else if ([[tempDict objectForKey:@"ProjectStatus"] intValue]== 1) {
            // green image
            cell.StatuImageOne.image = [UIImage imageNamed:@"tick.png"];
            // orange image
            cell.StatusImageTwo.image = [UIImage imageNamed:@"orangecircle.png"];
            cell.StatusImageThree.image = [UIImage imageNamed:@"graycircle.png"];
            cell.StatusImageFour.image = [UIImage imageNamed:@"graycircle.png"];
            
        }else if ([[tempDict objectForKey:@"ProjectStatus"] intValue]== 2) {
            // green image
            cell.StatuImageOne.image = [UIImage imageNamed:@"tick.png"];
            // green image
            cell.StatusImageTwo.image = [UIImage imageNamed:@"tick.png"];
            // orange image
            cell.StatusImageThree.image = [UIImage imageNamed:@"orangecircle.png"];
            cell.StatusImageFour.image = [UIImage imageNamed:@"graycircle.png"];

        }else{
            // green image
            cell.StatuImageOne.image = [UIImage imageNamed:@"tick.png"];
            cell.StatusImageTwo.image = [UIImage imageNamed:@"tick.png"];
            cell.StatusImageThree.image = [UIImage imageNamed:@"tick.png"];
            cell.StatusImageFour.image = [UIImage imageNamed:@"tick.png"];
            
        }
        cell.StatusStageOneLabel.text = [NSMutableString stringWithFormat:@"INITIATED"];
        cell.StatusStageTwoLabel.text = [NSMutableString stringWithFormat:@"RAW METERIALS"];
        cell.StatusStageThreeLabel.text = [NSMutableString stringWithFormat:@"SYNTHESIS"];
        cell.StatusStageFourLabel.text = [NSMutableString stringWithFormat:@"SHIPPED"];
        
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSMutableDictionary *inputDick;
    if (TableFlag == 0) {
        NSMutableDictionary * tempDict =[RequestedQuotesArray objectAtIndex:indexPath.row];
        ItemType = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"ItemType"]];
        NSLog(@"RequestedQuotesArray tempdict = %@",tempDict);
        inputDick = [NSMutableDictionary dictionaryWithObjectsAndKeys:[tempDict objectForKey:@"RID"],@"orderid",[tempDict objectForKey:@"ItemType"],@"ordertype", nil];

    }else{
        NSMutableDictionary * tempDict =[OnGoingProjectsArray objectAtIndex:indexPath.row];
        ItemType = [NSMutableString stringWithFormat:@"%@",[tempDict objectForKey:@"ItemType"]];

        NSLog(@"OnGoingProjectsArray tempdict = %@",tempDict);
        inputDick = [NSMutableDictionary dictionaryWithObjectsAndKeys:[tempDict objectForKey:@"RID"],@"orderid",[tempDict objectForKey:@"ItemType"],@"ordertype", nil];
    }


    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopTrackSelecctedOrderDetailsService:inputDick];
    request =  nil;
}
-(void)requestReceivedopTrackSelecctedOrderDetailsResponce:(NSMutableDictionary *)aregistrationDict{
    NSLog(@"%@",aregistrationDict);
    
    TrackingStatusViewController *TSVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"TrackingStatusViewController"];
    TSVCtrlObj.MainDataDictionary = aregistrationDict;
    TSVCtrlObj.ItemType = ItemType;
    [self.navigationController pushViewController:TSVCtrlObj animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 [_RequestedQuotesBtnOutlet setBackgroundImage:[UIImage imageNamed:@"requestquote.jpg"] forState:UIControlStateNormal];//requestquote.jpg
 [_OnGoingProjectsBtnOutlet setBackgroundImage:[UIImage imageNamed:@"on-going-1.png"] forState:UIControlStateNormal];//ongoingprojexts.jpg

 */

- (IBAction)RequestedQuotesBtnAction:(id)sender {
    TableFlag = 0;
    [RequestOrProjectTableView reloadData];
    [_RequestedQuotesBtnOutlet setBackgroundImage:[UIImage imageNamed:@"requestquote.jpg"] forState:UIControlStateNormal];
    [_OnGoingProjectsBtnOutlet setBackgroundImage:[UIImage imageNamed:@"on-going-1.png"] forState:UIControlStateNormal];//ongoingprojexts.jpg
}

- (IBAction)OnGoingProjectsBtnAction:(id)sender {
    TableFlag = 1;
    [RequestOrProjectTableView reloadData];
    [_OnGoingProjectsBtnOutlet setBackgroundImage:[UIImage imageNamed:@"ongoingprojexts.jpg"] forState:UIControlStateNormal];
    [_RequestedQuotesBtnOutlet setBackgroundImage:[UIImage imageNamed:@"request.png"] forState:UIControlStateNormal];
}
@end
