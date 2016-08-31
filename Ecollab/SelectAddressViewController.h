//
//  SelectAddressViewController.h
//  Ecollab
//
//  Created by Kiran Kumar on 20/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceRequester.h"

@interface SelectAddressViewController : UIViewController<ServiceRequesterProtocol>
{
    NSDictionary *dictDefaultAddress;
}
- (IBAction)btnChangeAddressClicked:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress1;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress2;
- (IBAction)btnSubmitClicked:(UIButton *)sender;
@property (strong, nonatomic) NSString *strRequestRID;
- (IBAction)btnBackClicked:(UIButton *)sender;

@end
