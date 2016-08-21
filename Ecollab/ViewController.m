//
//  ViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 10/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    _pageImages = @[@"b1.JPG", @"b2.jpg", @"b3.jpg"];
    
    scrlVwImages = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    scrlVwImages.backgroundColor = [UIColor clearColor];
    scrlVwImages.pagingEnabled = YES;
    scrlVwImages.delegate = self;
    [self.view addSubview:scrlVwImages];
    for (int i=0;i<_pageImages.count;i++)
    {
        UIImageView *imgVw = [[UIImageView alloc]initWithFrame:CGRectMake(scrlVwImages.frame.size.width * i, 0, scrlVwImages.frame.size.width, scrlVwImages.frame.size.height)];
        imgVw.backgroundColor = [UIColor clearColor];
        imgVw.image = [UIImage imageNamed:[_pageImages objectAtIndex:i]];
        [scrlVwImages addSubview:imgVw];
        
    }
    scrlVwImages.contentSize = CGSizeMake(_pageImages.count * scrlVwImages.frame.size.width, scrlVwImages.frame.size.height);
    
    // Create page view controller
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    NSString *str = [[NSUserDefaults standardUserDefaults]objectForKey:@"SHOULDPUSHTOLOGIN"];
    if([str isEqualToString:@"1"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"SHOULDPUSHTOLOGIN"];
        [self pushToLoginScreen];
    }
    

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollView.contentOffset.x : %f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x >= scrlVwImages.frame.size.width * 2)
    {
        LogInViewController *loginController=[self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        [self.navigationController pushViewController:loginController animated:YES];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushToLoginScreen
{
    LogInViewController *loginController=[self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
    [self.navigationController pushViewController:loginController animated:YES];
    
}

@end
