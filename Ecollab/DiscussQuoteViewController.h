//
//  DiscussQuoteViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 15/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscussQuoteViewController : BaseViewController<ServiceRequesterProtocol>

@property (strong, nonatomic) NSMutableDictionary *DataDict;

@property (strong, nonatomic) IBOutlet UIImageView *StatusImgOne;
@property (strong, nonatomic) IBOutlet UILabel *labelOne;
@property (strong, nonatomic) IBOutlet UILabel *labelTwo;
@property (strong, nonatomic) IBOutlet UIImageView *StatusImgTwo;
@property (strong, nonatomic) IBOutlet UILabel *labelThree;
@property (strong, nonatomic) IBOutlet UILabel *LabelFour;
@property (strong, nonatomic) IBOutlet UIImageView *StatusImgThree;
@property (strong, nonatomic) IBOutlet UILabel *LabelFive;
@property (strong, nonatomic) IBOutlet UILabel *LabelSix;
@property (strong, nonatomic) IBOutlet UILabel *labelSeven;
@property (strong, nonatomic) IBOutlet UIImageView *StatusImgFour;
@property (strong, nonatomic) IBOutlet UILabel *LabelEight;
@property (strong, nonatomic) IBOutlet UIButton *DiscussBtnOutlet;
@property (strong, nonatomic) NSString *placeOrder;
@property (assign, nonatomic) BOOL isRjectOrRegretted;
@property (strong, nonatomic) NSString *strRequestRID;
- (IBAction)DiscussBtnAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewService;
@property (weak, nonatomic) IBOutlet UIView *viewArea;
@property (weak, nonatomic) IBOutlet UIView *viewSubArea;
@property (weak, nonatomic) IBOutlet UIView *viewAssays;

@end
