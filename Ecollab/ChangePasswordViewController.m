//
//  ChangePasswordViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITextFieldDelegate>

@end

@implementation ChangePasswordViewController
@synthesize oldPassword,NewPassword,confirmPassword,ChangePasswordOutlet,CancelOutlet;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self designNavBar];
    self.NewPassword.delegate = self;
    self.confirmPassword.delegate = self;
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: [[NSAttributedString alloc]initWithString:@"OLD PASSWORD *"]];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(13, 1)];
    
    oldPassword.attributedPlaceholder = text;
    
    text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: [[NSAttributedString alloc]initWithString:@"NEW PASSWORD *"]];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(13, 1)];
    
    NewPassword.attributedPlaceholder = text;
    
    text =
    [[NSMutableAttributedString alloc]
     initWithAttributedString: [[NSAttributedString alloc]initWithString:@"CONFIRM PASSWORD *"]];
    
    [text addAttribute:NSForegroundColorAttributeName
                 value:[UIColor redColor]
                 range:NSMakeRange(17, 1)];
    
    confirmPassword.attributedPlaceholder = text;
    
    _conslblNewPwdStrenngthHeight.constant = 0;
    _vwNewPwdStrenngth.hidden = YES;
    _constlblCNFNewPwdStrenngthHeight.constant = 0;
    _vwCNFNewPwdStrenngth.hidden = YES;
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.scrlVwChangePwd.contentSize = CGSizeMake(self.scrlVwChangePwd.frame.size.width, 500);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestReceivedopChangePasswordResponce:(NSMutableDictionary *)aregistrationDict{
    // show a message success or not
    [EcollabLoader hideLoaderForView:self.view animated:YES];
    
    if ([[aregistrationDict objectForKey:@"SuccessCode"]intValue] != 200) {
        
        [self showAlertWithMessage:[aregistrationDict objectForKey:@"SuccessString"]];
    }
    else
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Success!"
                                                                       message:[aregistrationDict objectForKey:@"SuccessString"]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
            
        }];
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}


- (IBAction)ChangePasswordAction:(id)sender {
    
    [oldPassword resignFirstResponder];
    [NewPassword resignFirstResponder];
    [confirmPassword resignFirstResponder];
    if ([oldPassword.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Enter old password."];
    }
    else if (oldPassword.text.length < 8)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if (oldPassword.text.length > 12)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if ([NewPassword.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Enter new password."];
    }
    else if (NewPassword.text.length < 8)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if (NewPassword.text.length > 12)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if ([confirmPassword.text isEqualToString:@""])
    {
        [self showAlertWithMessage:@"Enter confirm password."];
    }
    else if (confirmPassword.text.length < 8)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if (confirmPassword.text.length > 12)
    {
        [self showAlertWithMessage:@"Length of password must be between 8-12 characters and it should contain 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character ( i.e. !,@,#,$,%,&,* )."];
    }
    else if (![NewPassword.text isEqualToString:confirmPassword.text])
    {
        [self showAlertWithMessage:@"New password and Confirm Password does not match."];
    }
    else{
        [EcollabLoader showLoaderAddedTo:self.view animated:YES withAnimationType:kAnimationTypeNormal];

        NSMutableDictionary *ChangePasswordDict = [NSMutableDictionary new];
        ChangePasswordDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:[[DetailsManager sharedManager]rID],@"UID",oldPassword.text,@"OldPassword",confirmPassword.text,@"CPassword",NewPassword.text,@"Password",nil];
        if ([confirmPassword.text isEqualToString:NewPassword.text])
        {
            ServiceRequester *request = [ServiceRequester new];
            request.serviceRequesterDelegate = self;
            [request requestForopChangePasswordService:ChangePasswordDict];
            request = nil;
        }
    }
}

-(void)showAlertWithMessage:(NSString*)strMsg
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert!"
                                                                   message:strMsg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}
- (IBAction)CancelPasswordClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == NewPassword)
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength == 2 || newLength == 1)
        {
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: [[NSAttributedString alloc]initWithString:@"STRENGTH : WEAK"]];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor greenColor]
                         range:NSMakeRange(11, 4)];
            
            _lblNewPwdStrenngth.attributedText = text;
            _conslblNewPwdStrenngthHeight.constant = 30;
            _vwNewPwdStrenngth.hidden = NO;
        }
        else if (newLength >2 && newLength <= 8)
        {
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: [[NSAttributedString alloc]initWithString:@"STRENGTH : MEDIUM"]];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor greenColor]
                         range:NSMakeRange(11, 6)];
            
            _lblNewPwdStrenngth.attributedText = text;
            _conslblNewPwdStrenngthHeight.constant = 30;
            _vwNewPwdStrenngth.hidden = NO;
        }
        else if(newLength > 8 && newLength <12)
        {
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: [[NSAttributedString alloc]initWithString:@"STRENGTH : STRONG"]];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor greenColor]
                         range:NSMakeRange(11, 6)];
            
            _lblNewPwdStrenngth.attributedText = text;
            _vwNewPwdStrenngth.hidden = NO;
            _conslblNewPwdStrenngthHeight.constant = 30;
        }
        else if(newLength >= 12)
        {
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: [[NSAttributedString alloc]initWithString:@"STRENGTH : Password Max Length Reached"]];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor greenColor]
                         range:NSMakeRange(11, 27)];
            
            _lblNewPwdStrenngth.attributedText = text;
            _conslblNewPwdStrenngthHeight.constant = 30;
            _vwNewPwdStrenngth.hidden = NO;
            
        }

        else
        {
            _conslblNewPwdStrenngthHeight.constant = 0;
            _vwNewPwdStrenngth.hidden = YES;
//            _vwCNFNewPwdStrenngth.hidden = YES;

        }
        return newLength <= 12;
    }
    else if (textField == confirmPassword)
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength == 2 || newLength == 1)
        {
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: [[NSAttributedString alloc]initWithString:@"STRENGTH : WEAK"]];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor greenColor]
                         range:NSMakeRange(11, 4)];
            
            _lblCNFNewPwdStrenngth.attributedText = text;
            _constlblCNFNewPwdStrenngthHeight.constant = 30;
            _vwCNFNewPwdStrenngth.hidden = NO;
        }
        else if (newLength >2 && newLength <= 8)
        {
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: [[NSAttributedString alloc]initWithString:@"STRENGTH : MEDIUM"]];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor greenColor]
                         range:NSMakeRange(11, 6)];
            
            _lblCNFNewPwdStrenngth.attributedText = text;
            _constlblCNFNewPwdStrenngthHeight.constant = 30;
            _vwCNFNewPwdStrenngth.hidden = NO;
        }
        else if(newLength > 8 && newLength <12)
        {
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: [[NSAttributedString alloc]initWithString:@"STRENGTH : STRONG"]];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor greenColor]
                         range:NSMakeRange(11, 6)];
            
            _lblCNFNewPwdStrenngth.attributedText = text;
            _vwCNFNewPwdStrenngth.hidden = NO;
            _constlblCNFNewPwdStrenngthHeight.constant = 30;
        }
        else if(newLength >= 12)
        {
            NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
             initWithAttributedString: [[NSAttributedString alloc]initWithString:@"STRENGTH : Password Max Length Reached"]];
            
            [text addAttribute:NSForegroundColorAttributeName
                         value:[UIColor greenColor]
                         range:NSMakeRange(11, 27)];
            
            _lblCNFNewPwdStrenngth.attributedText = text;
            _constlblCNFNewPwdStrenngthHeight.constant = 30;
            _vwCNFNewPwdStrenngth.hidden = NO;
            
        }
        
        else
        {
            _constlblCNFNewPwdStrenngthHeight.constant = 0;
            _vwCNFNewPwdStrenngth.hidden = YES;
            
        }
        return newLength <= 12;
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField == NewPassword)
    {
        _conslblNewPwdStrenngthHeight.constant = 0;
        _vwNewPwdStrenngth.hidden = YES;
    }
    else if (textField == confirmPassword)
    {
        _constlblCNFNewPwdStrenngthHeight.constant = 0;
        _vwCNFNewPwdStrenngth.hidden = YES;
    }
    return YES;
}

- (IBAction)btnBackClicked:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
