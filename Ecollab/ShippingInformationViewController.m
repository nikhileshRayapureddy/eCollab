//
//  ShippingInformationViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "ShippingInformationViewController.h"

@interface ShippingInformationViewController ()

@end

@implementation ShippingInformationViewController
@synthesize ShippingInformationTableview,AddNewAddressOutlet;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    [ShippingInformationTableview setDelegate:self];
    [ShippingInformationTableview setDataSource:self];
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
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ShippingInformationTableViewCell";
    
    ShippingInformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ShippingInformationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set the data for this cell:
    
    //    cell.textLabel.text = [dataArray objectAtIndex:indexPath.row];
    //    cell.detailTextLabel.text = @"More text";
    //    cell.imageView.image = [UIImage imageNamed:@"flower.png"];
    
    // set the accessory view:
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    int selectedRow = indexPath.row;
    NSLog(@"touch on row %d", selectedRow);
}


- (IBAction)AddNewAddressBtnAction:(id)sender {
    AddNewShippingAddressViewController *CPVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNewShippingAddressViewController"];
    [self.navigationController pushViewController:CPVCtrlObj animated:YES];
}
@end
