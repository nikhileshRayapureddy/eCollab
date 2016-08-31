//
//  ShareViewController.m
//  Ecollab
//
//  Created by NIKHILESH on 21/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self designNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnTwitterClicked:(UIButton *)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"https://twitter.com/intent/tweet?status=http%3A//www.gvkbio.com/"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/intent/tweet?status=http%3A//www.gvkbio.com/"]];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry!"
                                                                       message:@"Unable to Share."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }


}

- (IBAction)btnFbClicked:(UIButton *)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"https://www.facebook.com/sharer/sharer.php?u=http%3A//www.gvkbio.com/"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/sharer/sharer.php?u=http%3A//www.gvkbio.com/"]];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry!"
                                                                       message:@"Unable to Share."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

- (IBAction)btnLinkedInClicked:(UIButton *)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"https://www.linkedin.com/shareArticle?mini=true&url=http%3A//www.gvkbio.com/&title=gvkbio&summary=&source="]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.linkedin.com/shareArticle?mini=true&url=http%3A//www.gvkbio.com/&title=gvkbio&summary=&source="]];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry!"
                                                                       message:@"Unable to Share."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

- (IBAction)btnGooglPlusClicked:(UIButton *)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"https://plus.google.com/share?url=http%3A//www.gvkbio.com/"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://plus.google.com/share?url=http%3A//www.gvkbio.com/"]];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sorry!"
                                                                       message:@"Unable to Share."
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    
}

- (IBAction)btnBackClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
