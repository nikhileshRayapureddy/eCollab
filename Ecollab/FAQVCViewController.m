//
//  FAQVCViewController.m
//  Ecollab
//
//  Created by Santhosh Kumar Sivala on 14/07/16.
//  Copyright © 2016 TayaTech. All rights reserved.
//

#import "FAQVCViewController.h"

@interface FAQVCViewController () {
    UITextView *popTextView;
    UIButton *button ;
    int flag;
    NSMutableArray *generalDataArray, *orderingAndTrackinDataArray,*DeliveryAndPaymentDataArray,*myAccountDataArray;
     NSMutableArray *generalDataAnsArray, *orderingAndTrackinDataAnsArray,*DeliveryAndPaymentDataAnsArray,*myAccountDataAnsArray;
    NSMutableString *popviewDisplyaString;
    
    NSMutableArray *arrSelHeader;
    NSMutableArray *arrSelRow;
}


@end

@implementation FAQVCViewController
@synthesize FAQTableview;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    arrSelRow = [[NSMutableArray alloc]init];
    arrSelHeader = [[NSMutableArray alloc]init];
    [FAQTableview setDelegate: self];
    [FAQTableview setDataSource: self];
    [FAQTableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [FAQTableview setSeparatorColor:[UIColor clearColor]];
    generalDataArray = [[NSMutableArray alloc] initWithObjects:@"1. Who can use GVKBIO's eCollab?",@"2. What is a CAS number?",@"3. What is an MDL number?",@"4. What can I find in the reference coumpound database?", nil];
    
    generalDataAnsArray = [[NSMutableArray alloc] initWithObjects:@"Anyone wanting to request a compound synthesis or interested in biology services can use the app to conveniently raise inquiries, get quotes and track the progress of their projects.",@"It is a unique numerical identifier assigned by Chemical Abstracts Service (CAS) to every chemical substance described in the open scientific literature. All CAS numbers are maintained in a CAS registry database to allow unique and convenient search options for the scientific community. Many search engines are available to locate a chemical/reagents based on its CAS number.",@"An MDL number is a unique identification number for each reaction and variation. The format is RXXXnnnnnnnn, where R indicates a reaction, XXX indicates the database containing the reaction record, and ‘nnnnnnnn’ is an 8-digit number.",@"It is a database with various structures linked to their known therapeutic usage as per literature. The structures need to be ordered and can be selected based on therapeutic area of interest.", nil];
    
    
    
    orderingAndTrackinDataArray =[[NSMutableArray alloc] initWithObjects:@"1. How can I request a quote?",@"2. what happens once I raise a request?",@"3. How do I submit a chemistry request?",@"4. How do I submit a biology request?",@"5. How many structure images can I upload for a chemisty request?",@"6. How do I know about services offered in biology",@"7. Can I enter additional information while making a request?",@"8. Can I place a request on phone or email?",@"9. How do I track the statu of my request",@"10. How do I get any alerts for my request?",@"11. How do I edit a request?",@"12. Do I have to reener the complete details if I have not submitted a requests?",@"13. How do I place my order?",@"14. How do I check the status of the request?", nil];
    
    
    
    orderingAndTrackinDataAnsArray =[[NSMutableArray alloc] initWithObjects:@"To request a quote click ‘Request/ Project Tracker’ from home page, Click on Chemistry/Biology, fill in and submit the details.",@"Chemistry Process\n\n Request – Quotation – Order Placement – Project Initiation – Synthesis – Delivery - Payment\n\nBiology Process \n\nRequest – Information Sharing – Discussion – Project Initiation",@"Click ‘Request/ Project Tracker’ from home screen, select ‘Chemistry’ and choose various options\n*Upload a picture of the molecular structure or,\n*Select a molecular structure from our ‘Reference Database’ or,\n*Provide a ‘CAS’ number or the ‘MDL’ number of the compound and \n*One of the above option is mandatory and more than one is accepted for accuracy.\n\nFill and submit other details. Some details like Purity, Chirality, and UOM are mandatory while others are recommended for accuracy and quick response. ",@"Click ‘Request/ Project Tracker’ from home screen, select ‘Biology’ and then select the Service, Area, Sub-Area, and Assay/Model combination and submit the request. We will facilitate the necessary information and initiate a discussion.",@"Only one image can be uploaded. This image can either be clicked from a mobile camera, selected from gallery or chosen from the reference compound database.",@"We have listed all kinds of services by combining values from dropdown lists. You can select any service offered by us and initiate a discussion.",@"Yes, the additional information can be entered in the text space provided for remarks.",@"Yes, our executive will accept the requests on both phone and email. If you want this information to be entered in the system, an executive can do that on your behalf.",@"The request status can be tracked from ‘Request/Project Tracker’. The request will appear under the ‘Requested Quotes’ tab until you have not confirmed your order. Once the order is confirmed the request will also be available under ‘On Going Projects’ tab. We have included exhaustive status messages to keep you updated with the progress of your request.",@"Yes. We continuously update you through alerts whenever an action is taken on your request or it moves in the project lifecycle.",@"A request cannot be edited after submission. You can however send a mail to mobilesupport@gvkbio.com or call us directly to request any changes.",@"No. You can always save your request any number of times by using ‘Save for later’ option and can resume from where you left off by choosing the request from ‘Saved Requests’. Once you are satisfied with the details, you can submit the request.",@"You can either place your order by clicking on the alert sent to you or by clicking the request status ‘Acceptance’ to view the quotation details and then by clicking the ‘Place Order’ button.",@"You can go to the ‘Request/Project tracker’ to check the progress of your request. The tool shows the status of your projects by default. You need to choose the ‘Requested Quotes’ tab to locate your new requests. Once your order is confirmed, these requests are converted to projects and their status can be tracked through ‘On going Projects’ tab.", nil];
    
    
    
    DeliveryAndPaymentDataArray = [[NSMutableArray alloc] initWithObjects:@"1. How is my compound shipped?",@"2. What are the safety measures while shipping compounds?",@"3. How do I make a payment?",@"4. Can I save multiple addresses?",@"5 How can add shipping address?",@"6. Can I change Edit my shipping address?", nil];

    
    
    DeliveryAndPaymentDataAnsArray = [[NSMutableArray alloc] initWithObjects:@"We ship compounds using international courier services like DHL and Fedex. We also accept shipping requests through a specific carrier if it is in the interest of our clients.",@"The ambient compounds are shipped via normal courier services while temperature sensitive compounds are shipped using the dedicated infrastructure from international courier services like DHL.",@"On shipping the compound, we send an invoice by email (a hardcopy is also posted). The payment can then be made as per the credit terms. The preferred methods for payment are wire transfer (domestic and international clients), cheque or DD (domestic clients).",@"Yes, you can store multiple addresses under ‘Shipping Information’ on ‘My Profile’ screen. At the time of placing an order you can choose the address to which the compound must be delivered. More than one shipment of same order is charged to customer.",@"Click ‘Shipping Information’ from ‘My Profile’ page and add your shipping details.",@"Yes, you can change your shipping details by going to ‘Shipping Information’ from ‘My Profile’. You can also delete a shipping address you no longer require.", nil];
    
    
    
    
    
    
    
    myAccountDataArray = [[NSMutableArray alloc] initWithObjects:@"1. How do I create my account?",@"2. I forgot my password?",@"3. Can I change my password?",@"4. How to tell my friend about the app?",@"5. How can I change my user name?", nil];
   
    ///////////
    myAccountDataAnsArray = [[NSMutableArray alloc] initWithObjects:@"Go to the eCollab App and click ‘New User’. Enter your registration details and authenticate via the link sent by the app on your mail id. Viola! It’s done. Please check.",@"Click on ‘Forgot Password’ from the login page and enter your registered email address. An email will be sent to your to help you reset your password.",@"Yes, the password can be changed by choosing ‘Change Password’ from your profile. ",@"Share your app with your friends on either Twitter, Facebook, LinkedIn or Google Plus by choosing share from the contextual menu that pops us on clicking three horizontal bars icon.",@"No, you can only edit personal details like first name, last name, company and designation from ‘My Profile’.", nil];
    
    [self designNavBar];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return 1;
    }
    else
    {
        return 4;
    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return nil;
    }
    else
    {
        
        
        UIView *vwHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50)];
        vwHeader.backgroundColor = [UIColor clearColor];
        
        UIView *vw = [[UIView alloc]initWithFrame:CGRectMake(8, 0, vwHeader.frame.size.width-16, 40)];
        vw.backgroundColor = [UIColor colorWithRed:212.0/255.0 green:212.0/255.0 blue:212.0/255.0 alpha:1.0];
        vw.layer.borderColor = [UIColor blackColor].CGColor;
        vw.layer.borderWidth = 1;
        vw.layer.cornerRadius = 10;
        vw.layer.masksToBounds = YES;
        [vwHeader addSubview:vw];
        
        UIButton *btnarr = [UIButton buttonWithType:UIButtonTypeCustom];
        btnarr.backgroundColor = [UIColor clearColor];
        btnarr.frame = CGRectMake(0, 0, 40, 40);
        [btnarr setImage:[UIImage imageNamed:@"redarrowup.png"] forState:UIControlStateNormal];
        [btnarr setImage:[UIImage imageNamed:@"redarrowdown.png"] forState:UIControlStateSelected];
        [vw addSubview:btnarr];
        if ([arrSelHeader containsObject:[NSString stringWithFormat:@"%li",(long)section]])
        {
            btnarr.selected = YES;
        }
        else
        {
            btnarr.selected = NO;
        }
        UILabel *lblHeader = [[UILabel alloc]initWithFrame:CGRectMake(btnarr.frame.size.width, 0, vw.frame.size.width-40, 40)];
        lblHeader.backgroundColor = [UIColor clearColor];
        if (section == 0) {
            [lblHeader setText:[NSString stringWithFormat:@"General"]];
        }else if (section == 1){
            [lblHeader setText:[NSString stringWithFormat:@"Ordering and Tracking"]];
        }else if (section == 2){
            [lblHeader setText:[NSString stringWithFormat:@"Delivery and Payment"]];
        }else{
            [lblHeader setText:[NSString stringWithFormat:@"My Account"]];
        }
        lblHeader.font = [UIFont fontWithName:@"Helvetica-SemiBold" size:15];
        [vw addSubview:lblHeader];
        
        UIButton *btnHeader = [UIButton buttonWithType:UIButtonTypeCustom];
        btnHeader.backgroundColor = [UIColor clearColor];
        btnHeader.frame = CGRectMake(0, 0, vwHeader.frame.size.width, vwHeader.frame.size.height);
        btnHeader.tag = 100+section;
        [btnHeader addTarget:self action:@selector(btnHeaderClicked:) forControlEvents:UIControlEventTouchUpInside];
        [vwHeader addSubview:btnHeader];
        return vwHeader;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
    else
    {
        if ([arrSelHeader containsObject:[NSString stringWithFormat:@"0"]] && [arrSelHeader containsObject:[NSString stringWithFormat:@"%li",(long)section]]) {
            if (section == 0)
            {
                return generalDataArray.count;
            }
            else if (section == 1)
            {
                return orderingAndTrackinDataArray.count;
            }
            else if (section == 2)
            {
                return DeliveryAndPaymentDataArray.count;
            }
            else
            {
                return myAccountDataArray.count;
            }
        }else if ([arrSelHeader containsObject:[NSString stringWithFormat:@"1"]] && [arrSelHeader containsObject:[NSString stringWithFormat:@"%li",(long)section]]){
            if (section == 0)
            {
                return generalDataArray.count;
            }
            else if (section == 1)
            {
                return orderingAndTrackinDataArray.count;
            }
            else if (section == 2)
            {
                return DeliveryAndPaymentDataArray.count;
            }
            else
            {
                return myAccountDataArray.count;
            }
        }else if ([arrSelHeader containsObject:[NSString stringWithFormat:@"2"]] && [arrSelHeader containsObject:[NSString stringWithFormat:@"%li",(long)section]]){
            if (section == 0)
            {
                return generalDataArray.count;
            }
            else if (section == 1)
            {
                return orderingAndTrackinDataArray.count;
            }
            else if (section == 2)
            {
                return DeliveryAndPaymentDataArray.count;
            }
            else
            {
                return myAccountDataArray.count;
            }
        }else if ([arrSelHeader containsObject:[NSString stringWithFormat:@"3"]] && [arrSelHeader containsObject:[NSString stringWithFormat:@"%li",(long)section]]){
            if (section == 0)
            {
                return generalDataArray.count;
            }
            else if (section == 1)
            {
                return orderingAndTrackinDataArray.count;
            }
            else if (section == 2)
            {
                return DeliveryAndPaymentDataArray.count;
            }
            else
            {
                return myAccountDataArray.count;
            }
        }
        else
        {
            return 0;
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else
    {
   
    if ([arrSelRow containsObject:[NSString stringWithFormat:@"%li-%li",(long)indexPath.row,(long)indexPath.section]] && [arrSelHeader containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.section]])
    {
        NSString *strRowTitle = @"";
        if (indexPath.section == 0) {
            strRowTitle =  [generalDataAnsArray objectAtIndex:indexPath.row];
        }else if (indexPath.section == 1){
            strRowTitle =  [orderingAndTrackinDataAnsArray objectAtIndex:indexPath.row];
        }else if (indexPath.section == 2){
            strRowTitle =  [DeliveryAndPaymentDataAnsArray objectAtIndex:indexPath.row];
        }else{
            strRowTitle =  [myAccountDataAnsArray objectAtIndex:indexPath.row];
        }
        
        
        CGRect rect = [strRowTitle boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 28, 1000)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                             attributes:@{NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:14]}
                                                context:nil];
        if (indexPath.section == 3)
        {
            if (indexPath.row == 3 || indexPath.row == 2 || indexPath.row == 0)
            {
                return 52 + ceilf(rect.size.height) + 35;
            }
            else
            {
                return 52 + ceilf(rect.size.height) + 25;
            }

        }
        else
        {
            if (indexPath.row == 0)
            {
                return 52 + ceilf(rect.size.height) + 35;
            }
            else
            {
                return 52 + ceilf(rect.size.height) + 25;
            }
        }
    }
    else
    {
        return 52;
    }
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    else
    {
   
    static NSString *CellIdentifier = @"FAQTableViewCell";
    
    FAQTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell==nil)
    {
        [tableView registerNib:[UINib nibWithNibName:@"FAQTableViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
        cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    }
    [cell.vwTitle.layer setBorderWidth: 1.0];
    [cell.vwTitle.layer setCornerRadius:5.0f];
    [cell.vwTitle.layer setMasksToBounds:YES];
    [cell.vwTitle.layer setBorderColor:[[UIColor blackColor] CGColor]];
    
    [cell.vwDetail.layer setBorderWidth: 1.0];
    [cell.vwDetail.layer setCornerRadius:5.0f];
    [cell.vwDetail.layer setMasksToBounds:YES];
    [cell.vwDetail.layer setBorderColor:[[UIColor blackColor] CGColor]];
    cell.constHeightVwTitle.constant = 50;
    if (indexPath.section == 0)
    {
        cell.lblTitle.text = [generalDataArray objectAtIndex:indexPath.row];
        [cell.btnDetail setAttributedTitle:[self setFontForTitlesForText:[generalDataAnsArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    }
    else if (indexPath.section == 1)
    {
        cell.lblTitle.text = [orderingAndTrackinDataArray objectAtIndex:indexPath.row];
        [cell.btnDetail setAttributedTitle:[self setFontForTitlesForText:[orderingAndTrackinDataAnsArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
        if (indexPath.row == 10)
        {
            [cell.btnDetail addTarget:self action:@selector(btnDetailClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            
        }
    }
    else if (indexPath.section == 2)
    {
        cell.lblTitle.text = [DeliveryAndPaymentDataArray objectAtIndex:indexPath.row];
        [cell.btnDetail setAttributedTitle:[self setFontForTitlesForText:[DeliveryAndPaymentDataAnsArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    }
    else
    {
        cell.lblTitle.text = [myAccountDataArray objectAtIndex:indexPath.row];
        [cell.btnDetail setAttributedTitle:[self setFontForTitlesForText:[myAccountDataAnsArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];

    }
    
    if ([arrSelRow containsObject:[NSString stringWithFormat:@"%li-%li",(long)indexPath.row,(long)indexPath.section]] && [arrSelHeader containsObject:[NSString stringWithFormat:@"%li",(long)indexPath.section]])
    {
        cell.vwDetail.hidden = NO;
        cell.btnArr.selected = YES;
    }
    else
    {
        cell.vwDetail.hidden = YES;
        cell.btnArr.selected = NO;
    }
    return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return 0;
    }
    else
    {
        return 50;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == self.vwSideMenuCustomView.menuTable)
    {
        return [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    else
    {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if ([arrSelRow containsObject:[NSString stringWithFormat:@"%li-%li",(long)indexPath.row,(long)indexPath.section]])
    {
        [arrSelRow removeObject:[NSString stringWithFormat:@"%li-%li",(long)indexPath.row,(long)indexPath.section]];
    }
    else
    {
        
        [arrSelRow addObject:[NSString stringWithFormat:@"%li-%li",(long)indexPath.row,(long)indexPath.section]];
    }
    [tableView reloadData];
    }

}
-(void)btnDetailClicked:(UIButton*)sender
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://www.gvkbio.com"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.gvkbio.com"]];
    }

}
-(void)btnHeaderClicked:(UIButton*)sender
{
    
    if ([arrSelHeader containsObject:[NSString stringWithFormat:@"%li",(long)sender.tag-100]])
    {
        [arrSelHeader removeObject:[NSString stringWithFormat:@"%li",(long)sender.tag-100]];
    }
    else
    {
        
        [arrSelHeader addObject:[NSString stringWithFormat:@"%li",(long)sender.tag-100]];
    }
    
    [FAQTableview reloadData];
}

- (NSMutableAttributedString *)setFontForTitlesForText:(NSString*)text {
    NSMutableAttributedString * string = [[NSMutableAttributedString alloc]initWithString:text];
    
    NSArray *boldWords= [[NSArray alloc]initWithObjects:@"Chemistry Process",@"Biology Process", nil];
    NSArray *blueWords= [[NSArray alloc]initWithObjects:@"Request – Quotation – Order Placement – Project Initiation – Synthesis – Delivery - Payment",@"Request – Information Sharing – Discussion – Project Initiation", nil];
    NSArray *blueSmallWords= [[NSArray alloc]initWithObjects:@"*One of the above option is mandatory and more than one is accepted for accuracy.", nil];
    NSArray *email= [[NSArray alloc]initWithObjects:@"mobilesupport@gvkbio.com", nil];

    for (NSString *word in boldWords) {
        NSRange range=[text rangeOfString:word];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range];
        [string addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:range];
    }
    for (NSString *word in blueWords) {
        NSRange range=[text rangeOfString:word];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:19.0/255.0 green:157.0/255.0 blue:255.0/255.0 alpha:1.0] range:range];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
        [string addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];

    }
    for (NSString *word in blueSmallWords) {
        NSRange range=[text rangeOfString:word];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:19.0/255.0 green:157.0/255.0 blue:255.0/255.0 alpha:1.0] range:range];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:8] range:range];
        [string addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
        
    }
    for (NSString *word in email) {
        NSRange range=[text rangeOfString:word];
        [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:19.0/255.0 green:157.0/255.0 blue:255.0/255.0 alpha:1.0] range:range];
        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
        [string addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
        
    }

    return string;
}

@end
