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
}

-(void)designNavBar
{
    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:237.0/255.0 green:27.0/255.0 blue:36.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIImageView *imgLogoEcoLab = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    imgLogoEcoLab.backgroundColor = [UIColor clearColor];
    imgLogoEcoLab.image = [UIImage imageNamed:@"ecolablogo.png"];
    imgLogoEcoLab.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = imgLogoEcoLab;

    UIImageView *imgLogoGVK = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    imgLogoGVK.backgroundColor = [UIColor clearColor];
    imgLogoGVK.image = [UIImage imageNamed:@"gvk_whitelogo1.png"];
    imgLogoGVK.contentMode = UIViewContentModeScaleAspectFit;

    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:imgLogoGVK];
    self.navigationItem.rightBarButtonItem = rightBtn;

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
