//
//  DiscussQuoteViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 15/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "DiscussQuoteViewController.h"

@interface DiscussQuoteViewController ()

@end

@implementation DiscussQuoteViewController
@synthesize StatusImgOne,StatusImgTwo,StatusImgThree,StatusImgFour;
@synthesize labelOne,labelTwo,labelThree,LabelFour,LabelFive,LabelSix,labelSeven,LabelEight;
@synthesize DataDict;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)DiscussBtnAction:(id)sender {
}
@end
