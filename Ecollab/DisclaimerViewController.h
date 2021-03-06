//
//  DisclaimerViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@interface DisclaimerViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITextView *DiscTextview;

@property (strong, nonatomic) IBOutlet UIButton *PrivacyAndTermsBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *LegalDisclaimerBtnOutlet;
- (IBAction)PrivacyAndTermsBtnAction:(id)sender;
- (IBAction)LegalDisclaimerBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblTitile;

- (IBAction)btnBackClicked:(UIButton *)sender;
@end
