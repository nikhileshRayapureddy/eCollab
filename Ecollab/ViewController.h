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

@interface ViewController : UIViewController<UIScrollViewDelegate>
@property (strong, nonatomic) NSArray *pageImages;

@property (weak, nonatomic) IBOutlet UIScrollView *scrlVwImages;

@end

