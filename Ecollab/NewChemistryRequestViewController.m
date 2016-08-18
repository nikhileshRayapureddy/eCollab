//
//  NewChemistryRequestViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 18/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "NewChemistryRequestViewController.h"
#import "CompundDBCustomView.h"
@interface NewChemistryRequestViewController (){
    UIDatePicker *myPicker;
    UITableView *purityTableView, *imageTabelview;
    NSString *b64EncStr;
    NSString *date;
    NSString *QuantityID,*Purity,*PurityID;
    NSArray *purityArray,*CategoryMasterArray;
    NSMutableArray * collectionImageDataArray;
    NSData *ImageData;
    NSMutableString *base64StringForReq;
    NSMutableString *ProductType,*ProductID;
    CompundDBCustomView *vwCompundDBCustomView;
    NSInteger selCell;
    
}

@end

@implementation NewChemistryRequestViewController
@synthesize BackgrounScrollview,TakeOrChoosePhotoBtnOutlet,NewOrEditChemistryReqHeaderLabel,GetAProposalLabel,ChoseFromReferenceCompounDBBtnOutlet,CASTextField,MDLTextField,JournalReferenceTextField,ExpectedDeleveryDateBtnOutlet,ExpectedDeleveryDateImageview,QuantityTextField,MGBtnOutlet,GBtnOutlet,KGBtnOutlet,PuritybtnOutlet,CharitybtnOutlet,RemarksTextField,SubmitBtnOutlet,SaveForLaterBtnOutlet;
@synthesize OtherViewsDataDictionary;
- (void)viewDidLoad {
    [super viewDidLoad];
    selCell = -1;
    [BackgrounScrollview setDelegate:self];

    [self.vwCasTxtFldBg.layer setBorderWidth: 1.0];
    [self.vwCasTxtFldBg.layer setBorderColor:[[UIColor redColor] CGColor]];

    [self.vwMdlTxtFldBg.layer setBorderWidth: 1.0];
    [self.vwMdlTxtFldBg.layer setBorderColor:[[UIColor redColor] CGColor]];

    [self.vwJournalTxtFldBg.layer setBorderWidth: 1.0];
    [self.vwJournalTxtFldBg.layer setBorderColor:[[UIColor redColor] CGColor]];
    
    [self.vwExpDelDate.layer setBorderWidth: 1.0];
    [self.vwExpDelDate.layer setBorderColor:[[UIColor redColor] CGColor]];
    
    [self.vwQtyBg.layer setBorderWidth: 1.0];
    [self.vwQtyBg.layer setBorderColor:[[UIColor redColor] CGColor]];
    
    [self.vwChiralityTxtFldBg.layer setBorderWidth: 1.0];
    [self.vwChiralityTxtFldBg.layer setBorderColor:[[UIColor redColor] CGColor]];
    
    [self.vwRemarksTxtFldBg.layer setBorderWidth: 1.0];
    [self.vwRemarksTxtFldBg.layer setBorderColor:[[UIColor redColor] CGColor]];
    
    [self.PuritybtnOutlet.layer setBorderWidth: 1.0];
    [self.PuritybtnOutlet.layer setBorderColor:[[UIColor redColor] CGColor]];


    [self.imgVwTakeOrChoose setImage:[UIImage imageNamed:@"chemistryserveimg.png"]];
    [self.imgVwReferenceComp setImage:[UIImage imageNamed:@"chelocalimg.png"]];
    
    //purityArray = [[NSArray alloc] initWithObjects:@">=99",@">=98",@">=95",@">=90",@">=85",@">=80",nil];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    [BackgrounScrollview addGestureRecognizer:tapScroll];
    [BackgrounScrollview setShowsVerticalScrollIndicator:NO];
    
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopLoadMasterService];
    request =  nil;
    ProductType = [NSMutableString stringWithFormat:@"0"];
    ProductID = [NSMutableString stringWithFormat:@"0"];
    
    QuantityID= @"1";

}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.BackgrounScrollview setContentSize:CGSizeMake(BackgrounScrollview.contentSize.width, 950)];
}
- (void) tapped
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)WeightBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;

    self.MGBtnOutlet.selected = false;
    self.GBtnOutlet.selected = false;
    self.KGBtnOutlet.selected = false;
    button.selected = true;
    if (button.tag == 10) {
        //mg
        QuantityID= @"1";
    }else if (button.tag == 20){
        //g
       QuantityID= @"2";

    }else{
        //kg
        QuantityID= @"3";
    }
}

- (IBAction)ExpectedDeleveryDateBtnAction:(id)sender {
    [[self.view viewWithTag:123] removeFromSuperview];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnDone.tag = 478;
    btnDone.backgroundColor = [UIColor whiteColor];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    btnDone.frame = CGRectMake(self.view.frame.size.width - 50, self.view.frame.size.height - 230, 50, 30);
    [btnDone addTarget:self action:@selector(btnPickerDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDone];
    
    myPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 200,self.view.frame.size.width, 200.0f)];
    [myPicker addTarget:self action:@selector(pickerChanged:) forControlEvents:UIControlEventValueChanged];
    [myPicker setBackgroundColor:[UIColor whiteColor]];
    [myPicker setTag:123456];
    [self.view addSubview:myPicker];
}
-(void)btnPickerDoneClicked:(UIButton*)sender
{
    [sender removeFromSuperview];
    [[self.view viewWithTag:123456] removeFromSuperview];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    date = [dateFormat stringFromDate:[myPicker date]];
    [[self.view viewWithTag:123456] removeFromSuperview];
    [ExpectedDeleveryDateBtnOutlet setTitle:date forState:UIControlStateNormal];

}
- (void)pickerChanged:(id)sender
{
    UIButton *btn= [self.view viewWithTag:478];
    [btn removeFromSuperview];
    
    [[self.view viewWithTag:123456] removeFromSuperview];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    date = [dateFormat stringFromDate:[sender date]];
    [[self.view viewWithTag:123456] removeFromSuperview];
    [ExpectedDeleveryDateBtnOutlet setTitle:date forState:UIControlStateNormal];
}
- (IBAction)ChoseFromReferenceCompounDBBtnAction:(id)sender {

    [self showCompoundDBCustomView];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopLoadMasterService];
    request =  nil;
}
-(void)requestReceivedopLoadMasterResponce:(NSMutableDictionary *)aregistrationDict{
    NSLog(@"%@",aregistrationDict);
    NSLog(@"%@",[aregistrationDict objectForKey:@"SuccessCode"]);
    
    if([[aregistrationDict objectForKey:@"SuccessCode"] intValue]== 200)
    {
        purityArray =  [aregistrationDict objectForKey:@"PurityMaster"];
        CategoryMasterArray = [aregistrationDict objectForKey:@"CategoryMaster"];
        [self ImagesDisplay:@"0"];
        
        [self performSelectorOnMainThread:@selector(bindCompundDBData) withObject:nil waitUntilDone:true];
    }else{
        //show some alert

    }
}
-(void)ImagesDisplay:(NSString *)indexString{
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopImagesOnTherapiticAreaService:[NSString stringWithFormat:@"%d",[indexString intValue]+1]];
    request =  nil;
}
-(void)requestReceivedopImagesOnTherapiticAreaResponce:(NSMutableDictionary *)aregistrationDict{
    
    collectionImageDataArray =[aregistrationDict objectForKey:@"ImageTherapiticAreaResult"];
    [vwCompundDBCustomView.clVwCompoundDb reloadData];

}

#pragma mark -
#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section
{
    return collectionImageDataArray.count;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 5.0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCellID" forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ImageCollectionViewCell" owner:self options:nil]firstObject];
    }
    NSMutableDictionary *tempDic = [collectionImageDataArray objectAtIndex:indexPath.row];
    NSMutableString *base64String = [NSMutableString stringWithFormat:@"%@",[tempDic objectForKey:@"Base64Image"]];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    cell.CollectionImageView.image = [UIImage imageWithData:data];
    if (selCell == indexPath.row)
    {
        cell.layer.borderWidth = 1.0;
        cell.layer.borderColor = [UIColor redColor].CGColor;
    }
    else
    {
        cell.layer.borderWidth = 1.0;
        cell.layer.borderColor = [UIColor lightGrayColor].CGColor;

    }
    return cell;
}
#pragma mark -
#pragma mark UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageData = nil;
    selCell = indexPath.row;
    [collectionView reloadData];
}
- (IBAction)TakeOrChoosePhotoBtnAction:(id)sender {
    
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Photo"
                                                                       message:@"Please select photo"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* PhotoFromGalleryAction = [UIAlertAction actionWithTitle:@"Photo From Gallery" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                                                  picker.delegate = self;
                                                                  picker.allowsEditing = YES;
                                                                  picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                                                                  
                                                                  [self presentViewController:picker animated:YES completion:NULL];

                                                                  
                                                              }];
    UIAlertAction* TakeAPhotoAction = [UIAlertAction actionWithTitle:@"Take A Photo" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                              
                                                              if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                                                                  
                                                                  UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                                        message:@"Device has no camera"
                                                                                                                       delegate:nil
                                                                                                              cancelButtonTitle:@"OK"
                                                                                                              otherButtonTitles: nil];
                                                                  
                                                                  [myAlertView show];
                                                                  
                                                              } else {
                                                                  
                                                                  UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                                                  picker.delegate = self;
                                                                  picker.allowsEditing = YES;
                                                                  picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                                  
                                                                  [self presentViewController:picker animated:YES completion:NULL];
                                                                  
                                                              }

                                                              
                                                          }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel
                                                                   handler:^(UIAlertAction * action) {
                                                                   }];

    
        [alert addAction:PhotoFromGalleryAction];
        [alert addAction:TakeAPhotoAction];
        [alert addAction:cancel];
       [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    b64EncStr = nil;
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //self.imageView.image = chosenImage;
    
    [self.imgVwTakeOrChoose setImage:chosenImage];
    _imgVwReferenceComp.image = [UIImage imageNamed:@"chelocalimg.png"];

    NSData *imgData=UIImagePNGRepresentation(chosenImage);
    if ([imgData length]>2000) {
        CGSize newSize = CGSizeMake(100.0f, 100.0f);
        
        UIGraphicsBeginImageContext(newSize);
        [chosenImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        b64EncStr = [self encodeToBase64String:newImage];
    }
    else{
        b64EncStr = [self encodeToBase64String:chosenImage];
    }
    ProductType =[NSMutableString stringWithFormat:@"1"];
    ProductID = [NSMutableString stringWithFormat:@"0"];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    TakeOrChoosePhotoBtnOutlet.selected= YES;
    ChoseFromReferenceCompounDBBtnOutlet.selected= NO;

    
}
//for image encode and decode

- (NSString *)encodeToBase64String:(UIImage *)image {
    
    
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)PuritybtnAction:(id)sender {
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btnDone.tag = 479;
    btnDone.backgroundColor = [UIColor whiteColor];
    [btnDone setTitle:@"Done" forState:UIControlStateNormal];
    btnDone.frame = CGRectMake(self.view.frame.size.width - 50, self.view.frame.size.height - 230, 50, 30);
    [btnDone addTarget:self action:@selector(btnPurityDoneClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDone];
    
    purityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height - 200,self.view.frame.size.width,200) style:UITableViewStylePlain] ;
    purityTableView.dataSource = self;
    purityTableView.delegate = self;
    [purityTableView setTag:123];
    
    [self.view addSubview:purityTableView];
}
-(void)btnPurityDoneClicked:(UIButton*)sender
{
    [sender removeFromSuperview];   
    [[self.view viewWithTag:123] removeFromSuperview];

}


- (void)IMGSubmitAction:(id)sender {
    
    NSMutableDictionary *tempDic = [collectionImageDataArray objectAtIndex:selCell];
    base64StringForReq = [NSMutableString stringWithFormat:@"%@",[tempDic objectForKey:@"Base64Image"]];
    ImageData = [[NSData alloc]initWithBase64EncodedString:base64StringForReq options:NSDataBase64DecodingIgnoreUnknownCharacters];
    [self.imgVwReferenceComp setImage:[UIImage imageWithData:ImageData]];
    b64EncStr = nil;
    ProductID = [tempDic objectForKey:@"RID"];//RID

    b64EncStr = base64StringForReq;
    ProductType =[NSMutableString stringWithFormat:@"2"];
    [vwCompundDBCustomView removeFromSuperview];
    ChoseFromReferenceCompounDBBtnOutlet.selected = YES;
    TakeOrChoosePhotoBtnOutlet.selected = NO;
    _imgVwTakeOrChoose.image = [UIImage imageNamed:@"chemistryserveimg.png"];


}

- (void)IMGCancelAction:(id)sender {
    [vwCompundDBCustomView removeFromSuperview];
}

- (void)ButtonTableSubviewAction:(id)sender {
    imageTabelview = [[UITableView alloc] initWithFrame:CGRectMake(vwCompundDBCustomView.btnSelectType.frame.origin.x, vwCompundDBCustomView.btnSelectType.frame.origin.y + vwCompundDBCustomView.btnSelectType.frame.size.height,vwCompundDBCustomView.btnSelectType.frame.size.width ,312) style:UITableViewStylePlain] ;
    imageTabelview.dataSource = self;
    imageTabelview.delegate = self;
    [vwCompundDBCustomView addSubview:imageTabelview];
}


- (IBAction)SaveForLaterBtnAction:(id)sender {
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setValue:[[DetailsManager sharedManager]rID] forKey:@"UID"];
    [dict setValue:ProductType forKey:@"ProductType"];
    if ([ProductType isEqualToString:@"1"])
    {
        [dict setValue:b64EncStr forKey:@"Image"];
    }
    else
    {
        [dict setValue:@"" forKey:@"Image"];
    }
    [dict setValue:ProductID forKey:@"ProductID"];
    [dict setValue:JournalReferenceTextField.text forKey:@"jonuralref"];
    [dict setValue:[NSString stringWithFormat:@"%@",date] forKey:@"ExpDeliveryDate"];
    [dict setValue:QuantityTextField.text forKey:@"Quantity"];
    [dict setValue:QuantityID forKey:@"QuantityID"];
    [dict setValue:Purity forKey:@"Purity"];
    [dict setValue:PurityID forKey:@"PurityID"];
    [dict setValue:[NSString stringWithFormat:@"%@",CharitybtnOutlet.text] forKey:@"Chirality"];
    [dict setValue:[NSString stringWithFormat:@"%@",RemarksTextField.text] forKey:@"Comments"];
    [dict setValue:@"0" forKey:@"ISSubmit"];
    [dict setValue:@"1" forKey:@"Status"];
    [dict setValue:CASTextField.text forKey:@"CAS"];
    [dict setValue:MDLTextField.text forKey:@"MDL"];
    
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopCreateChemistryRequestService:dict];
    request =  nil;
}

- (IBAction)SubmitBtnAction:(id)sender {
    
    NSDictionary *inputDick = [NSDictionary dictionaryWithObjectsAndKeys:[[DetailsManager sharedManager]rID],@"UID",ProductID,@"ProductID",ProductType,@"ProductType",[NSString stringWithFormat:@"%@",JournalReferenceTextField.text],@"jonuralref",[NSString stringWithFormat:@"%@",date],@"ExpDeliveryDate",[NSString stringWithFormat:@"%@",QuantityTextField.text],@"Quantity",QuantityID,@"QuantityID",Purity,@"Purity",PurityID,@"PurityID",[NSString stringWithFormat:@"%@",CharitybtnOutlet.text],@"Chirality",[NSString stringWithFormat:@"%@",RemarksTextField.text],@"Comments",@"1",@"ISSubmit", @"1",@"Status",b64EncStr,@"Image",nil];
    
    // producttype camera 1 product id 0 (image base 64)
    // producttype data 2   product id (image id from db )
    // producttype defult 0 product id 0
    // PurityID PurityMaster(load mastar) = rid in table data
    //ISSubmit 1 submit 0 for save for later
    // status always 1

    //NSDictionary *inputDick = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"UID",@"12",@"ProductID",@"1",@"ProductType",@"1236",@"jonuralref",@"12/22/2015",@"ExpDeliveryDate",@"10",@"Quantity",@"1",@"QuantityID",@"0",@"Purity",@"1",@"PurityID",@"1",@"Chirality",@"1",@"Comments",@"1",@"ISSubmit", @"1",@"Status",@"",@"Image",nil];
//    if ([CASTextField.text isEqualToString:@""]||[MDLTextField.text isEqualToString:@""]||[date isEqualToString:@""]||[QuantityTextField.text isEqualToString:@""]||[Purity isEqualToString:@""]||[CharitybtnOutlet.text isEqualToString:@""]) {
//        //show alert  some mesage
//    }else{
        ServiceRequester *request = [ServiceRequester new];
        request.serviceRequesterDelegate =  self;
        [request requestForopCreateChemistryRequestService:inputDick];
        request =  nil;
//    }
}
-(void)requestReceivedopCreateChemistryRequestResponce:(NSMutableDictionary *)aregistrationDict{
    // show alert controller and navigare back
    
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                   message:@"Chemistery request saved successfully."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* PhotoFromGalleryAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                                   handler:^(UIAlertAction * action) {
                                                                       [self.navigationController popViewControllerAnimated:YES];

                                                                   }];
    
    
    [alert addAction:PhotoFromGalleryAction];
    [self presentViewController:alert animated:YES completion:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == purityTableView ) {
        return purityArray.count;
    }else{
        return CategoryMasterArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    

        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
            
        }
        if (tableView == purityTableView ) {
            // Configure the cell...
            //Purity
            NSDictionary *dic =[purityArray objectAtIndex:indexPath.row];
            Purity = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Purity"]];
            cell.textLabel.text = Purity;
        }else{
            // Configure the cell...
            cell.textLabel.text =[NSString stringWithFormat:@"%@",[[CategoryMasterArray objectAtIndex:indexPath.row] objectForKey:@"Category"]];
        }
        return cell;
 
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == purityTableView ) {
        UIButton *btnDone = [self.view viewWithTag:479];
        [btnDone removeFromSuperview];

        NSDictionary *dic =[purityArray objectAtIndex:indexPath.row];
        Purity = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Purity"]];
        //RID
        PurityID =[NSString stringWithFormat:@"%@",[dic objectForKey:@"RID"]];
        [PuritybtnOutlet setTitle:Purity forState:UIControlStateNormal];
    [PuritybtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[self.view viewWithTag:123] removeFromSuperview];
    }else{
        
        [vwCompundDBCustomView.btnSelectType setTitle:[NSString stringWithFormat:@"%@",[[CategoryMasterArray objectAtIndex:indexPath.row] objectForKey:@"Category"]] forState:UIControlStateNormal];
        [vwCompundDBCustomView.btnSelectType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [imageTabelview setHidden:YES];
        [self ImagesDisplay:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];

    }

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void)showCompoundDBCustomView
{
    
    vwCompundDBCustomView = [[CompundDBCustomView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    vwCompundDBCustomView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [vwCompundDBCustomView.btnSubmit addTarget:self action:@selector(IMGSubmitAction:) forControlEvents:UIControlEventTouchUpInside];
    [vwCompundDBCustomView.btnCancel addTarget:self action:@selector(IMGCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:vwCompundDBCustomView];

}
-(void)bindCompundDBData
{
    [vwCompundDBCustomView.clVwCompoundDb setDelegate:self];
    [vwCompundDBCustomView.clVwCompoundDb setDataSource:self];
    UINib *myNib1 = [UINib nibWithNibName:@"ImageCollectionViewCell" bundle:[NSBundle mainBundle]];
    [vwCompundDBCustomView.clVwCompoundDb registerNib:myNib1 forCellWithReuseIdentifier:@"ImageCollectionViewCellID"];
    
    [imageTabelview reloadData];
    NSDictionary *dic =[purityArray objectAtIndex:0];
    Purity = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Purity"]];
    PurityID =[NSString stringWithFormat:@"%@",[dic objectForKey:@"RID"]];
    [PuritybtnOutlet setTitle:Purity forState:UIControlStateNormal];
    [PuritybtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    [vwCompundDBCustomView.btnSelectType setTitle:[NSString stringWithFormat:@"%@",[[CategoryMasterArray objectAtIndex:0] objectForKey:@"Category"]] forState:UIControlStateNormal];

}

-(BOOL)validateFields
{
    
    return YES;
}
@end
