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
@synthesize menuTable,ratioView,userData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self designNavBar];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"homebg.png"]]];
    
    [menuTable setHidden:YES];
    self.menuTable.contentInset = UIEdgeInsetsMake(64,0,0,0);
    menuFlag = 0;
    [self.menuTable setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    
    UIImage *leftBarbtnImage = [UIImage imageNamed:@"menu.png"];   CGRect frameimg2 = CGRectMake(0,0, 30,25);
    UIButton *lefttBarBtn = [[UIButton alloc] initWithFrame:frameimg2];
    [lefttBarBtn setBackgroundImage:leftBarbtnImage forState:UIControlStateNormal];
    [lefttBarBtn addTarget:self action:@selector(Dashboard)
          forControlEvents:UIControlEventTouchUpInside];
    [lefttBarBtn setShowsTouchWhenHighlighted:YES];
    UIBarButtonItem *leftBarBtnItem =[[UIBarButtonItem alloc] initWithCustomView:lefttBarBtn];
    self.navigationItem.leftBarButtonItem =leftBarBtnItem;
    
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
        [menuTable setHidden:NO];
        menuTable.delegate = self;
        menuTable.dataSource = self;
        [menuTable setHidden:NO];
        [menuTable reloadData];

        menuFlag = 1;
    }else{
        [menuTable setHidden:YES];
        menuFlag = 0;
    }

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    UITouch *touch = [touches anyObject];
    if(touch.view!=menuTable){
        menuTable.hidden = YES;
        menuFlag = 0;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }else if(section == 1){
        return menuArray.count;
    }else{
        return 1;
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        static NSString *CellIdentifier = @"MenuProfileTableViewCellID";
        
        MenuProfileTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[MenuProfileTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        NSArray *arr  = [userData objectForKey:@"Login"];
        NSDictionary *dic = [arr objectAtIndex:0];
        
        cell.NameLabel.text = [dic objectForKey:@"Name"];
        cell.EmailId.text = [dic objectForKey:@"EmailID"];
        
         
         NSMutableString *base64String = [NSMutableString stringWithFormat:@"%@",[dic objectForKey:@"Image"]];
         NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
         
         cell.ProfileImage.image = [UIImage imageWithData:data];

        
        return cell;
    }else if (indexPath.section == 1){
        static NSString *CellIdentifier = @"MenuLableTableViewCellID";
        
        MenuLableTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[MenuLableTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.MenuImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[menuImagesArray objectAtIndex:indexPath.row]]];
        cell.DisplayLabel.text = [NSString stringWithFormat:@"%@",[menuArray objectAtIndex:indexPath.row]];
        return cell;
    }else{
        static NSString *CellIdentifier = @"SignOutTableViewCellID";
        
        SignOutTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[SignOutTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        //cell.SignOutImageView.image
        return cell;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        //
    }else if (indexPath.section == 2) {
        [self.navigationController popToViewController:[[self.navigationController viewControllers]objectAtIndex:1] animated:YES];
    }else if (indexPath.section == 1)
    {
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
//        [userProfileMenuTable setHidden:YES];
//        userFlag=0;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    }else{
        return 41;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)RequestAQuoteBtnAction:(id)sender {
    
    
    RequestAQuoteViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestAQuoteViewController"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (IBAction)RequesterOrProjectTrackerBtnAction:(id)sender {
   
    // tabbar testing purpose
    
    //TabBarMainViewController
    //TabBarMainViewController * tab =[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarMainViewController"];
    // or
//    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarMainViewController"] animated:YES];
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

//-(void)NavigationForTabBarViewController {
//    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"TabBarMainViewController"] animated:YES];
//}
@end
