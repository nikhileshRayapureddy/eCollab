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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrAddresses = [[NSMutableArray alloc]init];
    
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopGetShippingAddressDetailsService];
    request =  nil;

}
-(void)requestReceivedopGetUserAddressListRequestResponce:(NSMutableDictionary *)aregistrationDict
{
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
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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
