//
//  ReachUsViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "ReachUsViewController.h"
#import "DashboardViewController.h"
#import <MessageUI/MessageUI.h>
@interface ReachUsViewController ()<MFMailComposeViewControllerDelegate>
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
    _vwCommentsBg.layer.borderWidth = 1.0;
    _vwCommentsBg.layer.borderColor = [UIColor redColor].CGColor;
    [self designNavBar];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
    UIButton *btnrate = [rateView viewWithTag:100];
    [self btnRatingSelected:btnrate];


}
//method for rating functionality
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
    [self.view endEditing:YES];
    [CommentTf resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)btnBackClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnRatingSelected:(UIButton *)sender {
    
    for (int i=0; i<5; i++) {
        UIButton *btnrate = [rateView viewWithTag:101+i];
        [btnrate setImage:[UIImage imageNamed:@"kermit_empty.png"] forState:UIControlStateNormal];
    }
    for (int i=0; i<=(sender.tag - 100); i++) {
        UIButton *btnrate = [rateView viewWithTag:100+i];
        [btnrate setImage:[UIImage imageNamed:@"star_favorite.png"] forState:UIControlStateNormal];
    }
    CustomerRating = sender.tag-100;
}
- (IBAction)btnMailClicked:(UIButton *)sender {
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        //       [mail setSubject:@"Sample Subject"];
        //       [mail setMessageBody:@"Here is some main text in the email!" isHTML:NO];
        [mail setToRecipients:@[@"mobilesupport@gvkbio.com"]];
        
        [self presentViewController:mail animated:YES completion:NULL];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                       message:@"This device cannot send E-Mail."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }
}
    - (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
    {
        switch (result) {
            case MFMailComposeResultSent:
                NSLog(@"You sent the email.");
                break;
            case MFMailComposeResultSaved:
                NSLog(@"You saved a draft of this email");
                break;
            case MFMailComposeResultCancelled:
                NSLog(@"You cancelled sending this email.");
                break;
            case MFMailComposeResultFailed:
                NSLog(@"Mail failed:  An error occurred when trying to compose this email");
                break;
            default:
                NSLog(@"An error occurred when trying to compose this email");
                break;
        }
        
        [self dismissViewControllerAnimated:YES completion:NULL];
    }

@end
