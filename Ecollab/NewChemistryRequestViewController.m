//
//  NewChemistryRequestViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 18/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "NewChemistryRequestViewController.h"
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
}

@end

@implementation NewChemistryRequestViewController
@synthesize BackgrounScrollview,TakeOrChoosePhotoBtnOutlet,NewOrEditChemistryReqHeaderLabel,GetAProposalLabel,TakeOrChoosePhotoImageview,ChoseFromReferenceCompounDBBtnOutlet,ChoseFromReferenceCompounDBImageview,CASTextField,MDLTextField,JournalReferenceTextField,ExpectedDeleveryDateBtnOutlet,ExpectedDeleveryDateImageview,QuantityTextField,MGBtnOutlet,MGImageview,MGLabelOutlet,GBtnOutlet,GImageview,GLabelOutlet,KGBtnOutlet,KGImageview,KGLabelOutlet,PuritybtnOutlet,CharitybtnOutlet,RemarksTextField,SubmitBtnOutlet,SaveForLaterBtnOutlet;
@synthesize SubScrollview,ManagingSubview,managingInActiveView,Therapeutic,TherapeuticRedHeader,ButtonTableSubview,ZoomCloseButton,ZoomManagingView,ZoomImageContentView,mycollectionView;
@synthesize OtherViewsDataDictionary;
- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    [BackgrounScrollview setDelegate:self];
    
    //TakeOrChoosePhotoBtnOutlet
    [TakeOrChoosePhotoBtnOutlet.layer setBorderWidth: 1.0];
    [TakeOrChoosePhotoBtnOutlet.layer setCornerRadius:50.0f];
    [TakeOrChoosePhotoBtnOutlet.layer setMasksToBounds:YES];
    [TakeOrChoosePhotoBtnOutlet.layer setBorderColor:[[UIColor redColor] CGColor]];
    
    //ChoseFromReferenceCompounDBBtnOutlet
    [ChoseFromReferenceCompounDBBtnOutlet.layer setBorderWidth: 1.0];
    [ChoseFromReferenceCompounDBBtnOutlet.layer setCornerRadius:50.0f];
    [ChoseFromReferenceCompounDBBtnOutlet.layer setMasksToBounds:YES];
    [ChoseFromReferenceCompounDBBtnOutlet.layer setBorderColor:[[UIColor redColor] CGColor]];
    //TakeOrChoosePhotoImageview
    [TakeOrChoosePhotoImageview.layer setBorderWidth: 1.0];
    [TakeOrChoosePhotoImageview.layer setCornerRadius:10.0f];
    [TakeOrChoosePhotoImageview.layer setMasksToBounds:YES];
    [TakeOrChoosePhotoImageview.layer setBorderColor:[[UIColor redColor] CGColor]];
    
    //ChoseFromReferenceCompounDBImageview
    [ChoseFromReferenceCompounDBImageview.layer setBorderWidth: 1.0];
    [ChoseFromReferenceCompounDBImageview.layer setCornerRadius:10.0f];
    [ChoseFromReferenceCompounDBImageview.layer setMasksToBounds:YES];
    [ChoseFromReferenceCompounDBImageview.layer setBorderColor:[[UIColor redColor] CGColor]];

    [TakeOrChoosePhotoBtnOutlet setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"chemistryserveimg.png"]]];
    [ChoseFromReferenceCompounDBBtnOutlet setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"chelocalimg.png"]]];
    
    [ManagingSubview setHidden:YES];
    [managingInActiveView setHidden:YES];
    [TherapeuticRedHeader setHidden:YES];
    [Therapeutic setHidden:YES];
    [ZoomManagingView setHidden:YES];
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
}
- (void) tapped
{
    [self.view endEditing:YES];
}
// this is useful for moving navigationbar top
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGPoint scrollOffset = scrollView.contentOffset;
//    if (scrollOffset.y >= 40) {
//        if (![self.navigationController isNavigationBarHidden]) {
//            [self.navigationController setNavigationBarHidden:YES animated:YES];
//        }
//    } else {
//        if ([self.navigationController isNavigationBarHidden]) {
//            [self.navigationController setNavigationBarHidden:NO animated:YES];
//        }
//    }
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)WeightBtnAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    //radio_btn.png
    //radio-off.png
    NSInteger bTag = button.tag;
    if (bTag == 10) {
        MGImageview.image = [UIImage imageNamed:@"radio_btn.png"];
        GImageview.image = [UIImage imageNamed:@"radio-off.png"];
        KGImageview.image = [UIImage imageNamed:@"radio-off.png"];
        QuantityID= @"1";
        //mg
    }else if (bTag == 20){
        //g
        MGImageview.image = [UIImage imageNamed:@"radio-off.png"];
        GImageview.image = [UIImage imageNamed:@"radio_btn.png"];
        KGImageview.image = [UIImage imageNamed:@"radio-off.png"];
        QuantityID= @"2";

    }else{
        //kg
        MGImageview.image = [UIImage imageNamed:@"radio-off.png"];
        GImageview.image = [UIImage imageNamed:@"radio-off.png"];
        KGImageview.image = [UIImage imageNamed:@"radio_btn.png"];
        QuantityID= @"3";

    }
}

- (IBAction)ExpectedDeleveryDateBtnAction:(id)sender {
            [[self.view viewWithTag:123] removeFromSuperview];
    myPicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(ExpectedDeleveryDateBtnOutlet.frame.origin.x, ExpectedDeleveryDateBtnOutlet.frame.origin.y + ExpectedDeleveryDateBtnOutlet.frame.size.height,ExpectedDeleveryDateBtnOutlet.frame.size.width , 200.0f)];
    [myPicker addTarget:self action:@selector(pickerChanged:)               forControlEvents:UIControlEventValueChanged];
    [myPicker setBackgroundColor:[UIColor whiteColor]];
    [myPicker setTag:123456];
    [self.BackgrounScrollview addSubview:myPicker];
}
- (void)pickerChanged:(id)sender
{
    [[self.view viewWithTag:123456] removeFromSuperview];

    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd-yyyy"];
    date = [dateFormat stringFromDate:[sender date]];
    [[self.view viewWithTag:123456] removeFromSuperview];
    [ExpectedDeleveryDateBtnOutlet setTitle:date forState:UIControlStateNormal];
}
- (IBAction)ChoseFromReferenceCompounDBBtnAction:(id)sender {
    //radio_btn.png
    //radio-off.png
    TakeOrChoosePhotoImageview.image = [UIImage imageNamed:@"radio-off.png"];
    ChoseFromReferenceCompounDBImageview.image =  [UIImage imageNamed:@"radio_btn.png"];

    [managingInActiveView setHidden:NO];
    [ManagingSubview setHidden:NO];
    [TherapeuticRedHeader setHidden:NO];
    [Therapeutic setHidden:NO];
//        [managingInActiveView setHidden:YES];
//        [ManagingSubview setHidden:YES];

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
        [mycollectionView setBackgroundColor:[UIColor whiteColor]];
        [mycollectionView setDelegate:self];
        [mycollectionView setDataSource:self];
        
        [imageTabelview reloadData];
        [ButtonTableSubview setTitle:[NSString stringWithFormat:@"%@",[[CategoryMasterArray objectAtIndex:0] objectForKey:@"Category"]] forState:UIControlStateNormal];
        [self ImagesDisplay:@"0"];
    }else{
        //show some alert

    }
}
-(void)ImagesDisplay:(NSString *)indexString{
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopImagesOnTherapiticAreaService:[NSMutableString stringWithFormat:[NSString stringWithFormat:@"%d",[indexString intValue]+1]]];
    request =  nil;
}
-(void)requestReceivedopImagesOnTherapiticAreaResponce:(NSMutableDictionary *)aregistrationDict{
    
    collectionImageDataArray =[aregistrationDict objectForKey:@"ImageTherapiticAreaResult"];
    [mycollectionView reloadData];

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
    ImageCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCellID"
                                    forIndexPath:indexPath];
    
    //UIImage *image;
    long row = [indexPath row];
    
    
    NSMutableDictionary *tempDic = [collectionImageDataArray objectAtIndex:indexPath.row];
    NSMutableString *base64String = [NSMutableString stringWithFormat:@"%@",[tempDic objectForKey:@"Base64Image"]];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    myCell.CollectionImageView.image = [UIImage imageWithData:data];
    
    //myCell.CollectionImageView.image = image;
    
    return myCell;
}
#pragma mark -
#pragma mark UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageData = nil;
    [ZoomManagingView setHidden:NO];
    NSMutableDictionary *tempDic = [collectionImageDataArray objectAtIndex:indexPath.row];
    base64StringForReq = [NSMutableString stringWithFormat:@"%@",[tempDic objectForKey:@"Base64Image"]];
    ImageData = [[NSData alloc]initWithBase64EncodedString:base64StringForReq options:NSDataBase64DecodingIgnoreUnknownCharacters];
    ZoomImageContentView.image = [UIImage imageWithData:ImageData];
    [ChoseFromReferenceCompounDBBtnOutlet setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageWithData:ImageData]]];
    b64EncStr = nil;
    ProductID = [tempDic objectForKey:@"RID"];//RID
    ProductType = [NSMutableString stringWithFormat:@"2"];
    //[ZoomImageContentView setImage:[UIImage imageNamed:@"sampleprofile.jpeg"]];
}
- (IBAction)TakeOrChoosePhotoBtnAction:(id)sender {
    //radio_btn.png
    //radio-off.png
    TakeOrChoosePhotoImageview.image = [UIImage imageNamed:@"radio_btn.png"];
    ChoseFromReferenceCompounDBImageview.image =  [UIImage imageNamed:@"radio-off.png"];
    
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
    
        [alert addAction:PhotoFromGalleryAction];
        [alert addAction:TakeAPhotoAction];
        [self presentViewController:alert animated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    b64EncStr = nil;
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //self.imageView.image = chosenImage;
    
    [TakeOrChoosePhotoBtnOutlet setBackgroundColor:[UIColor colorWithPatternImage:chosenImage]];
    
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
    
}
//for image encode and decode

- (NSString *)encodeToBase64String:(UIImage *)image {
    
    
    return [UIImagePNGRepresentation(image) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)PuritybtnAction:(id)sender {
    purityTableView = [[UITableView alloc] initWithFrame:CGRectMake(PuritybtnOutlet.frame.origin.x, PuritybtnOutlet.frame.origin.y + PuritybtnOutlet.frame.size.height,PuritybtnOutlet.frame.size.width ,820.0f - PuritybtnOutlet.frame.origin.y + PuritybtnOutlet.frame.size.height) style:UITableViewStylePlain] ;
    purityTableView.dataSource = self;
    purityTableView.delegate = self;
    [purityTableView setTag:123];
    
    [self.BackgrounScrollview addSubview:purityTableView];
}


- (IBAction)ZoomCloseButtonAction:(id)sender {
    [ZoomManagingView setHidden:YES];
    

    
}

- (IBAction)IMGSubmitAction:(id)sender {
    [managingInActiveView setHidden:YES];
    [ManagingSubview setHidden:YES];
    [TherapeuticRedHeader setHidden:YES];
    [Therapeutic setHidden:YES];
    b64EncStr = base64StringForReq;
    ProductType =[NSMutableString stringWithFormat:@"2"];;


}

- (IBAction)IMGCancelAction:(id)sender {
    [managingInActiveView setHidden:YES];
    [ManagingSubview setHidden:YES];
    [TherapeuticRedHeader setHidden:YES];
    [Therapeutic setHidden:YES];
}

- (IBAction)ButtonTableSubviewAction:(id)sender {
    imageTabelview = [[UITableView alloc] initWithFrame:CGRectMake(ButtonTableSubview.frame.origin.x, ButtonTableSubview.frame.origin.y + ButtonTableSubview.frame.size.height,ButtonTableSubview.frame.size.width ,312) style:UITableViewStylePlain] ;
    imageTabelview.dataSource = self;
    imageTabelview.delegate = self;
    [ManagingSubview addSubview:imageTabelview];
}


- (IBAction)SaveForLaterBtnAction:(id)sender {
    NSDictionary *inputDick = [NSDictionary dictionaryWithObjectsAndKeys:[[DetailsManager sharedManager]rID],@"UID",ProductID,@"ProductID",ProductType,@"ProductType",[NSString stringWithFormat:@"%@",JournalReferenceTextField.text],@"jonuralref",[NSString stringWithFormat:@"%@",date],@"ExpDeliveryDate",[NSString stringWithFormat:@"%@",QuantityTextField.text],@"Quantity",QuantityID,@"QuantityID",Purity,@"Purity",PurityID,@"PurityID",[NSString stringWithFormat:@"%@",CharitybtnOutlet.text],@"Chirality",[NSString stringWithFormat:@"%@",RemarksTextField.text],@"Comments",@"0",@"ISSubmit", @"1",@"Status",b64EncStr,@"Image",nil];
    //NSDictionary *inputDick = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"UID",@"12",@"ProductID",@"1",@"ProductType",@"1236",@"jonuralref",@"12/22/2015",@"ExpDeliveryDate",@"10",@"Quantity",@"1",@"QuantityID",@"0",@"Purity",@"1",@"PurityID",@"1",@"Chirality",@"1",@"Comments",@"1",@"ISSubmit", @"1",@"Status",@"",@"Image",nil];
//        if ([CASTextField.text isEqualToString:@""]||[MDLTextField.text isEqualToString:@""]||[date isEqualToString:@""]||[QuantityTextField.text isEqualToString:@""]||[Purity isEqualToString:@""]||[CharitybtnOutlet.text isEqualToString:@""]) {
//            //show alert  some mesage
//        }else{
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopCreateChemistryRequestService:inputDick];
    request =  nil;
//        }

    
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
    [self.navigationController popViewControllerAnimated:YES];
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
        NSDictionary *dic =[purityArray objectAtIndex:indexPath.row];
        Purity = [NSString stringWithFormat:@"%@",[dic objectForKey:@"Purity"]];
        //RID
        PurityID =[NSString stringWithFormat:@"%@",[dic objectForKey:@"RID"]];
        [PuritybtnOutlet setTitle:Purity forState:UIControlStateNormal];
    [PuritybtnOutlet setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [[self.view viewWithTag:123] removeFromSuperview];
    }else{
        
        [ButtonTableSubview setTitle:[NSString stringWithFormat:@"%@",[[CategoryMasterArray objectAtIndex:indexPath.row] objectForKey:@"Category"]] forState:UIControlStateNormal];
        [ButtonTableSubview setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
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

- (void)viewWillAppear:(BOOL)animated
{
    /////
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [self.view endEditing:YES];
}
// Called when the view is dismissed, covered or otherwise hidden. Default does nothing
- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = -215.0f;  //set the -215.0f to your required value
        self.view.frame = f;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect f = self.view.frame;
        f.origin.y = 0.0f;
        self.view.frame = f;
    }];
}

@end
