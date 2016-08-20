//
//  StatusViewModeViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 15/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceRequester.h"
@interface StatusViewModeViewController : UIViewController<ServiceRequesterProtocol>
@property (strong, nonatomic) NSMutableDictionary *inputDataDictionary;
@property (strong, nonatomic) NSMutableString *PlaceOrder;

@property (strong, nonatomic) IBOutlet UIScrollView *StatusScrollView;
@property (strong, nonatomic) IBOutlet UIImageView *StatuImgOne;
@property (strong, nonatomic) IBOutlet UILabel *LabelOne;
@property (strong, nonatomic) IBOutlet UIImageView *StatusImgTwo;
@property (strong, nonatomic) IBOutlet UILabel *labelTwo;
@property (strong, nonatomic) IBOutlet UIImageView *StatuImgThree;
@property (strong, nonatomic) IBOutlet UILabel *LabelTrhee;
@property (strong, nonatomic) IBOutlet UILabel *LableThreeTwo;
@property (strong, nonatomic) IBOutlet UIImageView *StatusImgFour;
@property (strong, nonatomic) IBOutlet UILabel *LabelFour;
@property (strong, nonatomic) IBOutlet UILabel *LabelFourTwo;
@property (strong, nonatomic) IBOutlet UIImageView *StatusImgFive;
@property (strong, nonatomic) IBOutlet UILabel *LabelFive;
@property (strong, nonatomic) IBOutlet UILabel *LabelFiveTwo;
@property (strong, nonatomic) IBOutlet UIImageView *StatusImgsix;
@property (strong, nonatomic) IBOutlet UILabel *LabelSix;
@property (strong, nonatomic) IBOutlet UILabel *Labelseven;

@property (strong, nonatomic) IBOutlet UIImageView *StausImgEight;
@property (strong, nonatomic) IBOutlet UILabel *LabelEight;
@property (strong, nonatomic) IBOutlet UIImageView *StatusImgnine;
@property (strong, nonatomic) IBOutlet UILabel *Labelnine;
@property (strong, nonatomic) IBOutlet UILabel *labelNineTwo;
@property (strong, nonatomic) IBOutlet UIImageView *statusImgTen;
@property (strong, nonatomic) IBOutlet UILabel *LabelTen;

@property (strong, nonatomic) IBOutlet UILabel *LabelEleven;
@property (strong, nonatomic) IBOutlet UIButton *PlaceOrderBtnOutlet;
- (IBAction)PlaceOrderBtnAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *RejectQuoteBtnOutlet;
- (IBAction)RejectQuoteBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewRemarksValue;

@property (weak, nonatomic) IBOutlet UIView *viewCommentsValue;
@property (weak, nonatomic) IBOutlet UILabel *lblQuantityValue;

@property (strong, nonatomic) NSString *strRequestRID;
@end
