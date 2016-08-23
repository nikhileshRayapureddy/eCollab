//
//  BaseViewController.m
//  Ecollab
//
//  Created by NIKHILESH on 21/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "BaseViewController.h"
#import "RequestAQuoteViewController.h"
#import "SavedRequestsViewController.h"
#import "RequestOrProjectTrackerViewController.h"
#import "MyProfileViewController.h"
#import "DashboardViewController.h"
#import "DisclaimerViewController.h"
#import "ReachUsViewController.h"
#import "AlertsViewController.h"
#import "FAQVCViewController.h"
#import "LogInViewController.h"
#import "ShareViewController.h"
#define TAG_BOTTOM_BAR 1800

@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize vwSideMenuCustomView,userData,menuArray,menuImagesArray,menuFlag;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    menuArray =[NSMutableArray arrayWithObjects:@"HOME",@"REQUEST A QUOTE ",@"SAVED REQUESTS",@"REQUEST/PROJECT TRACKER",@"MY PROFILE",@"LEGAL DISCLAIMER",@"REACH US",@"ALERTS",@"HELP",@"SHARE", nil];
    menuImagesArray = [[NSMutableArray alloc] initWithObjects:@"requestquotes.png",@"requestquotes.png",@"savedrequests.png",@"projecttracer.png",@"myprofile.png",@"slidelegal.png",@"newreach.png",@"notifications.png",@"helps.png",@"share.png", nil];
    self.menuFlag = 0;

}
-(void)designNavBar
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:237.0/255.0 green:27.0/255.0 blue:36.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.hidesBackButton = YES;
    UIImage *leftBarbtnImage = [UIImage imageNamed:@"menu.png"];   CGRect frameimg2 = CGRectMake(0,0, 60,25);
    UIButton *lefttBarBtn = [[UIButton alloc] initWithFrame:frameimg2];
    lefttBarBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [lefttBarBtn setImage:leftBarbtnImage forState:UIControlStateNormal];
    [lefttBarBtn addTarget:self action:@selector(btnMenuClicked:)
          forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBarBtnItem =[[UIBarButtonItem alloc] initWithCustomView:lefttBarBtn];
    self.navigationItem.leftBarButtonItem =leftBarBtnItem;

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

-(void)btnMenuClicked:(UIButton*)sender{
    if (self.menuFlag == 0) {
        [self initialiseSideMenu];
        self.menuFlag = 1;
    }else{
        [self btnSideMenuBgClicked:nil];
        self.menuFlag = 0;
    }
    
}

-(void)designTabBar
{
    UIView *vwBase = (UIView*)[self.view viewWithTag:1875];
    if (!vwBase)
    {
        vwBase = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 114, self.view.frame.size.width, 50)];
        vwBase.backgroundColor = [UIColor whiteColor];
        vwBase.tag = 1875;
        [self.view addSubview:vwBase];
        CGFloat x= 0.0;
        
        CGFloat width = (self.view.frame.size.width  ) / 4.0;
        for (int i=0;i<4;i++)
        {
            
            UIButton *btnTab = [UIButton buttonWithType:UIButtonTypeCustom];
            
            
            [btnTab addTarget:self action:@selector(btnTabClicked:) forControlEvents:UIControlEventTouchUpInside];
            switch(i)
            {
                case 0 :
                    btnTab.frame = CGRectMake(x, 0,width-1, vwBase.frame.size.height);
                    [btnTab setImage:[UIImage imageNamed:@"Request_a_Quote_black.jpg"] forState:UIControlStateNormal];
                    [btnTab setImage:[UIImage imageNamed:@"RequestaQuote_red.jpg"] forState:UIControlStateSelected];
                    break;
                case 1 :
                    btnTab.frame = CGRectMake(x, 0,width-1, vwBase.frame.size.height);
                    [btnTab setImage:[UIImage imageNamed:@"SavedRequests_black.jpg"] forState:UIControlStateNormal];
                    [btnTab setImage:[UIImage imageNamed:@"SavedRequests_red.jpg"] forState:UIControlStateSelected];
                    break;
                case 2 :
                    btnTab.frame = CGRectMake(x, 0,width-1, vwBase.frame.size.height);
                    [btnTab setImage:[UIImage imageNamed:@"RequestProjectTracker_black.jpg"] forState:UIControlStateNormal];
                    [btnTab setImage:[UIImage imageNamed:@"RequestProjectTracker_red.jpg"] forState:UIControlStateSelected];
                   break;
                case 3 :
                    btnTab.frame = CGRectMake(x, 0,width, vwBase.frame.size.height);
                    [btnTab setImage:[UIImage imageNamed:@"MyProfile_black.jpg"] forState:UIControlStateNormal];
                    [btnTab setImage:[UIImage imageNamed:@"MyProfile_red.jpg"] forState:UIControlStateSelected];
                    break;
                default :
                    break;
            }
            btnTab.tag = TAG_BOTTOM_BAR+i;
            [vwBase addSubview:btnTab];
            x += width;
        }
    }
}
-(void)btnTabClicked:(UIButton*)sender
{
    if (sender.tag == TAG_BOTTOM_BAR)
    {
        
        RequestAQuoteViewController *vcRequestAQuoteViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestAQuoteViewController"];
        

        if ([self.navigationController.visibleViewController isKindOfClass:[RequestAQuoteViewController class]])
        {
            return;
        }
        else
        {
            for (UIViewController *vc in self.navigationController.viewControllers)
            {
                if ([vc isKindOfClass:[RequestAQuoteViewController class]])
                {
                    [self.navigationController popToViewController:vc animated:NO];
                    return;
                }
            }
        }
        [self.navigationController pushViewController:vcRequestAQuoteViewController animated:NO];
    }
    else if (sender.tag == TAG_BOTTOM_BAR + 1)
    {
        
        SavedRequestsViewController *vcSavedRequestsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SavedRequestsViewController"];
        
        
        if ([self.navigationController.visibleViewController isKindOfClass:[SavedRequestsViewController class]])
        {
            return;
        }
        else
        {
            for (UIViewController *vc in self.navigationController.viewControllers)
            {
                if ([vc isKindOfClass:[SavedRequestsViewController class]])
                {
                    [self.navigationController popToViewController:vc animated:NO];
                    return;
                }
            }
        }
        [self.navigationController pushViewController:vcSavedRequestsViewController animated:NO];
    }
    else if (sender.tag == TAG_BOTTOM_BAR + 2)
    {
        
        RequestOrProjectTrackerViewController *vcRequestOrProjectTrackerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestOrProjectTrackerViewController"];
        
        
        if ([self.navigationController.visibleViewController isKindOfClass:[RequestOrProjectTrackerViewController class]])
        {
            return;
        }
        else
        {
            for (UIViewController *vc in self.navigationController.viewControllers)
            {
                if ([vc isKindOfClass:[RequestOrProjectTrackerViewController class]])
                {
                    [self.navigationController popToViewController:vc animated:NO];
                    return;
                }
            }
        }
        [self.navigationController pushViewController:vcRequestOrProjectTrackerViewController animated:NO];
    }
    else if (sender.tag == TAG_BOTTOM_BAR + 3)
    {
        
        MyProfileViewController *vcMyProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
        
        
        if ([self.navigationController.visibleViewController isKindOfClass:[MyProfileViewController class]])
        {
            return;
        }
        else
        {
            for (UIViewController *vc in self.navigationController.viewControllers)
            {
                if ([vc isKindOfClass:[MyProfileViewController class]])
                {
                    [self.navigationController popToViewController:vc animated:NO];
                    return;
                }
            }
        }
        [self.navigationController pushViewController:vcMyProfileViewController animated:NO];
    }
    
}

-(void)setSelected:(int)Vc
{
    UIView *vwBase = (UIView*)[self.view viewWithTag:1875];
    UIButton *btn1=(UIButton*)[vwBase viewWithTag:TAG_BOTTOM_BAR];
    UIButton *btn2=(UIButton*)[vwBase viewWithTag:TAG_BOTTOM_BAR+1];
    UIButton *btn3=(UIButton*)[vwBase viewWithTag:TAG_BOTTOM_BAR+2];
    UIButton *btn4=(UIButton*)[vwBase viewWithTag:TAG_BOTTOM_BAR+3];
    
    if(Vc == 0)
    {
        [self setTabbarImages:btn1];
    }
    else if(Vc == 1)
    {
        [self setTabbarImages:btn2];
    }
    else if(Vc == 2)
    {
        [self setTabbarImages:btn3];
    }
    else if(Vc == 3)
    {
        [self setTabbarImages:btn4];
    }
}
-(void)setTabbarImages:(UIButton*)sender
{
    UIView *vwBase = (UIView*)[self.view viewWithTag:1875];
    
    for (int i=0; i<4; i++)
    {
        UIButton *btn = (UIButton*)[vwBase viewWithTag:TAG_BOTTOM_BAR+i];
        btn.selected = NO;
        
    }
    sender.selected = YES;
}
-(void)initialiseSideMenu
{
    vwSideMenuCustomView = [[SideMenuCustomView alloc]initWithFrame:CGRectMake(-self.view.frame.size.width, 64, self.view.frame.size.width, self.view.frame.size.height)];
    userData = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserData"];
    NSArray *arr  = [userData objectForKey:@"Login"];
    NSDictionary *dic = [arr objectAtIndex:0];
    
    vwSideMenuCustomView.imgProfile.layer.borderColor = [UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1.0].CGColor;
    vwSideMenuCustomView.imgProfile.layer.borderWidth = 4.0;
    vwSideMenuCustomView.lblUserName.text = [dic objectForKey:@"Name"];
    vwSideMenuCustomView.lblEmailID.text = [dic objectForKey:@"EmailID"];
    vwSideMenuCustomView.menuTable.delegate = self;
    vwSideMenuCustomView.menuTable.dataSource = self;
    vwSideMenuCustomView.menuTable.tableFooterView = [self tableViewFooterView];
    
    NSMutableString *base64String = [NSMutableString stringWithFormat:@"%@",[dic objectForKey:@"Image"]];
    NSData *data = [[NSData alloc]initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    if (base64String && [base64String isEqualToString:@""])
    {
        vwSideMenuCustomView.imgProfile.image = [UIImage imageNamed:@"default_profile1.png"];
        vwSideMenuCustomView.imgProfileBg.image = [UIImage imageNamed:@""];
    }
    else
    {
        vwSideMenuCustomView.imgProfile.image = [UIImage imageWithData:data];
        vwSideMenuCustomView.imgProfileBg.image = [UIImage imageWithData:data];
    }
    vwSideMenuCustomView.backgroundColor = [UIColor clearColor];
    [vwSideMenuCustomView.btnSideMenuBg addTarget:self action:@selector(btnSideMenuBgClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view.window addSubview:vwSideMenuCustomView];
    [vwSideMenuCustomView.menuTable reloadData];
    [UIView animateWithDuration:0.3 animations:^{
        vwSideMenuCustomView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }];
    [self performSelectorInBackground:@selector(getAlertCount) withObject:nil];
}

-(void)getAlertCount
{
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestFopUserAlertsOrNotificationsServiceForSideMenu];
    request =  nil;
}

-(void)requestReceivedopUserAlertsOrNotificationsForSideMenuResponce:(NSMutableDictionary *)aregistrationDict
{
    NSArray *alerts = [aregistrationDict objectForKey:@"NotificationsOrAlertsResult"];
    alertsCount = alerts.count;
    [vwSideMenuCustomView.menuTable reloadData];
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
        [tableView registerNib:[UINib nibWithNibName:@"MenuLableTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    cell.MenuImg.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[menuImagesArray objectAtIndex:indexPath.row]]];
    cell.DisplayLabel.text = [NSString stringWithFormat:@"%@",[menuArray objectAtIndex:indexPath.row]];
    
    if (indexPath.row == 7)
    {
        cell.lblCount.hidden = NO;
        cell.lblCount.text = [NSString stringWithFormat:@"%li",(long)alertsCount];
    }
    else{
        cell.lblCount.hidden = YES;
        cell.lblCount.text = @"";
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger i= indexPath.row;
    vwSideMenuCustomView.hidden = YES;
    menuFlag = 0;
    
    switch (i) {
        case 0:
        {
            DashboardViewController *vcDashboardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
            
            
            if ([self.navigationController.visibleViewController isKindOfClass:[DashboardViewController class]])
            {
                return;
            }
            else
            {
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[DashboardViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:NO];
                        return;
                    }
                }
            }
            [self.navigationController pushViewController:vcDashboardViewController animated:NO];
        }
            break;
        case 1:
        {
            RequestAQuoteViewController *vcRequestAQuoteViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestAQuoteViewController"];
            
            
            if ([self.navigationController.visibleViewController isKindOfClass:[RequestAQuoteViewController class]])
            {
                return;
            }
            else
            {
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[RequestAQuoteViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:NO];
                        return;
                    }
                }
            }
            [self.navigationController pushViewController:vcRequestAQuoteViewController animated:NO];
        }
            break;
        case 2:
        {
            SavedRequestsViewController *vcSavedRequestsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SavedRequestsViewController"];
            
            
            if ([self.navigationController.visibleViewController isKindOfClass:[SavedRequestsViewController class]])
            {
                return;
            }
            else
            {
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[SavedRequestsViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:NO];
                        return;
                    }
                }
            }
            [self.navigationController pushViewController:vcSavedRequestsViewController animated:NO];
        }
            break;
        case 3:
        {
            RequestOrProjectTrackerViewController *vcRequestOrProjectTrackerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RequestOrProjectTrackerViewController"];
            
            
            if ([self.navigationController.visibleViewController isKindOfClass:[RequestOrProjectTrackerViewController class]])
            {
                return;
            }
            else
            {
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[RequestOrProjectTrackerViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:NO];
                        return;
                    }
                }
            }
            [self.navigationController pushViewController:vcRequestOrProjectTrackerViewController animated:NO];
        }
            break;
        case 4:
        {
            MyProfileViewController *vcMyProfileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
            
            
            if ([self.navigationController.visibleViewController isKindOfClass:[MyProfileViewController class]])
            {
                return;
            }
            else
            {
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[MyProfileViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:NO];
                        return;
                    }
                }
            }
            [self.navigationController pushViewController:vcMyProfileViewController animated:NO];
        }
            break;
            
        case 5:
        {
            DisclaimerViewController *vcDisclaimerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DisclaimerViewController"];
            
            
            if ([self.navigationController.visibleViewController isKindOfClass:[DisclaimerViewController class]])
            {
                return;
            }
            else
            {
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[DisclaimerViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:NO];
                        return;
                    }
                }
            }
            [self.navigationController pushViewController:vcDisclaimerViewController animated:NO];
        }
            break;
        case 6:
        {
            ReachUsViewController *vcReachUsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ReachUsViewController"];
            
            
            if ([self.navigationController.visibleViewController isKindOfClass:[ReachUsViewController class]])
            {
                return;
            }
            else
            {
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[ReachUsViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:NO];
                        return;
                    }
                }
            }
            [self.navigationController pushViewController:vcReachUsViewController animated:NO];
        }
            break;
        case 7:
        {
            AlertsViewController *vcAlertsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertsViewController"];
            
            
            if ([self.navigationController.visibleViewController isKindOfClass:[AlertsViewController class]])
            {
                return;
            }
            else
            {
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[AlertsViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:NO];
                        return;
                    }
                }
            }
            [self.navigationController pushViewController:vcAlertsViewController animated:NO];
        }
            break;
        case 8:
        {
            FAQVCViewController *vcFAQVCViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FAQVCViewController"];
            
            
            if ([self.navigationController.visibleViewController isKindOfClass:[FAQVCViewController class]])
            {
                return;
            }
            else
            {
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[FAQVCViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:NO];
                        return;
                    }
                }
            }
            [self.navigationController pushViewController:vcFAQVCViewController animated:NO];
        }
            break;
        case 9:
        {
            ShareViewController *vcShareViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ShareViewController"];
            
            
            if ([self.navigationController.visibleViewController isKindOfClass:[ShareViewController class]])
            {
                return;
            }
            else
            {
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[ShareViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:NO];
                        return;
                    }
                }
            }
            [self.navigationController pushViewController:vcShareViewController animated:NO];
        }
            break;
      default:
        {
            DashboardViewController *vcDashboardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
            
            
            if ([self.navigationController.visibleViewController isKindOfClass:[DashboardViewController class]])
            {
                return;
            }
            else
            {
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[DashboardViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:NO];
                        return;
                    }
                }
            }
            [self.navigationController pushViewController:vcDashboardViewController animated:NO];
        }
            break;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(void)btnSideMenuBgClicked:(UIButton*)sender
{
    self.menuFlag = 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        vwSideMenuCustomView.frame = CGRectMake(-self.view.frame.size.width, 64, self.view.frame.size.width, self.view.frame.size.height);
    } completion:^(BOOL finished) {
//        [vwSideMenuCustomView removeFromSuperview];
    }];
}
-(UIView*)tableViewFooterView
{
    UIView *vw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, vwSideMenuCustomView.menuTable.frame.size.width, 44)];
    vw.backgroundColor = [UIColor whiteColor];
    
    UIButton *btnSignOut = [UIButton buttonWithType:UIButtonTypeCustom];
    btnSignOut.backgroundColor = [UIColor clearColor];
    [btnSignOut setBackgroundImage:[UIImage imageNamed:@"btnRedGradient.png"] forState:UIControlStateNormal];
    [btnSignOut setTitle:@"SIGN OUT" forState:UIControlStateNormal];
    [btnSignOut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnSignOut.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    btnSignOut.frame = CGRectMake(0, 0, 80, 30);
    btnSignOut.center = CGPointMake((vwSideMenuCustomView.menuTable.frame.size.width - 80)/2, vw.center.y);
    [btnSignOut addTarget:self action:@selector(btnSignOutClicked:) forControlEvents:UIControlEventTouchUpInside];
    [vw addSubview:btnSignOut];
    return vw;
}
-(void)btnSignOutClicked:(UIButton *)sender
{
    vwSideMenuCustomView.hidden = YES;
    menuFlag = 0;
    [vwSideMenuCustomView removeFromSuperview];
    [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"ISLOGGEDIN"];
    BOOL isFound = NO;
    LogInViewController *loginVc;
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if([vc isKindOfClass:[LogInViewController class]])
        {
            isFound = YES;
            loginVc = (LogInViewController*)vc;
        }
    }
    
    if(isFound == YES)
    {
        [self.navigationController popToViewController:loginVc animated:YES];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"SHOULDPUSHTOLOGIN"];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
