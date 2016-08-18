//
//  NewBiologyRequestViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 18/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceRequester.h"
#import "DetailsManager.h"
@interface NewBiologyRequestViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,ServiceRequesterProtocol>
@property (strong, nonatomic) IBOutlet UIButton *ServiceBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *AreaOutlet;
@property (strong, nonatomic) IBOutlet UIButton *SubAreaBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *ModelsBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *SubmitBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *SaveForLaterBtnOutlet;
@property (strong, nonatomic) NSMutableDictionary *OtherViewsDataDictionary;

- (IBAction)ServiceBtnAction:(id)sender;
- (IBAction)AreaBtnAction:(id)sender;
- (IBAction)SubAreaBtnAction:(id)sender;
- (IBAction)ModelsBtnAction:(id)sender;
- (IBAction)SubmitBtnAction:(id)sender;
- (IBAction)SaveForLaterBtnAction:(id)sender;





@end
