//
//  RejectedReasonsCustomView.m
//  Ecollab
//
//  Created by Kiran Kumar on 21/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "RejectedReasonsCustomView.h"

@implementation RejectedReasonsCustomView
@synthesize arrTitles;
@synthesize delegate;
@synthesize strRequestId;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self =   [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        arrCellSelected = [[NSMutableArray alloc]init];
        arrTitles = [[NSMutableArray alloc]init];
    }
    self.frame = frame;
    return self;
}

-(void)reloadData
{
    _viewTextField.layer.borderColor = [UIColor redColor].CGColor;
    _viewTextField.layer.borderWidth = 1.0;
    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return arrTitles.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"REJECTREASONS";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *dict = [arrTitles objectAtIndex:indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"Comment"];
    
    if ([arrCellSelected containsObject:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([arrCellSelected containsObject:indexPath])
    {
        if(indexPath.row == 3)
        {
            _txtComments.text = @"";
            _txtComments.hidden = YES;
            _viewTextField.hidden = YES;
        }
        [arrCellSelected removeObject:indexPath];
    }
    else
    {
        if(indexPath.row == 3)
        {
            _txtComments.text = @"";
            _txtComments.hidden = NO;
            _viewTextField.hidden = NO;
        }
        [arrCellSelected addObject:indexPath];
    }
    
    [tableView reloadData];

}

- (IBAction)btnTransparentClicked:(UIButton *)sender {
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(removePopUp)])
    {
        [self.delegate removePopUp];
    }
}

-(NSString *)getRejectedIds
{
    NSString *strRejectedIds = @"";
    for (NSIndexPath *indexpath in arrCellSelected)
    {
        NSDictionary *dict = [arrTitles objectAtIndex:indexpath.row];
        if(strRejectedIds != @"")
        {
            strRejectedIds = [NSString stringWithFormat:@"%@,%@",strRejectedIds,[dict objectForKey:@"RID"]];
        }
        else
        {
            strRejectedIds = [dict objectForKey:@"RID"];
        }
    }
    return strRejectedIds;
}
- (IBAction)btnSubmitClicked:(UIButton *)sender {
    
    if(arrCellSelected.count > 0)
    {
        if(_viewTextField.hidden == YES)
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            [dict setObject:strRequestId forKey:@"RID"];
            [dict setObject:@"1" forKey:@"Type"];
            [dict setObject:[self getRejectedIds] forKey:@"RejectedID"];
            [dict setObject:@"" forKey:@"RejectedComments"];
            [self callRejectService:dict];
        }
        else
        {
            if(_txtComments.text.length != 0)
            {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                [dict setObject:strRequestId forKey:@"RID"];
                [dict setObject:@"1" forKey:@"Type"];
                [dict setObject:[self getRejectedIds] forKey:@"RejectedID"];
                [dict setObject:_txtComments.text forKey:@"RejectedComments"];
                [self callRejectService:dict];
            }
            else
            {
                if(self.delegate != nil && [self.delegate respondsToSelector:@selector(showAlert:)])
                {
                    [self.delegate showAlert:@"Please enter comments"];
                }
            }
        }
    }
    else
    {
        if(self.delegate != nil && [self.delegate respondsToSelector:@selector(showAlert:)])
        {
            [self.delegate showAlert:@"Please select atleast one reason for rejection."];
        }
    }
    
}

-(void)callRejectService:(NSMutableDictionary *)dictInputRequest
{
    [EcollabLoader showLoaderAddedTo:self animated:YES withAnimationType:kAnimationTypeNormal];
    ServiceRequester *request = [ServiceRequester new];
    request.serviceRequesterDelegate =  self;
    [request requestForopPlaceChemistryRequestService:dictInputRequest];
    request = nil;
}

-(void)requestReceivedopPlaceChemistryRequestResponce:(NSMutableDictionary *)aregistrationDict;
{
    [EcollabLoader hideLoaderForView:self animated:YES];
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(rejectResponseRecieved:)])
    {
        [self.delegate rejectResponseRecieved:aregistrationDict];
    }
    
}

- (IBAction)btnCancelClicked:(UIButton *)sender {
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(removePopUp)])
    {
        [self.delegate removePopUp];
    }
}
@end
