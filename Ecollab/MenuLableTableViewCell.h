//
//  MenuLableTableViewCell.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 02/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuLableTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *DisplayLabel;
@property (strong, nonatomic) IBOutlet UIImageView *MenuImg;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;

@end
