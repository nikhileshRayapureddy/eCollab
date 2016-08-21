//
//  NewBiologyRequestViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 18/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceRequester.h"
#import "DetailsManager.h"
#import "BaseViewController.h"
#import "BiologyDropDownListView.h"

@interface NewBiologyRequestViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,ServiceRequesterProtocol,BiologyDropDownListView_Delegate>
{
    BiologyDropDownListView *viewDropDown;
}
@property (strong, nonatomic) IBOutlet UIButton *ServiceBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *AreaOutlet;
@property (strong, nonatomic) IBOutlet UIButton *SubAreaBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *ModelsBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *SubmitBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *SaveForLaterBtnOutlet;
@property (strong, nonatomic) NSMutableDictionary *OtherViewsDataDictionary;
@property (assign, nonatomic) BOOL isFromRequestAQuote;
- (IBAction)ServiceBtnAction:(id)sender;
- (IBAction)AreaBtnAction:(id)sender;
- (IBAction)SubAreaBtnAction:(id)sender;
- (IBAction)ModelsBtnAction:(id)sender;
- (IBAction)SubmitBtnAction:(id)sender;
- (IBAction)SaveForLaterBtnAction:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *lblRequestTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewAssaysHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *viewAssays;

@property (weak, nonatomic) IBOutlet UIView *viewSubArea;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewSubAreaHeightConstraint;

@property (strong, nonatomic) NSMutableDictionary *dictSavedOrderDetails;
-(void)bindSavedOrderDetails:(NSDictionary *)dict;

@property (strong, nonatomic) NSString *strServiceIDFinal;
@property (strong, nonatomic) NSString *strAreaIDFinal;
@property (strong, nonatomic) NSString *strSubAreaIDFinal;
@property (strong, nonatomic) NSString *strModelIdIDFinal;
@property (strong, nonatomic) NSString *strMultipleModelIdIDFinal;

@property (assign, nonatomic) BOOL shouldUpdateRequest;
@property (strong, nonatomic) NSString *strRIDForSavedRequest;
@property (assign, nonatomic) BOOL isSubmitAction;



@property (assign, nonatomic) BOOL isFromTracking;
@property (weak, nonatomic) IBOutlet UIImageView *imgServiceDownArrow;
@property (weak, nonatomic) IBOutlet UIImageView *imgSubAreaDownArrow;
@property (weak, nonatomic) IBOutlet UIImageView *imgModelsDownArrow;
@property (weak, nonatomic) IBOutlet UIImageView *imgAreaDownArrow;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
