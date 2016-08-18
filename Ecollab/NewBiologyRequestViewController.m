//
//  NewBiologyRequestViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 18/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "NewBiologyRequestViewController.h"

@interface NewBiologyRequestViewController (){
    UITableView *dropdownTableView;
    NSMutableArray *serviceArray,*areaArray,*subAreaArray,*modelArray;
    NSMutableDictionary * loadMasterDict;
    NSMutableString *Type,*SubID,*ModelID,*AreaID;
    int serFlag,modelflag ;
}

@end

@implementation NewBiologyRequestViewController
@synthesize ServiceBtnOutlet,AreaOutlet,SubAreaBtnOutlet,ModelsBtnOutlet,SubmitBtnOutlet,SaveForLaterBtnOutlet;
@synthesize OtherViewsDataDictionary;
@synthesize isFromRequestAQuote;
@synthesize dictSavedOrderDetails;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    /*
     [FAQLabelOutlet.layer setBorderWidth: 1.0];
     [FAQLabelOutlet.layer setCornerRadius:10.0f];
     [FAQLabelOutlet.layer setMasksToBounds:YES];
     [FAQLabelOutlet.layer setBorderColor:[[UIColor blackColor] CGColor]];
     */
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    [ServiceBtnOutlet.layer setBorderWidth: 1.0];
    [ServiceBtnOutlet.layer setMasksToBounds:YES];
    [ServiceBtnOutlet.layer setBorderColor:[[UIColor redColor] CGColor]];
    [AreaOutlet.layer setBorderWidth: 1.0];
    [AreaOutlet.layer setMasksToBounds:YES];
    [AreaOutlet.layer setBorderColor:[[UIColor redColor] CGColor]];
    [SubAreaBtnOutlet.layer setBorderWidth: 1.0];
    [SubAreaBtnOutlet.layer setMasksToBounds:YES];
    [SubAreaBtnOutlet.layer setBorderColor:[[UIColor redColor] CGColor]];
    [ModelsBtnOutlet.layer setBorderWidth: 1.0];
    [ModelsBtnOutlet.layer setMasksToBounds:YES];
    [ModelsBtnOutlet.layer setBorderColor:[[UIColor redColor] CGColor]];
    modelflag = 0;
    
//    serviceArray = [NSMutableArray arrayWithObjects:@"abc",@"bcd",@"cde",@"def", nil];
//    areaArray = [NSMutableArray arrayWithObjects:@"abc",@"bcd",@"cde",@"def", nil];
//    subAreaArray = [NSMutableArray arrayWithObjects:@"abc",@"bcd",@"cde",@"def", nil];
//    modelArray = [NSMutableArray arrayWithObjects:@"abc",@"bcd",@"cde",@"def", nil];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopLoadMasterService];
    request =  nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:true];
    NSLog(@"%d",isFromRequestAQuote);
    
    if(isFromRequestAQuote == YES)
    {
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
        self.lblRequestTitle.attributedText = [[NSAttributedString alloc] initWithString:@"NEW BIOLOGY REQUEST"
                                                                 attributes:underlineAttribute];
    }
    else
    {
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
        self.lblRequestTitle.attributedText = [[NSAttributedString alloc] initWithString:@"EDIT BIOLOGY REQUEST"
                                                                 attributes:underlineAttribute];
    }
}

-(void)showViewAssays:(BOOL)shouldShow
{
    if(shouldShow == YES)
    {
        self.viewAssaysHeightConstraint.constant = 60;
        self.viewAssays.hidden = NO;
    }
    else
    {
        self.viewAssaysHeightConstraint.constant = 0;
        self.viewAssays.hidden = YES;
    }
}

-(void)showViewSubArea:(BOOL)shouldShow
{
    if(shouldShow == YES)
    {
        self.viewSubAreaHeightConstraint.constant = 60;
        self.viewSubArea.hidden = NO;
    }
    else
    {
        self.viewSubAreaHeightConstraint.constant = 0;
        self.viewSubArea.hidden = YES;
    }
}

-(void)bindSavedOrderDetails:(NSMutableDictionary *)dict
{
    if(isFromRequestAQuote)
    {
        return;
    }

    {
        NSString *strService = [dict objectForKey:@"Service"];
        NSString *area = [dict objectForKey:@"Area"];
        NSString *subArea = [dict objectForKey:@"SubArea"];
        NSString *modelIds = [dict objectForKey:@"MultipleModelValues"];
        if(modelIds.length == 0)
        {
            modelIds = @"SELECT ASSAYS/MODELS";
        }
        
        [ServiceBtnOutlet setTitle:strService forState:UIControlStateNormal];
        [ServiceBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [AreaOutlet setTitle:area forState:UIControlStateNormal];
        [AreaOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [SubAreaBtnOutlet setTitle:subArea forState:UIControlStateNormal];
        [SubAreaBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [ModelsBtnOutlet setTitle:modelIds forState:UIControlStateNormal];
        [ModelsBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    isFromRequestAQuote = YES;
}

-(void)requestReceivedopLoadMasterResponce:(NSMutableDictionary *)aregistrationDict{
    NSLog(@"%@",aregistrationDict);
    NSLog(@"%@",[aregistrationDict objectForKey:@"SuccessCode"]);
    
    if([[aregistrationDict objectForKey:@"SuccessCode"] intValue]== 200)
    {
        loadMasterDict = aregistrationDict;
        serviceArray = [aregistrationDict objectForKey:@"ServiceMaster"];
        
        if(serviceArray.count != 0)
        {
            NSDictionary *dict = [serviceArray objectAtIndex:0];
            
            serFlag = 0;
            [ServiceBtnOutlet setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Service"]] forState:UIControlStateNormal];
            [ServiceBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            Type = [NSMutableString stringWithFormat:@"0"];
            //*Type,*SubID,*ModelID;  //RID Service
            if(isFromRequestAQuote)
            {
                SubID = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];
            }
            else
            {
                SubID = [NSMutableString stringWithFormat:@"%@",[dictSavedOrderDetails objectForKey:@"ServiceID"]];
            }
            ModelID = [NSMutableString stringWithFormat:@"0"];
            [self GetDependencyDetails];
        }

        
    }else{
        //show some alert
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ServiceBtnAction:(id)sender {
    if (dropdownTableView.tag == 20 || dropdownTableView.tag == 30 || dropdownTableView.tag == 40) {
        [[self.view viewWithTag:dropdownTableView.tag] removeFromSuperview];
    }
    
    dropdownTableView = [[UITableView alloc] initWithFrame:CGRectMake(ServiceBtnOutlet.frame.origin.x, ServiceBtnOutlet.frame.origin.y + ServiceBtnOutlet.frame.size.height,ServiceBtnOutlet.frame.size.width ,SubmitBtnOutlet.frame.origin.y+SubmitBtnOutlet.frame.size.height) style:UITableViewStylePlain] ;
    dropdownTableView.dataSource = self;
    dropdownTableView.delegate = self;
    [dropdownTableView setTag:10];
    [self.view addSubview:dropdownTableView];
}

- (IBAction)AreaBtnAction:(id)sender {
    if (dropdownTableView.tag == 10 || dropdownTableView.tag == 30 || dropdownTableView.tag == 40) {
        [[self.view viewWithTag:dropdownTableView.tag] removeFromSuperview];
    }
    dropdownTableView = [[UITableView alloc] initWithFrame:CGRectMake(AreaOutlet.frame.origin.x, AreaOutlet.frame.origin.y + AreaOutlet.frame.size.height,AreaOutlet.frame.size.width ,SubmitBtnOutlet.frame.origin.y-AreaOutlet.frame.origin.y) style:UITableViewStylePlain] ;
    dropdownTableView.dataSource = self;
    dropdownTableView.delegate = self;
    [dropdownTableView setTag:20];
    [self.view addSubview:dropdownTableView];
}

- (IBAction)SubAreaBtnAction:(id)sender {
    
    if (dropdownTableView.tag == 20 || dropdownTableView.tag == 10 || dropdownTableView.tag == 40) {
        [[self.view viewWithTag:dropdownTableView.tag] removeFromSuperview];
    }
    dropdownTableView = [[UITableView alloc] initWithFrame:CGRectMake(_viewSubArea.frame.origin.x, _viewSubArea.frame.origin.y,_viewSubArea.frame.size.width ,_viewAssays.frame.origin.y-ServiceBtnOutlet.frame.origin.y) style:UITableViewStylePlain] ;
    dropdownTableView.dataSource = self;
    dropdownTableView.delegate = self;
    [dropdownTableView setTag:30];
    [self.view addSubview:dropdownTableView];
}

- (IBAction)ModelsBtnAction:(id)sender {
    if (dropdownTableView.tag == 20 || dropdownTableView.tag == 30 || dropdownTableView.tag == 10) {
        [[self.view viewWithTag:dropdownTableView.tag] removeFromSuperview];
    }
    dropdownTableView = [[UITableView alloc] initWithFrame:CGRectMake(ModelsBtnOutlet.frame.origin.x, ServiceBtnOutlet.frame.origin.y-20,ModelsBtnOutlet.frame.size.width ,ModelsBtnOutlet.frame.origin.y-ServiceBtnOutlet.frame.origin.y) style:UITableViewStylePlain] ;
    dropdownTableView.dataSource = self;
    dropdownTableView.delegate = self;
    [dropdownTableView setTag:40];
    [self.view addSubview:dropdownTableView];
    
}

- (IBAction)SubmitBtnAction:(id)sender {
    //3
    NSMutableDictionary *inputDick = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"RID",@"1",@"UID",@"0",@"ServiceID",@"0",@"AreaID",@"0",@"SubAreaID",@"0",@"ModelID",@"0",@"PurityID",@"0",@"ISSubmit",@"0",@"Status",@"",@"Image",@"1",@"MultipleModelIDS",nil];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopInsertBiologyRequestService:inputDick];
    request =  nil;
}

- (IBAction)SaveForLaterBtnAction:(id)sender {
    
}
-(void)requestReceivedopInsertBiologyRequestResponce:(NSMutableDictionary *)aregistrationDict{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (dropdownTableView.tag == 10) {
        return serviceArray.count;
    }else if (dropdownTableView.tag == 20){
        return areaArray.count;
    }else if (dropdownTableView.tag == 30){
        return subAreaArray.count;
    }else if (dropdownTableView.tag == 40){
        return modelArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    if (dropdownTableView.tag == 10) {
        NSDictionary *dict = [serviceArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Service"]];
    }else if (dropdownTableView.tag == 20){
        NSDictionary *dict = [areaArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]];
    }else if (dropdownTableView.tag == 30){
        NSDictionary *dict = [subAreaArray objectAtIndex:indexPath.row];
         cell.textLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]];
    }else if (dropdownTableView.tag == 40){
        NSDictionary *dict = [modelArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]];
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [[self.view viewWithTag:dropdownTableView.tag] removeFromSuperview];
    
    if (dropdownTableView.tag == 10) {
        serFlag = 0;
        NSDictionary *dict = [serviceArray objectAtIndex:indexPath.row];
        [ServiceBtnOutlet setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Service"]] forState:UIControlStateNormal];
        [ServiceBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        Type = [NSMutableString stringWithFormat:@"0"];
        //*Type,*SubID,*ModelID;  //RID Service
        SubID = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];
        ModelID = [NSMutableString stringWithFormat:@"0"];
        [self GetDependencyDetails];
    }else if (dropdownTableView.tag == 20){
        serFlag = 1;
        NSDictionary *dict = [areaArray objectAtIndex:indexPath.row];
        [AreaOutlet setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]] forState:UIControlStateNormal];
        [AreaOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        Type = [NSMutableString stringWithFormat:@"1"];
        SubID = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];
        AreaID = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];
        ModelID = [NSMutableString stringWithFormat:@"0"];
        [self GetDependencyDetails];
        
//        Type = [NSMutableString stringWithFormat:@"2"];
//        SubID = AreaID;
//        ModelID = [NSMutableString stringWithFormat:@"0"];
//
//        [self GetDependencyDetails];

    }else if (dropdownTableView.tag == 30){
        serFlag = 2;

        NSDictionary *dict = [subAreaArray objectAtIndex:indexPath.row];

        [SubAreaBtnOutlet setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]] forState:UIControlStateNormal];
        [SubAreaBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        Type = [NSMutableString stringWithFormat:@"3"];
        SubID = [NSMutableString stringWithFormat:@"%@",AreaID];
        ModelID =  [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];
        [self GetDependencyDetails];

    }else if (dropdownTableView.tag == 40){
//        NSDictionary *dict = [modelArray objectAtIndex:indexPath.row];
//        [ModelsBtnOutlet setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]] forState:UIControlStateNormal];
//        [ModelsBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [self GetDependencyDetails];
    }
   [[self.view viewWithTag:dropdownTableView.tag] removeFromSuperview];
}
-(void)GetDependencyDetails{
    
    NSMutableDictionary *inputDick = [NSMutableDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%@",[[DetailsManager sharedManager]rID]],@"UID",Type,@"Type",SubID,@"SubID",ModelID,@"ModelID",nil];
    
    //NSDictionary *inputDick = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"UID",@"1",@"Type",@"1",@"SubID",@"1",@"ModelID",nil];
    //sevice id
    //type 0 uid (service id /subid) modelid 0
    // area area id
    //type 1 (area id /subid) modelid 0
    // sub area id
    //type 2 (area id /subid) modelid 0
    // sa mode id
    // type 3 (area id /subid) (subareid /subarea id)
    
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopGetDependencyDetailsService:inputDick];
    request =  nil;
}
-(void)requestReceivedopGetDependencyDetailsResponce:(NSMutableDictionary *)aregistrationDict{
    if (serFlag == 0)
    {
        areaArray = [aregistrationDict objectForKey:@"DependencyDetailsResult"];
        if(areaArray.count != 0)
        {
            serFlag = 1;
            Type = [NSMutableString stringWithFormat:@"1"];
            if(isFromRequestAQuote)
            {
                NSDictionary *dictFirstObject = [areaArray objectAtIndex:0];
                [AreaOutlet setTitle:[NSString stringWithFormat:@"%@",[dictFirstObject objectForKey:@"Description"]] forState:UIControlStateNormal];
                [AreaOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                SubID = [NSMutableString stringWithFormat:@"%@",[dictFirstObject objectForKey:@"RID"]];
                AreaID = [NSMutableString stringWithFormat:@"%@",[dictFirstObject objectForKey:@"RID"]];
            }
            else
            {
                SubID = [NSMutableString stringWithFormat:@"%@",[dictSavedOrderDetails objectForKey:@"AreaID"]];
                AreaID = [NSMutableString stringWithFormat:@"%@",[dictSavedOrderDetails objectForKey:@"AreaID"]];
            }
            ModelID = [NSMutableString stringWithFormat:@"0"];
            [self GetDependencyDetails];
        }
    }
    else if (serFlag == 1)
    {
        if (modelflag == 0)
        {
            subAreaArray = [aregistrationDict objectForKey:@"DependencyDetailsResult"];
            if(subAreaArray.count != 0)
            {
                serFlag = 2;
                [self showViewSubArea:YES];
                Type = [NSMutableString stringWithFormat:@"3"];
                SubID = [NSMutableString stringWithFormat:@"%@",AreaID];
                if(isFromRequestAQuote)
                {
                    NSDictionary *dict = [subAreaArray objectAtIndex:0];
                    [SubAreaBtnOutlet setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]] forState:UIControlStateNormal];
                    [SubAreaBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    ModelID =  [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];
                    
                }
                else
                {
                    ModelID =  [NSMutableString stringWithFormat:@"%@",[dictSavedOrderDetails objectForKey:@"SubAreaID"]];
                }
                [self GetDependencyDetails];
            }
            else
            {
                [self showViewSubArea:NO];
                Type = [NSMutableString stringWithFormat:@"2"];
                SubID = AreaID;
                ModelID = [NSMutableString stringWithFormat:@"0"];
                modelflag = 1;
                [self GetDependencyDetails];
            }
            
        }
        else
        {
            [self bindSavedOrderDetails:dictSavedOrderDetails];
            modelArray = [aregistrationDict objectForKey:@"DependencyDetailsResult"];
            
            if(modelArray.count == 0)
            {
                [self showViewAssays:NO];
            }
            else
            {
                [self showViewAssays:YES];
            }
            modelflag = 0;
        }
    }
    else if (serFlag == 2){
        [self bindSavedOrderDetails:dictSavedOrderDetails];
        modelArray = [aregistrationDict objectForKey:@"DependencyDetailsResult"];
        if(modelArray.count != 0)
        {
            [self showViewAssays:YES];
        }
        else
        {
            [self showViewAssays:NO];
        }
    }
}

@end