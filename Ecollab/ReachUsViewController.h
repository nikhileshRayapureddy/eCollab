//
//  ReachUsViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RateView.h"
#import <QuartzCore/QuartzCore.h>
#import "ServiceRequester.h"
@interface ReachUsViewController : UIViewController<RateViewDelegate,ServiceRequesterProtocol>
@property (weak, nonatomic) IBOutlet RateView *rateView;

- (IBAction)CommentAndRateBtnActio:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *CommentTf;

@end
