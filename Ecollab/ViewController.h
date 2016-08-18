//
//  ViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 10/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"
#import "LogInViewController.h"

@interface ViewController : UIViewController<UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;


@end

