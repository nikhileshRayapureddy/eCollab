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
    
    
    for (int i=0;i<_pageImages.count;i++)
    {
        UIImageView *imgVw = [[UIImageView alloc]initWithFrame:CGRectMake(self.scrlVwImages.frame.size.width * i, 0, self.scrlVwImages.frame.size.width, self.scrlVwImages.frame.size.height)];
        imgVw.backgroundColor = [UIColor clearColor];
        imgVw.image = [UIImage imageNamed:[_pageImages objectAtIndex:i]];
        [self.scrlVwImages addSubview:imgVw];
        
    }
    self.scrlVwImages.contentSize = CGSizeMake(_pageImages.count * self.scrlVwImages.frame.size.width, self.scrlVwImages.frame.size.height);
    
    // Create page view controller
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"scrollView.contentOffset.x : %f",scrollView.contentOffset.x);
    if (scrollView.contentOffset.x >= self.scrlVwImages.frame.size.width * 2)
    {
        LogInViewController *loginController=[self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        [self.navigationController pushViewController:loginController animated:YES];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
