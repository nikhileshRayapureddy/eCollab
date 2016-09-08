//
//  SideMenuCustomView.h
//  Ecollab
//
//  Created by NIKHILESH on 21/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuCustomView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnSideMenuBg;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfileBg;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmailID;
@property (weak, nonatomic) IBOutlet UIView *vwBlurr;
@property (strong, nonatomic) IBOutlet UITableView *menuTable;
@end
