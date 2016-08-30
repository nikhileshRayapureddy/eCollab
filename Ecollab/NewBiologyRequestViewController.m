//
//  NewBiologyRequestViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 18/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "NewBiologyRequestViewController.h"
#import "DashboardViewController.h"

@interface NewBiologyRequestViewController (){
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

@synthesize strServiceIDFinal;
@synthesize strAreaIDFinal;
@synthesize strSubAreaIDFinal;
@synthesize strMultipleModelIdIDFinal;
@synthesize shouldUpdateRequest;
@synthesize strRIDForSavedRequest;
@synthesize isSubmitAction;

@synthesize isFromTracking;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self designTabBar];
    [self setSelected:0];
    arrAssaysSelected = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    /*
     [FAQLabelOutlet.layer setBorderWidth: 1.0];
     [FAQLabelOutlet.layer setCornerRadius:10.0f];
     [FAQLabelOutlet.layer setMasksToBounds:YES];
     [FAQLabelOutlet.layer setBorderColor:[[UIColor blackColor] CGColor]];
     */
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

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width, 450);
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
    else if(shouldUpdateRequest == YES)
    {
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
        self.lblRequestTitle.attributedText = [[NSAttributedString alloc] initWithString:@"EDIT BIOLOGY REQUEST"
                                                                 attributes:underlineAttribute];
    }
    else if(isFromTracking == YES)
    {
        NSDictionary *underlineAttribute = @{NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle)};
        self.lblRequestTitle.attributedText = [[NSAttributedString alloc] initWithString:@"BIOLOGY REQUEST DETAILS"
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

-(void)bindOrderDetailsFromTracking:(NSMutableDictionary *)dict
{
    if(isFromRequestAQuote || shouldUpdateRequest)
    {
        return;
    }
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
    
    ModelsBtnOutlet.titleLabel.numberOfLines = 2;
    [ModelsBtnOutlet setTitle:modelIds forState:UIControlStateNormal];
    [ModelsBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    isFromRequestAQuote = YES;
    
    strServiceIDFinal = [dict objectForKey:@"ServiceID"];
    strAreaIDFinal = [dict objectForKey:@"AreaID"];
    strSubAreaIDFinal = [dict objectForKey:@"SubAreaID"];
    strMultipleModelIdIDFinal = [dict objectForKey:@"MultipleModelIDs"];
    
    self.imgServiceDownArrow.hidden = YES;
    self.imgAreaDownArrow.hidden = YES;
    self.imgSubAreaDownArrow.hidden = YES;
    self.imgModelsDownArrow.hidden = YES;
    
    ServiceBtnOutlet.userInteractionEnabled = NO;
    AreaOutlet.userInteractionEnabled = NO;
    SubAreaBtnOutlet.userInteractionEnabled = NO;
    ModelsBtnOutlet.userInteractionEnabled = NO;
    
    SubmitBtnOutlet.hidden = YES;
    SaveForLaterBtnOutlet.hidden = YES;
}

-(void)bindSavedOrderDetails:(NSMutableDictionary *)dict
{
    if(isFromRequestAQuote || isFromTracking)
    {
        return;
    }
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
    
    ModelsBtnOutlet.titleLabel.numberOfLines = 2;
    [ModelsBtnOutlet setTitle:modelIds forState:UIControlStateNormal];
    [ModelsBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    isFromRequestAQuote = YES;
    
    strServiceIDFinal = [dict objectForKey:@"ServiceID"];
    strAreaIDFinal = [dict objectForKey:@"AreaID"];
    strSubAreaIDFinal = [dict objectForKey:@"SubAreaID"];
    strMultipleModelIdIDFinal = [dict objectForKey:@"MultipleModelIDs"];
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
            strServiceIDFinal = [dict objectForKey:@"RID"];
            Type = [NSMutableString stringWithFormat:@"0"];
            //*Type,*SubID,*ModelID;  //RID Service
            if(isFromRequestAQuote == YES)
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
    
    [self showBiologyOptionSelectionForTag:10];
}

- (IBAction)AreaBtnAction:(id)sender {
    
    [self showBiologyOptionSelectionForTag:20];
}

- (IBAction)SubAreaBtnAction:(id)sender {
    
    [self showBiologyOptionSelectionForTag:30];
}

- (IBAction)ModelsBtnAction:(id)sender {
    [self showBiologyOptionSelectionForTag:40];
}

- (IBAction)SubmitBtnAction:(id)sender {
    //3
    if(self.viewAssays.hidden == YES)
    {
        
    }
    else
    {
        if([ModelsBtnOutlet.titleLabel.text  isEqual: @"SELECT ASSAYS/MODELS"])
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                           message:@"Please select at least one option from Assay/Models."
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    
    isSubmitAction = YES;
    NSString *strUserId = [[DetailsManager sharedManager]rID];
    
    NSMutableDictionary *dictRequest = [[NSMutableDictionary alloc]init];
    [dictRequest setObject:strUserId forKey:@"UID"];
    [dictRequest setValue:strServiceIDFinal forKey:@"ServiceID"];
    [dictRequest setValue:strAreaIDFinal forKey:@"AreaID"];
    [dictRequest setValue:strSubAreaIDFinal forKey:@"SubAreaID"];
    [dictRequest setObject:strMultipleModelIdIDFinal.length?strMultipleModelIdIDFinal:@"" forKey:@"MultipleModelIDS"];
    [dictRequest setObject:@"0" forKey:@"ModelID"];
    [dictRequest setObject:@"1" forKey:@"ISSubmit"];
    [dictRequest setObject:@"1" forKey:@"Status"];
    [dictRequest setObject:strUserId forKey:@"CreatedBy"];
    if(shouldUpdateRequest == YES)
    {
        [dictRequest setValue:strRIDForSavedRequest forKey:@"RID"];
    }
    
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopInsertBiologyRequestService:dictRequest];
    request =  nil;
}

- (IBAction)SaveForLaterBtnAction:(id)sender {
    isSubmitAction = NO;
    NSString *strUserId = [[DetailsManager sharedManager]rID];
    
    NSMutableDictionary *dictRequest = [[NSMutableDictionary alloc]init];
    [dictRequest setObject:strUserId forKey:@"UID"];
    [dictRequest setValue:strServiceIDFinal forKey:@"ServiceID"];
    [dictRequest setValue:strAreaIDFinal forKey:@"AreaID"];
    [dictRequest setValue:strSubAreaIDFinal forKey:@"SubAreaID"];
    [dictRequest setObject:@"0" forKey:@"ModelID"];
    [dictRequest setObject:@"0" forKey:@"ISSubmit"];
    [dictRequest setObject:@"1" forKey:@"Status"];
    [dictRequest setObject:strUserId forKey:@"CreatedBy"];
    [dictRequest setObject:strMultipleModelIdIDFinal.length?strMultipleModelIdIDFinal:@"" forKey:@"MultipleModelIDS"];
    
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    if(shouldUpdateRequest)
    {
        [dictRequest setObject:strRIDForSavedRequest forKey:@"RID"];
        
        [request requestForopUpdateBiologyRequestService:dictRequest];
    }
    else
    {
        [request requestForopInsertBiologyRequestService:dictRequest];
    }

    request =  nil;

    
}
-(void)requestReceivedopInsertBiologyRequestResponce:(NSMutableDictionary *)aregistrationDict{
    
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    if(isSubmitAction == YES)
    {
        NSArray *array = [aregistrationDict objectForKey:@"NewBiologyRequestResult"];
        if(array.count)
        {
            NSDictionary *dictResponse = [array objectAtIndex:0];
            NSString *strStatusCode = [dictResponse objectForKey:@"SuccessCode"];
            if([strStatusCode  isEqual: @"200"])
            {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                               message:[dictResponse objectForKey:@"SuccessString"]
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        if ([vc isKindOfClass:[DashboardViewController class]])
                        {
                            for (UIViewController *vc in self.navigationController.viewControllers) {
                                if ([vc isKindOfClass:[DashboardViewController class]])
                                {
                                    [self.navigationController popToViewController:vc animated:YES];
                                }
                                
                                
                                
                            }
                        }
                        
                        
                        
                    }
                }];
                
                
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        }
        else
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                           message:[aregistrationDict objectForKey:@"SuccessString"]
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    else
    {
        if(shouldUpdateRequest)
        {
            NSString *strStatusCode = [aregistrationDict objectForKey:@"SuccessCode"];
            if([strStatusCode  isEqual: @"200"])
            {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                               message:[aregistrationDict objectForKey:@"SuccessString"]
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        if ([vc isKindOfClass:[DashboardViewController class]])
                        {
                            [self.navigationController popToViewController:vc animated:YES];
                        }
                        
                        
                        
                    }
                }];
                
                
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            else
            {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                               message:[aregistrationDict objectForKey:@"SuccessString"]
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                
                
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
                
            }
        }
        else
        {
            NSArray *array = [aregistrationDict objectForKey:@"NewBiologyRequestResult"];
            if(array.count)
            {
                NSDictionary *dictResponse = [array objectAtIndex:0];
                NSString *strStatusCode = [dictResponse objectForKey:@"SuccessCode"];
                if([strStatusCode  isEqual: @"200"])
                {
                    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                                   message:[dictResponse objectForKey:@"SuccessString"]
                                                                            preferredStyle:UIAlertControllerStyleAlert];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        for (UIViewController *vc in self.navigationController.viewControllers) {
                            if ([vc isKindOfClass:[DashboardViewController class]])
                            {
                                [self.navigationController popToViewController:vc animated:YES];
                            }
                            
                            
                            
                        }
                    }];
                    
                    
                    [alert addAction:okAction];
                    [self presentViewController:alert animated:YES completion:nil];
                    
                }
            }
            else
            {
                UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                               message:[aregistrationDict objectForKey:@"SuccessString"]
                                                                        preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                
                
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }
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
            if(isFromRequestAQuote == YES)
            {
                NSDictionary *dictFirstObject = [areaArray objectAtIndex:0];
                [AreaOutlet setTitle:[NSString stringWithFormat:@"%@",[dictFirstObject objectForKey:@"Description"]] forState:UIControlStateNormal];
                [AreaOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                strAreaIDFinal = [dictFirstObject objectForKey:@"RID"];
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
                if(isFromRequestAQuote == YES)
                {
                    NSDictionary *dict = [subAreaArray objectAtIndex:0];
                    [SubAreaBtnOutlet setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]] forState:UIControlStateNormal];
                    [SubAreaBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                    strSubAreaIDFinal = [dict objectForKey:@"RID"];
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
            if(shouldUpdateRequest == YES)
            {
                [self bindSavedOrderDetails:dictSavedOrderDetails];
            }
            if(isFromTracking == YES)
            {
                [self bindOrderDetailsFromTracking:dictSavedOrderDetails];
            }
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
        if(shouldUpdateRequest == YES)
        {
            [self bindSavedOrderDetails:dictSavedOrderDetails];
        }
        if(isFromTracking == YES)
        {
            [self bindOrderDetailsFromTracking:dictSavedOrderDetails];
        }
        
        modelArray = [aregistrationDict objectForKey:@"DependencyDetailsResult"];
        if(modelArray.count != 0)
        {
            NSDictionary *dict= [modelArray objectAtIndex:0];
            [ModelsBtnOutlet setTitle:[dict valueForKey:@"Description"] forState:UIControlStateNormal];
            strMultipleModelIdIDFinal = @"";
            strMultipleModelIdIDFinal = [NSString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];

            [self showViewAssays:YES];
        }
        else
        {
            [self showViewAssays:NO];
        }
    }
}

-(void)showBiologyOptionSelectionForTag:(NSInteger)tableTag
{
    if(viewDropDown)
    {
        viewDropDown.delegate = nil;
        [viewDropDown removeFromSuperview];
        viewDropDown = nil;
    }
    viewDropDown = [[BiologyDropDownListView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    viewDropDown.delegate = self;
    viewDropDown.tableViewTag = tableTag;
    
    switch (tableTag) {
        case 10:
        {
            [viewDropDown.arrTitles addObjectsFromArray:serviceArray];
        }
            break;
        case 20:
        {
            [viewDropDown.arrTitles addObjectsFromArray:areaArray];
        }
            break;
        case 30:
        {
            [viewDropDown.arrTitles addObjectsFromArray:subAreaArray];
        }
            break;
        case 40:
        {
            [viewDropDown.arrTitles addObjectsFromArray:modelArray];
            [viewDropDown.arrCellSelected addObjectsFromArray:arrAssaysSelected];
        }
            break;
            
        default:
            break;
    }
    [viewDropDown reloadData];
    viewDropDown.backgroundColor = [UIColor clearColor];
    [self.view addSubview:viewDropDown];
}

-(void)removeSelectionPopUp
{
    if(viewDropDown)
    {
        viewDropDown.delegate = nil;
        [viewDropDown removeFromSuperview];
        viewDropDown = nil;
    }
}

-(void)selectedDictionary:(NSDictionary *)dict forTag:(NSInteger)tagSelected
{
    
    switch (tagSelected) {
        case 10:
        {
            serFlag = 0;
            [ServiceBtnOutlet setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Service"]] forState:UIControlStateNormal];
            [ServiceBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            strServiceIDFinal = [dict objectForKey:@"RID"];
            
            Type = [NSMutableString stringWithFormat:@"0"];
            //*Type,*SubID,*ModelID;  //RID Service
            SubID = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];
            ModelID = [NSMutableString stringWithFormat:@"0"];
            [self GetDependencyDetails];
        }
            break;
        case 20:
        {
            serFlag = 1;
            [AreaOutlet setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]] forState:UIControlStateNormal];
            [AreaOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            strAreaIDFinal = [dict objectForKey:@"RID"];
            Type = [NSMutableString stringWithFormat:@"1"];
            SubID = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];
            AreaID = [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];
            ModelID = [NSMutableString stringWithFormat:@"0"];
            [self GetDependencyDetails];
        }
            break;
        case 30:
        {
            serFlag = 2;
            
            [SubAreaBtnOutlet setTitle:[NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]] forState:UIControlStateNormal];
            [SubAreaBtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            strSubAreaIDFinal = [dict objectForKey:@"RID"];
            Type = [NSMutableString stringWithFormat:@"3"];
            SubID = [NSMutableString stringWithFormat:@"%@",AreaID];
            ModelID =  [NSMutableString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];
            [self GetDependencyDetails];
        }
            break;
        default:
            break;
    }
    [self removeSelectionPopUp];
}

-(void)selectedListOfAssays:(NSMutableArray *)arrCellSelected
{
    NSString *strSelectedModels = @"";
    strMultipleModelIdIDFinal = @"";
    for(NSIndexPath *indexpath in arrCellSelected)
    {
        NSDictionary *dict = [modelArray objectAtIndex:indexpath.row];
        
        if(strMultipleModelIdIDFinal.length)
        {
            strMultipleModelIdIDFinal = [NSString stringWithFormat:@"%@,%@",strMultipleModelIdIDFinal,[dict objectForKey:@"RID"]];
        }
        else
        {
            strMultipleModelIdIDFinal = [NSString stringWithFormat:@"%@",[dict objectForKey:@"RID"]];
        }

        if(strSelectedModels.length)
        {
            strSelectedModels = [NSString stringWithFormat:@"%@,%@",strSelectedModels,[dict objectForKey:@"Description"]];
        }
        else
        {
            strSelectedModels = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]];
        }
        
    }
    [arrAssaysSelected removeAllObjects];
    [arrAssaysSelected addObjectsFromArray:arrCellSelected];
    
    if(!strSelectedModels.length)
    {
        [ModelsBtnOutlet setTitle:@"SELECT ASSAYS/MODELS" forState:UIControlStateNormal];
    }
    else
    {
        ModelsBtnOutlet.titleLabel.numberOfLines = 2;
        [ModelsBtnOutlet setTitle:strSelectedModels forState:UIControlStateNormal];
    }
    [self removeSelectionPopUp];
}

@end
