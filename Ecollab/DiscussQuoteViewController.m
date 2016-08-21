//
//  DiscussQuoteViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 15/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "DiscussQuoteViewController.h"
#import "RequestOrProjectTrackerViewController.h"

@interface DiscussQuoteViewController ()

@end

@implementation DiscussQuoteViewController
@synthesize StatusImgOne,StatusImgTwo,StatusImgThree,StatusImgFour;
@synthesize labelOne,labelTwo,labelThree,LabelFour,LabelFive,LabelSix,labelSeven,LabelEight;
@synthesize DataDict;
@synthesize placeOrder;
@synthesize isRjectOrRegretted;
@synthesize strRequestRID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    [self displayData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayData
{
    self.labelTwo.text = [DataDict objectForKey:@"Service"];
    self.LabelFour.text = [DataDict objectForKey:@"Area"];
    self.LabelSix.text = [DataDict objectForKey:@"SubArea"];
    self.LabelEight.text = [DataDict objectForKey:@"MultipleModelValues"];
    if(placeOrder.intValue == 0)
    {
        _DiscussBtnOutlet.hidden = NO;
    }
    else
    {
        _DiscussBtnOutlet.hidden = YES;
    }
    if(isRjectOrRegretted)
    {
        _DiscussBtnOutlet.hidden = YES;
    }
    
}

- (IBAction)DiscussBtnAction:(id)sender
{
    NSMutableDictionary *dictRequest = [[NSMutableDictionary alloc]init];
    [dictRequest setObject:@"2" forKey:@"Type"];
    [dictRequest setObject:@"" forKey:@"RejectedComments"];
    [dictRequest setObject:strRequestRID forKey:@"RID"];

    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopPlaceChemistryRequestService:dictRequest];
    request = nil;

}

-(void)requestReceivedopPlaceChemistryRequestResponce:(NSMutableDictionary *)aregistrationDict;
{
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    NSString *messageString=[aregistrationDict objectForKey:@"SuccessString"];
    // Check email validation
    if ([[aregistrationDict objectForKey:@"SuccessCode"]intValue] != 200) {
        // show an alert with messageString
    }
    else{
        {
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                           message:messageString
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[RequestOrProjectTrackerViewController class]])
                    {
                        [self.navigationController popToViewController:vc animated:YES];
                    }
                }
            }];
            
            
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }
    
}

@end
