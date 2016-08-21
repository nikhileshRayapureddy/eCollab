//
//  DashboardViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 11/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "DashboardViewController.h"

@interface DashboardViewController ()
{
}
@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self designNavBar];
    
    
    if ([[UIScreen mainScreen] bounds].size.width > 320)
    {
        [self.RequestAQuoteBtnOutlet setImage:[UIImage imageNamed:@"01.png"] forState:UIControlStateNormal];
        [self.RequesterOrProjectTrackerBtnOutlet setImage:[UIImage imageNamed:@"02.png"] forState:UIControlStateNormal];
        [self.SavedRequestsBtnOutlet setImage:[UIImage imageNamed:@"03.png"] forState:UIControlStateNormal];
        [self.MyProfileBtnOutlet setImage:[UIImage imageNamed:@"04.png"] forState:UIControlStateNormal];
        [self.ReachUsBtnOutlet setImage:[UIImage imageNamed:@"05.png"] forState:UIControlStateNormal];
        [self.AlertsBtnOutlet setImage:[UIImage imageNamed:@"06.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.RequestAQuoteBtnOutlet setImage:[UIImage imageNamed:@"01_1.png"] forState:UIControlStateNormal];
        [self.RequesterOrProjectTrackerBtnOutlet setImage:[UIImage imageNamed:@"02_1.png"] forState:UIControlStateNormal];
        [self.SavedRequestsBtnOutlet setImage:[UIImage imageNamed:@"03_1.png"] forState:UIControlStateNormal];
        [self.MyProfileBtnOutlet setImage:[UIImage imageNamed:@"04_1.png"] forState:UIControlStateNormal];
        [self.ReachUsBtnOutlet setImage:[UIImage imageNamed:@"05_1.png"] forState:UIControlStateNormal];
        [self.AlertsBtnOutlet setImage:[UIImage imageNamed:@"06_1.png"] forState:UIControlStateNormal];
    }
    
}


- (IBAction)RequestAQuoteBtnAction:(id)sender {
    
    
    RequestAQuoteViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestAQuoteViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)RequesterOrProjectTrackerBtnAction:(id)sender {
   
    RequestOrProjectTrackerViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestOrProjectTrackerViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)SavedRequestsBtnAction:(id)sender {
    
    SavedRequestsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SavedRequestsViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)MyProfileBtnAction:(id)sender {
    
    MyProfileViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)ReachUsBtnAction:(id)sender {
    ReachUsViewController *RUVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"ReachUsViewController"];
    [self.navigationController pushViewController:RUVCtrlObj animated:YES];
}

- (IBAction)AlertsBtnAction:(id)sender {
    AlertsViewController *AVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertsViewController"];
    [self.navigationController pushViewController:AVCtrlObj animated:YES];
    
}

- (IBAction)FAQBtnAction:(id)sender {
    FAQVCViewController *FAQVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"FAQVCViewController"];
    [self.navigationController pushViewController:FAQVCtrlObj animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
