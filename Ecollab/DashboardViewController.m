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
    int menuFlag;
    NSMutableArray *menuArray,*menuImagesArray;
}
@end

@implementation DashboardViewController
@synthesize menuTable,vwSideMenu,userData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *arr  = [userData objectForKey:@"Login"];
    NSDictionary *dic = [arr objectAtIndex:0];
    
    _lblUserName.text = [dic objectForKey:@"Name"];
    _lblEmailID.text = [dic objectForKey:@"EmailID"];
    
    
    NSMutableString *base64String = [NSMutableString stringWithFormat:@"%@",[dic objectForKey:@"Image"]];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    _imgProfile.image = [UIImage imageWithData:data];
    _imgProfileBg.image = [UIImage imageWithData:data];


    [self designNavBar];
    vwSideMenu.hidden = YES;
    menuTable.tableFooterView = [self tableViewFooterView];
    menuFlag = 0;
    
    UIImage *leftBarbtnImage = [UIImage imageNamed:@"menu.png"];   CGRect frameimg2 = CGRectMake(0,0, 30,25);
    UIButton *lefttBarBtn = [[UIButton alloc] initWithFrame:frameimg2];
    [lefttBarBtn setBackgroundImage:leftBarbtnImage forState:UIControlStateNormal];
    [lefttBarBtn addTarget:self action:@selector(Dashboard)
          forControlEvents:UIControlEventTouchUpInside];
    [lefttBarBtn setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *leftBarBtnItem =[[UIBarButtonItem alloc] initWithCustomView:lefttBarBtn];
    self.navigationItem.leftBarButtonItem =leftBarBtnItem;
    
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
    
    menuArray =[NSMutableArray arrayWithObjects:@"HOME",@"REQUEST A QUOTE ",@"SAVED REQUESTS",@"REQUEST/PROJECT TRACKER",@"MY PROFILE",@"LEGAL DISCLAIMER",@"REACH US",@"ALERTS",@"HELP",@"SHARE", nil];
    menuImagesArray = [[NSMutableArray alloc] initWithObjects:@"requestquotes.png",@"requestquotes.png",@"savedrequests.png",@"projecttracer.png",@"myprofile.png",@"slidelegal.png",@"newreach.png",@"notifications.png",@"helps.png",@"share.png", nil];
}
-(void)designNavBar
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:237.0/255.0 green:27.0/255.0 blue:36.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    
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

-(void)Dashboard{
    if (menuFlag == 0) {
        vwSideMenu.hidden = NO;
        menuTable.delegate = self;
        menuTable.dataSource = self;
        [menuTable reloadData];
        menuFlag = 1;
    }else{
        vwSideMenu.hidden = YES;
        menuFlag = 0;
    }

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return menuArray.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        static NSString *CellIdentifier = @"MenuLableTableViewCellID";
        
        MenuLableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[MenuLableTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.MenuImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[menuImagesArray objectAtIndex:indexPath.row]]];
        cell.DisplayLabel.text = [NSString stringWithFormat:@"%@",[menuArray objectAtIndex:indexPath.row]];
        return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSInteger i= indexPath.row;
        switch (i) {
            case 0:
            {
               //Home
                menuTable.hidden = YES;
                menuFlag = 0;
            }
                break;
            case 1:
            {
                [self RequestAQuoteBtnAction:nil];
            }
                break;
            case 2:
            {
                [self SavedRequestsBtnAction:nil];
            }
                break;
            case 3:
            {
                [self RequesterOrProjectTrackerBtnAction:nil];
            }
                break;
            case 4:
            {
                [self MyProfileBtnAction:nil];
            }
                break;
                
            case 5:
            {
                DisclaimerViewController *DVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"DisclaimerViewController"];
                [self.navigationController pushViewController:DVCtrlObj animated:YES];
            }
            break;
            case 6:
            {
                [self ReachUsBtnAction:nil];
            }
                break;
            case 7:
            {
                [self AlertsBtnAction:nil];
            }
                break;
            case 8:
            {
                FAQVCViewController *FAQVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"FAQVCViewController"];
                [self.navigationController pushViewController:FAQVCtrlObj animated:YES];
            }
            default:
            {
                // do sharing functionality
            }
                break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 44;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RequestAQuoteBtnAction:(id)sender {
    
    
    RequestAQuoteViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestAQuoteViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)RequesterOrProjectTrackerBtnAction:(id)sender {
   
[[[DetailsManager sharedManager]view_token]setString:@"RequesterOrProjectTracker"];
  [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarMainViewController"] animated:YES];
}

- (IBAction)SavedRequestsBtnAction:(id)sender {
    
    [[[DetailsManager sharedManager]view_token]setString:@"SavedRequests"];
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarMainViewController"] animated:YES];
}

- (IBAction)MyProfileBtnAction:(id)sender {
    
    [[[DetailsManager sharedManager]view_token]setString:@"MyProfile"];
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarMainViewController"] animated:YES];
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

- (IBAction)btnSideMenuBgClicked:(UIButton *)sender {
    vwSideMenu.hidden = YES;
    menuFlag = 0;

}

-(UIView*)tableViewFooterView
{
    UIView *vw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, menuTable.frame.size.width, 44)];
    vw.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnSignOut = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSignOut.backgroundColor = [UIColor clearColor];
    [btnSignOut setBackgroundImage:[UIImage imageNamed:@"btnRedGradient.png"] forState:UIControlStateNormal];
    [btnSignOut setTitle:@"SIGN OUT" forState:UIControlStateNormal];
    [btnSignOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSignOut.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    btnSignOut.frame = CGRectMake(0, 0, 80, 30);
    btnSignOut.center = CGPointMake((menuTable.frame.size.width - 80)/2, vw.center.y);
    [btnSignOut addTarget:self action:@selector(btnSignOutClicked:) forControlEvents:UIControlEventTouchUpInside];
    [vw addSubview:btnSignOut];
    return vw;
}
-(void)btnSignOutClicked:(UIButton *)sender
{
    [self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:1] animated:YES];
}
@end
