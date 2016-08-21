//
//  BaseViewController.h
//  Ecollab
//
//  Created by NIKHILESH on 21/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideMenuCustomView.h"
@interface BaseViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)SideMenuCustomView *vwSideMenuCustomView;
@property (strong, nonatomic) NSMutableDictionary *userData;
@property (strong, nonatomic) NSMutableArray *menuArray,*menuImagesArray;
@property (assign, nonatomic) int menuFlag;
-(void)designNavBar;
-(void)designTabBar;
-(void)btnTabClicked:(UIButton*)sender;
-(void)setSelected:(int)Vc;
-(void)btnSideMenuBgClicked:(UIButton*)sender;
-(void)initialiseSideMenu;
@end
