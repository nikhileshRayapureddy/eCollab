//
//  AboutUsViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface AboutUsViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITextView *DisplayText;
- (IBAction)btnBackClicked:(UIButton *)sender;

@end
