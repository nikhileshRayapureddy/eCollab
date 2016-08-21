//
//  ShareViewController.h
//  Ecollab
//
//  Created by NIKHILESH on 21/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface ShareViewController : BaseViewController
- (IBAction)btnTwitterClicked:(UIButton *)sender;
- (IBAction)btnFbClicked:(UIButton *)sender;
- (IBAction)btnLinkedInClicked:(UIButton *)sender;
- (IBAction)btnGooglPlusClicked:(UIButton *)sender;

@end
