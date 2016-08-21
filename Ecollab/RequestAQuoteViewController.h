//
//  RequestAQuoteViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 13/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewBiologyRequestViewController.h"
#import "NewChemistryRequestViewController.h"
#import "FAQVCViewController.h"

@interface RequestAQuoteViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *ChemistryBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *BiologyBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *FAQOutlet;
- (IBAction)ChemistryBtnAction:(id)sender;
- (IBAction)BiologyBtnAction:(id)sender;
- (IBAction)FAQBtnAction:(id)sender;



@end
