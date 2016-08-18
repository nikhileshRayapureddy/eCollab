//
//  EditPersonalDetailsViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceRequester.h"
@interface EditPersonalDetailsViewController : UIViewController<ServiceRequesterProtocol>
@property (strong, nonatomic) IBOutlet UITextField *DesignationTF;
@property (strong, nonatomic) NSMutableDictionary *userDataDict;
@property (strong, nonatomic) IBOutlet UITextField *FirstNameTF;
@property (strong, nonatomic) IBOutlet UITextField *LastNameTF;
@property (strong, nonatomic) IBOutlet UITextField *EmailTF;
@property (strong, nonatomic) IBOutlet UITextField *CompanyNameTF;
@property (strong, nonatomic) IBOutlet UIButton *SaveBtnOutlet;
- (IBAction)SavebtnAction:(id)sender;

@end
