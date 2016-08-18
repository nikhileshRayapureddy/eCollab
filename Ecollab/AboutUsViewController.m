//
//  AboutUsViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController
@synthesize DisplayText;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    NSString * aboutUsText = @"GVK Biosciences (GVK BIO) is one of Asia’s leading Discovery Research and Development organizations with over a decade of rich experience. At GVK BIO, we blend science with people and technology to help accelerate research and development for over 350 clients globally. Our clients include the world’s top 10 corporations in the field of Pharmaceutical, Agrochemical, Electronics, Biotechnology and Academics. Our distinctiveness comes from our expertise in the breadth and depth of services that we provide in drug development. GVK BIO’s capabilities include Integrated Programs, Discovery Services, Development Services, Contract Manufacturing and Formulation R&D Services. GVK BIO is a 2000 people strong company, which includes a large pool of 1700 scientists who are passionate about enhancing the quality of human life, striving each day to address the unmet global healthcare challenges. Lower costs, superior infrastructure, boosted efficiencies and an infusion of fresh ideas make GVK BIO an ideal research partner.";
    [DisplayText setText:aboutUsText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
