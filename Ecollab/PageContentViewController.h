//
//  PageContentViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 10/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *imageFile;
@end
