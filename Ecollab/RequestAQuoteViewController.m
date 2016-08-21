//
//  RequestAQuoteViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 13/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "RequestAQuoteViewController.h"

@interface RequestAQuoteViewController ()

@end

@implementation RequestAQuoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self designNavBar];
    
    if ([[UIScreen mainScreen] bounds].size.width > 320)
    {
        [self.BiologyBtnOutlet setImage:[UIImage imageNamed:@"biology_img_1.png"] forState:UIControlStateNormal];
        [self.ChemistryBtnOutlet setImage:[UIImage imageNamed:@"chemistry_img_1.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.BiologyBtnOutlet setImage:[UIImage imageNamed:@"biology.png"] forState:UIControlStateNormal];
        [self.ChemistryBtnOutlet setImage:[UIImage imageNamed:@"chemistry.png"] forState:UIControlStateNormal];
    }
    
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

- (IBAction)ChemistryBtnAction:(id)sender {
    NewChemistryRequestViewController *NCRVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewChemistryRequestViewController"];
    NCRVCtrlObj.isFromRequestAQuote = YES;
    [self.navigationController pushViewController:NCRVCtrlObj animated:YES];
}

- (IBAction)BiologyBtnAction:(id)sender {
    NewBiologyRequestViewController *NBRVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"NewBiologyRequestViewController"];
    NBRVCtrlObj.isFromRequestAQuote = YES;
    [self.navigationController pushViewController:NBRVCtrlObj animated:YES];
    
}

- (IBAction)FAQBtnAction:(id)sender {
    FAQVCViewController *FAQVCtrlObj = [self.storyboard instantiateViewControllerWithIdentifier:@"FAQVCViewController"];
    [self.navigationController pushViewController:FAQVCtrlObj animated:YES];
}
@end
