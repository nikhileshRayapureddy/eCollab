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
#define TAG_BOTTOM_BAR 1800
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)designTabBar
{
    UIView *vwBase = (UIView*)[self.view viewWithTag:1875];
    if (!vwBase)
    {
        vwBase = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 114, self.view.frame.size.width, 50)];
        vwBase.backgroundColor = [UIColor blackColor];
        vwBase.tag = 1875;
        [self.view addSubview:vwBase];
        CGFloat x= 0.0;
        
        CGFloat width = (self.view.frame.size.width  ) / 4.0;
        
        for (int i=0;i<4;i++)
        {
            
            UIButton *btnTab = [UIButton buttonWithType:UIButtonTypeCustom];
            
            
            btnTab.frame = CGRectMake(x, 0,width, vwBase.frame.size.height);
            [btnTab addTarget:self action:@selector(btnTabClicked:) forControlEvents:UIControlEventTouchUpInside];
            switch(i)
            {
                case 0 :
                    [btnTab setImage:[UIImage imageNamed:@"Request_a_Quote_black.jpg"] forState:UIControlStateNormal];
                    [btnTab setImage:[UIImage imageNamed:@"RequestaQuote_red.jpg"] forState:UIControlStateSelected];
                    break;
                case 1 :
                    [btnTab setImage:[UIImage imageNamed:@"SavedRequests_black.jpg"] forState:UIControlStateNormal];
                    [btnTab setImage:[UIImage imageNamed:@"SavedRequests_red.jpg"] forState:UIControlStateSelected];
                    break;
                case 2 :
                    [btnTab setImage:[UIImage imageNamed:@"RequestProjectTracker_black.jpg"] forState:UIControlStateNormal];
                    [btnTab setImage:[UIImage imageNamed:@"RequestProjectTracker_red.jpg"] forState:UIControlStateSelected];
                   break;
                case 3 :
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
