//
//  BiologyDropDownListView.m
//  Ecollab
//
//  Created by Kiran Kumar on 21/08/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "BiologyDropDownListView.h"
#import "BiologyDropDownListCustomCell.h"

@implementation BiologyDropDownListView
@synthesize arrTitles;
@synthesize tableViewTag;
@synthesize delegate;
@synthesize arrCellSelected;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self =   [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
        arrCellSelected = [[NSMutableArray alloc]init];
        arrTitles = [[NSMutableArray alloc]init];
        tableViewTag = 0;
    }
    self.frame = frame;
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)reloadData
{
    if(tableViewTag == 40)
    {
        _btnDone.hidden = NO;
    }
    else
    {
        _btnDone.hidden = YES;
    }
    
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectMake(0,0,0,0)]];

    [self.tableView reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    return arrTitles.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BIOLOGYCELL";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.numberOfLines = 2;
    NSDictionary *dict = [arrTitles objectAtIndex:indexPath.row];
    switch (tableViewTag) {
        case 10:
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Service"]];
            break;
        case 20:
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]];
            break;
        case 30:
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]];
            break;
        case 40:
            if ([arrCellSelected containsObject:indexPath])
            {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
            {
                cell.accessoryType = UITableViewCellAccessoryNone;
                
            }
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"Description"]];
            break;
        default:
            break;
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (tableViewTag) {
        case 40:
            if ([arrCellSelected containsObject:indexPath])
            {
                [arrCellSelected removeObject:indexPath];
            }
            else
            {
                [arrCellSelected addObject:indexPath];
            }
            break;
            
        default:
            if(self.delegate != nil && [self.delegate respondsToSelector:@selector(selectedDictionary:forTag:)])
            {
                [self.delegate selectedDictionary:[arrTitles objectAtIndex:indexPath.row] forTag:tableViewTag];
            }
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView reloadData];
    
}

- (IBAction)btnDoneClicked:(UIButton *)sender
{
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(selectedListOfAssays:)])
    {
        [self.delegate selectedListOfAssays:arrCellSelected];
    }
}

- (IBAction)btnTransparentClicked:(UIButton *)sender {
    if(self.delegate != nil && [self.delegate respondsToSelector:@selector(removeSelectionPopUp)])
    {
        [self.delegate removeSelectionPopUp];
    }
}
@end
