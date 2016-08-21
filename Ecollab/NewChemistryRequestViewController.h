//
//  NewChemistryRequestViewController.h
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 18/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceRequester.h"
#import "ImageCollectionViewCell.h"
#import "DetailsManager.h"
@interface NewChemistryRequestViewController : UIViewController<UIScrollViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,ServiceRequesterProtocol,UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) NSMutableDictionary *OtherViewsDataDictionary;

@property (strong, nonatomic) IBOutlet UIScrollView *BackgrounScrollview;
@property (strong, nonatomic) IBOutlet UILabel *NewOrEditChemistryReqHeaderLabel;
@property (strong, nonatomic) IBOutlet UILabel *GetAProposalLabel;
@property (strong, nonatomic) IBOutlet UIButton *TakeOrChoosePhotoBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *ChoseFromReferenceCompounDBBtnOutlet;

@property (strong, nonatomic) IBOutlet UITextField *CASTextField;
@property (strong, nonatomic) IBOutlet UITextField *MDLTextField;
@property (strong, nonatomic) IBOutlet UITextField *JournalReferenceTextField;
@property (strong, nonatomic) IBOutlet UIButton *ExpectedDeleveryDateBtnOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *ExpectedDeleveryDateImageview;

@property (strong, nonatomic) IBOutlet UITextField *QuantityTextField;
@property (strong, nonatomic) IBOutlet UIButton *MGBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *GBtnOutlet;

@property (strong, nonatomic) IBOutlet UIButton *KGBtnOutlet;

@property (strong, nonatomic) IBOutlet UIButton *PuritybtnOutlet;
@property (strong, nonatomic) IBOutlet UITextField *CharitybtnOutlet;
@property (strong, nonatomic) IBOutlet UITextField *RemarksTextField;
@property (strong, nonatomic) IBOutlet UIButton *SubmitBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *SaveForLaterBtnOutlet;

@property (weak, nonatomic) IBOutlet UIImageView *imgVwTakeOrChoose;
@property (weak, nonatomic) IBOutlet UIImageView *imgVwReferenceComp;

@property (weak, nonatomic) IBOutlet UIView *vwCasTxtFldBg;
@property (weak, nonatomic) IBOutlet UIView *vwMdlTxtFldBg;
@property (weak, nonatomic) IBOutlet UIView *vwJournalTxtFldBg;
@property (weak, nonatomic) IBOutlet UIView *vwExpDelDate;
@property (weak, nonatomic) IBOutlet UIView *vwQtyBg;
@property (weak, nonatomic) IBOutlet UIView *vwChiralityTxtFldBg;
@property (weak, nonatomic) IBOutlet UIView *vwRemarksTxtFldBg;


- (IBAction)SaveForLaterBtnAction:(id)sender;
- (IBAction)SubmitBtnAction:(id)sender;
- (IBAction)PuritybtnAction:(id)sender;
- (IBAction)WeightBtnAction:(id)sender;
- (IBAction)ExpectedDeleveryDateBtnAction:(id)sender;
- (IBAction)ChoseFromReferenceCompounDBBtnAction:(id)sender;
- (IBAction)TakeOrChoosePhotoBtnAction:(id)sender;

@property (strong, nonatomic) NSDictionary *dictSavedChemestryData;
@property (assign, nonatomic) BOOL isFromRequestAQuote;

@property (assign, nonatomic) BOOL isFromTracking;
@property (weak, nonatomic) IBOutlet UIView *scrollViewInnerView;

@end
