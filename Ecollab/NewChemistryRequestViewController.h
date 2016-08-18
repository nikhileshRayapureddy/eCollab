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
@property (strong, nonatomic) IBOutlet UICollectionView *mycollectionView;
@property (strong, nonatomic) NSMutableDictionary *OtherViewsDataDictionary;

@property (strong, nonatomic) IBOutlet UIView *ManagingSubview;
@property (strong, nonatomic) IBOutlet UIScrollView *SubScrollview;
@property (strong, nonatomic) IBOutlet UIView *managingInActiveView;
@property (strong, nonatomic) IBOutlet UILabel *Therapeutic;
@property (strong, nonatomic) IBOutlet UILabel *TherapeuticRedHeader;





@property (strong, nonatomic) IBOutlet UIScrollView *BackgrounScrollview;
@property (strong, nonatomic) IBOutlet UILabel *NewOrEditChemistryReqHeaderLabel;
@property (strong, nonatomic) IBOutlet UILabel *GetAProposalLabel;
@property (strong, nonatomic) IBOutlet UIButton *TakeOrChoosePhotoBtnOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *TakeOrChoosePhotoImageview;
@property (strong, nonatomic) IBOutlet UIButton *ChoseFromReferenceCompounDBBtnOutlet;

@property (strong, nonatomic) IBOutlet UIImageView *ChoseFromReferenceCompounDBImageview;

@property (strong, nonatomic) IBOutlet UITextField *CASTextField;

@property (strong, nonatomic) IBOutlet UITextField *MDLTextField;
@property (strong, nonatomic) IBOutlet UITextField *JournalReferenceTextField;
@property (strong, nonatomic) IBOutlet UIButton *ExpectedDeleveryDateBtnOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *ExpectedDeleveryDateImageview;

@property (strong, nonatomic) IBOutlet UITextField *QuantityTextField;
@property (strong, nonatomic) IBOutlet UIButton *MGBtnOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *MGImageview;
@property (strong, nonatomic) IBOutlet UILabel *MGLabelOutlet;
@property (strong, nonatomic) IBOutlet UIButton *GBtnOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *GImageview;
@property (strong, nonatomic) IBOutlet UILabel *GLabelOutlet;

@property (strong, nonatomic) IBOutlet UIButton *KGBtnOutlet;
@property (strong, nonatomic) IBOutlet UIImageView *KGImageview;
@property (strong, nonatomic) IBOutlet UILabel *KGLabelOutlet;

@property (strong, nonatomic) IBOutlet UIButton *PuritybtnOutlet;
@property (strong, nonatomic) IBOutlet UITextField *CharitybtnOutlet;
@property (strong, nonatomic) IBOutlet UITextField *RemarksTextField;
@property (strong, nonatomic) IBOutlet UIButton *SubmitBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *SaveForLaterBtnOutlet;
@property (strong, nonatomic) IBOutlet UIButton *ButtonTableSubview;
@property (strong, nonatomic) IBOutlet UIView *subviewofSubScrollview;
@property (strong, nonatomic) IBOutlet UIView *ZoomManagingView;
@property (strong, nonatomic) IBOutlet UIImageView *ZoomImageContentView;

@property (strong, nonatomic) IBOutlet UIButton *ZoomCloseButton;






- (IBAction)ZoomCloseButtonAction:(id)sender;
- (IBAction)IMGSubmitAction:(id)sender;
- (IBAction)IMGCancelAction:(id)sender;
- (IBAction)ButtonTableSubviewAction:(id)sender;
- (IBAction)SaveForLaterBtnAction:(id)sender;
- (IBAction)SubmitBtnAction:(id)sender;
- (IBAction)PuritybtnAction:(id)sender;
- (IBAction)WeightBtnAction:(id)sender;
- (IBAction)ExpectedDeleveryDateBtnAction:(id)sender;
- (IBAction)ChoseFromReferenceCompounDBBtnAction:(id)sender;
- (IBAction)TakeOrChoosePhotoBtnAction:(id)sender;

@end
