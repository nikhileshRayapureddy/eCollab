//
//  TabBarMainViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "TabBarMainViewController.h"

@interface TabBarMainViewController ()

@end

@implementation TabBarMainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // use this code for which tab you wat to show
    NSLog(@"%@",[[DetailsManager sharedManager]view_token]);
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    if ([[[DetailsManager sharedManager]view_token] isEqualToString:@"MyProfile"]) {
        [self setSelectedViewController:(UIViewController *)[self.viewControllers objectAtIndex: 3]];
    }else if ([[[DetailsManager sharedManager]view_token] isEqualToString:@"RequesterOrProjectTracker"]) {
        [self setSelectedViewController:(UIViewController *)[self.viewControllers objectAtIndex: 2]];
    }else if ([[[DetailsManager sharedManager]view_token] isEqualToString:@"SavedRequests"]) {
        [self setSelectedViewController:(UIViewController *)[self.viewControllers objectAtIndex: 1]];
    }else{
        //RequestAQuote

    }
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor redColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
