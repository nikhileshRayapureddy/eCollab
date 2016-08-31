//
//  ReachUsViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "ReachUsViewController.h"
#import "DashboardViewController.h"
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
    self.rateView.notSelectedImage = [UIImage imageNamed:@"kermit_empty.png"];
    self.rateView.halfSelectedImage = [UIImage imageNamed:@"kermit_half.png"];
    self.rateView.fullSelectedImage = [UIImage imageNamed:@"star_favorite.png"];
    self.rateView.rating = 0;
    self.rateView.editable = YES;
    self.rateView.maxRating = 5;
    self.rateView.delegate = self;
    _vwCommentsBg.layer.borderWidth = 1.0;
    _vwCommentsBg.layer.borderColor = [UIColor redColor].CGColor;
    [self designNavBar];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];

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
    
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                   message:@"Rating saved successfully."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        {
            DashboardViewController *vcDashboardViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
            
            
                for (UIViewController *vc in self.navigationController.viewControllers)
                {
                    if ([vc isKindOfClass:[DashboardViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:YES];
                        return;
                    }
                }
            [self.navigationController pushViewController:vcDashboardViewController animated:NO];
        }
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}
- (IBAction)CommentAndRateBtnActio:(id)sender{
    NSMutableDictionary *inputDick =[NSMutableDictionary dictionaryWithObjectsAndKeys:[[DetailsManager sharedManager]rID],@"UID",[NSString stringWithFormat:@"%d",(int)floor(CustomerRating)],@"Rating",CommentTf.text,@"RatingComments", nil];
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopSaveUserRatingsService:inputDick];
    request =  nil;
    
}
-(void)hideKeyBoard
{
    [CommentTf resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)btnBackClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
