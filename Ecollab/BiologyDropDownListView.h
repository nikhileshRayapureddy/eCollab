//
//  BiologyDropDownListView.h
//  Ecollab
//
//  Created by Kiran Kumar on 21/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BiologyDropDownListView_Delegate <NSObject>
@optional

-(void)removeSelectionPopUp;
-(void)selectedDictionary :(NSDictionary *)dict forTag:(NSInteger)tagSelected;
-(void)selectedListOfAssays:(NSMutableArray*)arrCellSelected;
@end

@interface BiologyDropDownListView : UIView
{
    
}
@property (assign, nonatomic) id <BiologyDropDownListView_Delegate> delegate;
@property (assign, nonatomic) NSInteger tableViewTag;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrTitles;
@property (weak, nonatomic) IBOutlet UIButton *btnDone;
@property (strong, nonatomic)NSMutableArray *arrCellSelected;
-(void)reloadData;
- (IBAction)btnDoneClicked:(UIButton *)sender;

- (IBAction)btnTransparentClicked:(UIButton *)sender;

@end
