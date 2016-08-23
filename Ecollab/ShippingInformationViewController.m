//
//  ShippingInformationViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "ShippingInformationViewController.h"

@interface ShippingInformationViewController ()
{
    NSMutableArray *arrAddresses;
}
@end

@implementation ShippingInformationViewController
@synthesize ShippingInformationTableview,AddNewAddressOutlet;
@synthesize isFromTracking;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrAddresses = [[NSMutableArray alloc]init];
    
    [self designNavBar];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopGetShippingAddressDetailsService];
    request =  nil;

}
-(void)designNavBar
{
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:237.0/255.0 green:27.0/255.0 blue:36.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *imgLogoEcoLab = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    imgLogoEcoLab.backgroundColor = [UIColor clearColor];
    imgLogoEcoLab.image = [UIImage imageNamed:@"ecolablogo.png"];
    imgLogoEcoLab.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = imgLogoEcoLab;
    
    UIImageView *imgLogoGVK = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    imgLogoGVK.backgroundColor = [UIColor clearColor];
    imgLogoGVK.image = [UIImage imageNamed:@"gvk_whitelogo1.png"];
    imgLogoGVK.contentMode = UIViewContentModeScaleAspectFit;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:imgLogoGVK];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
}

-(void)requestReceivedopGetUserAddressListRequestResponce:(NSMutableDictionary *)aregistrationDict
{
    [arrAddresses removeAllObjects];
    arrAddresses = [aregistrationDict valueForKey:@"UserAddressDetailsResult"];
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    [ShippingInformationTableview reloadData];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return arrAddresses.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ShippingInformationTableViewCell";
    
    ShippingInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShippingInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dictAddress = [arrAddresses objectAtIndex:indexPath.row];
    // Set the data for this cell:
    
        cell.NameLabel.text = [dictAddress valueForKey:@"Name"];
        cell.AddressLabel.text = [dictAddress valueForKey:@"Address"];
        cell.AddressTwoLabel.text = [NSString stringWithFormat:@"%@ %@",[dictAddress valueForKey:@"City"],[dictAddress valueForKey:@"State"]];
        cell.PinCodeLabel.text = [NSString stringWithFormat:@"%@ %@ %@",[dictAddress valueForKey:@"Pincode"],[dictAddress valueForKey:@"Country"],[dictAddress valueForKey:@"MobileNumber"]];
    cell.EditAddressBtnOutlet.tag = 100+indexPath.row;
    [cell.EditAddressBtnOutlet addTarget:self action:@selector(btnEditClicked:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)handleLongPress:(UILongPressGestureRecognizer *)longPress
{
    
    if(longPress.state == UIGestureRecognizerStateBegan)
    {
        CGPoint p = [longPress locationInView:ShippingInformationTableview];
        
        NSIndexPath *indexPath = [ShippingInformationTableview indexPathForRowAtPoint:p];
        if (indexPath == nil) {
            NSLog(@"long press on table view but not on a row");
        } else {
            
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"eCollab"
                                                                           message:@"Do you want to delete?"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
                NSMutableDictionary *dictRequest = [[NSMutableDictionary alloc]init];
                NSMutableDictionary *dict =[arrAddresses objectAtIndex:indexPath.row];
                
                
                [dictRequest setObject:[dict objectForKey:@"RID"] forKey:@"ADDRESSID"];
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
            [request requestForopGetShippingAddressDetailsService];
            request =  nil;
            
        }];
        [alert addAction:okAction];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
    
}

-(void)cellTapped:(UITapGestureRecognizer*)tap
{
    // Your code here
    CGPoint p = [tap locationInView:ShippingInformationTableview];
    NSIndexPath *indexPath = [ShippingInformationTableview indexPathForRowAtPoint:p];
    if (indexPath == nil) {
        NSLog(@"long press on table view but not on a row");
    } else {
        if(isFromTracking == YES)
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"eCollab"
                                                                           message:@"Do you want to add this address as your defaut address?"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSDictionary *dict = [arrAddresses objectAtIndex:indexPath.row];
                [self updateShippingAddress:dict];
                
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            
            
            [alert addAction:okAction];
            [alert addAction:cancelAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(isFromTracking == YES)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"eCollab"
                                                                       message:@"Do you want to add this address as your defaut address?"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSDictionary *dict = [arrAddresses objectAtIndex:indexPath.row];
            [self updateShippingAddress:dict];
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        
        [alert addAction:okAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    

}

-(void)updateShippingAddress:(NSDictionary *)dictAddress
{
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
        // here check you input validation
        NSMutableDictionary *inputDick =[NSMutableDictionary dictionaryWithObjectsAndKeys:[[DetailsManager sharedManager]rID],@"UID",[dictAddress valueForKey:@"Address"],@"Address",[dictAddress valueForKey:@"Address1"],@"Address1",[dictAddress valueForKey:@"City"],@"City",[dictAddress valueForKey:@"Country"],@"Country",[dictAddress valueForKey:@"State"],@"State",[dictAddress valueForKey:@"Pincode"],@"PinCode",@"1",@"ISDefault",[dictAddress valueForKey:@"LandMark"],@"LandMark",[dictAddress valueForKey:@"Name"],@"Name",[dictAddress valueForKey:@"MobileNumber"],@"MobileNumber",[dictAddress valueForKey:@"RID"],@"RID", nil];
        
        ServiceRequester *request = [ServiceRequester new];
        request.serviceRequesterDelegate =  self;
        [request requestForopUpdateShippingAddressDetailsService:inputDick];
        request =  nil;
}

-(void)requestReceivedopUpdateShippingAddressDetailsResponce:(NSMutableDictionary *)aregistrationDict;
{
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnEditClicked:(UIButton*)sender
{
    AddNewShippingAddressViewController *CPVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewShippingAddressViewController"];
    CPVCtrlObj.isEdit = YES;
    CPVCtrlObj.dictAddress = [arrAddresses objectAtIndex:sender.tag - 100];
    [self.navigationController pushViewController:CPVCtrlObj animated:YES];

}
- (IBAction)AddNewAddressBtnAction:(id)sender {
    AddNewShippingAddressViewController *CPVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewShippingAddressViewController"];
    CPVCtrlObj.isEdit = false;
    [self.navigationController pushViewController:CPVCtrlObj animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
