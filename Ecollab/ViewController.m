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

    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor whiteColor];
    
    // Create the data model
    
    _pageTitles = @[@"Share new Ideas from anywhere or search our Reference database", @"Order and Track real time status of projects on-the-Go", @"Accelerate Drug Discovery with Integrated Chemistry and biology solutions",@""];
    _pageImages = @[@"b1.JPG", @"b2.jpg", @"b3.jpg", @""];
    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    PageContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    //self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 30);
    self.pageViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    NSLog(@"at present %lu  Index %lu",(unsigned long)[self.pageTitles count],(unsigned long)index);
    
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    if (index == 3 ){
        [_pageViewController willMoveToParentViewController:nil];
        [_pageViewController.view removeFromSuperview];
        [_pageViewController removeFromParentViewController];
        
        //[self.navigationController setNavigationBarHidden:NO animated:YES];
        
        
        LogInViewController *loginController=[self.storyboard instantiateViewControllerWithIdentifier:@"LogInViewController"];
        [self.navigationController pushViewController:loginController animated:YES];
        return nil;
    }else{
        // Create a new view controller and pass suitable data.
        PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
        pageContentViewController.imageFile = self.pageImages[index];
        //pageContentViewController.titleText = self.pageTitles[index];
        pageContentViewController.pageIndex = index;
        
        return pageContentViewController;
    }
    return nil;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    NSLog(@"before %lu  Index %lu",(unsigned long)[self.pageTitles count],(unsigned long)index);

    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{

    NSUInteger index = ((PageContentViewController*) viewController).pageIndex;
    
    NSLog(@"after %lu   Index %lu",(unsigned long)[self.pageTitles count],(unsigned long)index);

    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//- (void)viewWillAppear:(BOOL)animated{
//    
//}

//- (void)viewDidAppear:(BOOL)animated{
//    
//}
//
//- (void)viewWillDisappear:(BOOL)animated{
//    
//}
//
//- (void)viewDidDisappear:(BOOL)animated{
//    
//}
//
//- (void)viewDidUnload{
//    
//}


@end
