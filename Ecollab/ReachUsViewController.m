//
//  ReachUsViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "ReachUsViewController.h"

@interface ReachUsViewController ()
{
    float CustomerRating;
    NSString *messageString;

}

@end

@implementation ReachUsViewController
@synthesize rateView,CommentTf;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    self.rateView.notSelectedImage = [UIImage imageNamed:@"kermit_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"star_favorite.png"];
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
}
//method for rating functionality
- (void)rateView:(RateView *)rateView ratingDidChange:(int)rating {
    //self.statusLabel.text = [NSString stringWithFormat:@"Rating: %d", rating];
    CustomerRating = rating;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)requestReceivedopSaveUserRatingsResponce:(NSMutableDictionary *)aregistrationDict{
    // show alert controller and navigate user to login view controller
    [self.navigationController popViewControllerAnimated:YES];

}
- (IBAction)CommentAndRateBtnActio:(id)sender{
    NSMutableDictionary *inputDick =[NSMutableDictionary dictionaryWithObjectsAndKeys:@"1",@"UID",[NSString stringWithFormat:@"%d",(int)floor(CustomerRating)],@"Rating",CommentTf.text,@"RatingComments", nil];
    
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopSaveUserRatingsService:inputDick];
    request =  nil;
 
}

@end
