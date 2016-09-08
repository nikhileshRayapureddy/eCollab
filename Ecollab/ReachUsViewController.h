//
//  ReachUsViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ServiceRequester.h"
#import "BaseViewController.h"
@interface ReachUsViewController : BaseViewController<ServiceRequesterProtocol>
@property (weak, nonatomic) IBOutlet UIView *rateView;

- (IBAction)CommentAndRateBtnActio:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *CommentTf;
@property (weak, nonatomic) IBOutlet UIView *vwCommentsBg;
- (IBAction)btnBackClicked:(UIButton *)sender;
- (IBAction)btnRatingSelected:(UIButton *)sender;

@end
