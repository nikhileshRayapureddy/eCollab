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
{
    float height;
}
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
    height = 0.0;
    // Do any additional setup after loading the view.
    [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];
    [self designNavBar];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
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
    
//    self.LabelEight.adjustsFontSizeToFitWidth = YES;
    self.LabelSix.adjustsFontSizeToFitWidth = YES;
    self.LabelFour.adjustsFontSizeToFitWidth = YES;
    self.labelTwo.adjustsFontSizeToFitWidth = YES;
    CGRect rect = [self.LabelEight.text boundingRectWithSize:CGSizeMake(self.LabelEight.frame.size.width-10, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.LabelEight.font} context:nil];
    height = ceilf(rect.size.height);
    NSLog(@"---%f",height);
    
    self.LabelEight.numberOfLines = 0;
    self.viewAssaysHeightConstraint.constant = height + 10;
    if(!self.LabelEight.text.length)
    {
        self.viewAssays.hidden = YES;
        self.viewAssaysHeightConstraint.constant = 0;
    }
    if(!self.LabelSix.text.length)
    {
        self.viewSubArea.hidden = YES;
        self.viewSubAreaHeightConstraint.constant = 0;
        self.viewAssays.backgroundColor = [UIColor clearColor];
    }
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
    [EcollabLoader hideLoaderForView:self.view animated:NO];
    self.viewScrollHeightConstraint.constant = 290-50+height+30;
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
- (IBAction)btnBackClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
