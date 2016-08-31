//
//  FAQVCViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAQTableViewCell.h"
#import "BaseViewController.h"

@interface FAQVCViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *FAQTableview;
- (IBAction)btnBackClicked:(UIButton *)sender;

@end
