//
//  RejectedReasonsCustomView.h
//  Ecollab
//
//  Created by Kiran Kumar on 21/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RejectedReasonsCustomView_Delegate <NSObject>
@optional

-(void)removePopUp;
-(void)rejectResponseRecieved:(NSMutableDictionary *)dictResponse;
-(void)showAlert:(NSString *)message;
@end
@interface RejectedReasonsCustomView : UIView<ServiceRequesterProtocol>
{
    NSMutableArray *arrCellSelected;
}

@property (assign, nonatomic)id <RejectedReasonsCustomView_Delegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrTitles;
@property (weak, nonatomic) IBOutlet UITextField *txtComments;
@property (weak, nonatomic) IBOutlet UIView *viewTextField;
@property (strong, nonatomic) NSString *strRequestId;
-(void)reloadData;
- (IBAction)btnTransparentClicked:(UIButton *)sender;
- (IBAction)btnSubmitClicked:(UIButton *)sender;
- (IBAction)btnCancelClicked:(UIButton *)sender;
@end
