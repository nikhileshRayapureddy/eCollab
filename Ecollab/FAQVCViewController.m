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
}


@end

@implementation FAQVCViewController
@synthesize FAQTableview;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gvkbg.png"]]];
    [FAQTableview setDelegate: self];
    [FAQTableview setDataSource: self];
    flag=0;
    generalDataArray = [[NSMutableArray alloc] initWithObjects:@"1. Who can use GVKBIO's eCollab ?",@"2. What is a CAS number ?",@"3. What is an MDL number ?",@"4. What can I find in the reference coumpound database ?", nil];
    
    generalDataAnsArray = [[NSMutableArray alloc] initWithObjects:@"Anyone wanting to request a compound synthesis or interested in biology services can use the app to conveniently raise inquiries, get quotes and track the progress of their projects.",@"It is a unique numerical identifier assigned by Chemical Abstracts Service (CAS) to every chemical substance described in the open scientific literature. All CAS numbers are maintained in a CAS registry database to allow unique and convenient search options for the scientific community. Many search engines are available to locate a chemical/reagents based on its CAS number.",@"An MDL number is a unique identification number for each reaction and variation. The format is RXXXnnnnnnnn, where R indicates a reaction, XXX indicates the database containing the reaction record, and ‘nnnnnnnn’ is an 8-digit number.",@"It is a database with various structures linked to their known therapeutic usage as per literature. The structures need to be ordered and can be selected based on therapeutic area of interest.", nil];
    
    
    
    orderingAndTrackinDataArray =[[NSMutableArray alloc] initWithObjects:@"1. How can I request a quote ?",@"2. what happens once I raise a request ?",@"3. How do I submit a chemistry request ?",@"4. How do I submit a biology request ?",@"5. How many structure images can I upload for a chemisty request ?",@"6. How do I know about services offered in biology",@"7. Can I enter additional information while making a request ?",@"8. Can I place a request on phone or email ?",@"9. How do I track the statu of my request",@"10. How do I get any alerts for my request ?",@"11. How do I edit a request ?",@"12. Do I have to reener the complete details if I have not submitted a requests ?",@"13. How do I place my order ?",@"14. How do I check the status of the request ?", nil];
    
    
    
    orderingAndTrackinDataAnsArray =[[NSMutableArray alloc] initWithObjects:@"To request a quote click ‘Request/ Project Tracker’ from home page, Click on Chemistry/Biology, fill in and submit the details.",@"Chemistry Process Request – Quotation – Order Placement – Project Initiation – Synthesis – Delivery - Payment Biology Process Request – Information Sharing – Discussion – Project Initiation",@"A.	Click ‘Request/ Project Tracker’ from home screen, select ‘Chemistry’ and choose various options Upload a picture of the molecular structure or,Select a molecular structure from our ‘Reference Database’ or,Provide a ‘CAS’ number or the ‘MDL’ number of the compound and One of the above option is mandatory and more than one is accepted for accuracy.Fill and submit other details. Some details like Purity, Chirality, and UOM are mandatory while others are recommended for accuracy and quick response. ",@"Click ‘Request/ Project Tracker’ from home screen, select ‘Biology’ and then select the Service, Area, Sub-Area, and Assay/Model combination and submit the request. We will facilitate the necessary information and initiate a discussion.",@"Only one image can be uploaded. This image can either be clicked from a mobile camera, selected from gallery or chosen from the reference compound database.",@"We have listed all kinds of services by combining values from dropdown lists. You can select any service offered by us and initiate a discussion.",@"Yes, the additional information can be entered in the text space provided for remarks.",@"Yes, our executive will accept the requests on both phone and email. If you want this information to be entered in the system, an executive can do that on your behalf.",@"The request status can be tracked from ‘Request/Project Tracker’. The request will appear under the ‘Requested Quotes’ tab until you have not confirmed your order. Once the order is confirmed the request will also be available under ‘On Going Projects’ tab. We have included exhaustive status messages to keep you updated with the progress of your request.",@"Yes. We continuously update you through alerts whenever an action is taken on your request or it moves in the project lifecycle.",@"A request cannot be edited after submission. You can however send a mail to mobilesupport@gvkbio.com or call us directly to request any changes.",@"No. You can always save your request any number of times by using ‘Save for later’ option and can resume from where you left off by choosing the request from ‘Saved Requests’. Once you are satisfied with the details, you can submit the request.",@"You can either place your order by clicking on the alert sent to you or by clicking the request status ‘Acceptance’ to view the quotation details and then by clicking the ‘Place Order’ button.",@"You can go to the ‘Request/Project tracker’ to check the progress of your request. The tool shows the status of your projects by default. You need to choose the ‘Requested Quotes’ tab to locate your new requests. Once your order is confirmed, these requests are converted to projects and their status can be tracked through ‘On going Projects’ tab.", nil];
    
    
    
    DeliveryAndPaymentDataArray = [[NSMutableArray alloc] initWithObjects:@"1. How is my compound shipped ?",@"2. What are the safety measures while shipping compounds ?",@"3. How do I make a paymen ?",@"4. Can I save multiple address ?",@"5 How can add shipping address",@"6. Can I change Edit my shipping address ?", nil];

    
    
    DeliveryAndPaymentDataAnsArray = [[NSMutableArray alloc] initWithObjects:@"We ship compounds using international courier services like DHL and Fedex. We also accept shipping requests through a specific carrier if it is in the interest of our clients.",@"The ambient compounds are shipped via normal courier services while temperature sensitive compounds are shipped using the dedicated infrastructure from international courier services like DHL.",@"On shipping the compound, we send an invoice by email (a hardcopy is also posted). The payment can then be made as per the credit terms. The preferred methods for payment are wire transfer (domestic and international clients), cheque or DD (domestic clients).",@"Yes, you can store multiple addresses under ‘Shipping Information’ on ‘My Profile’ screen. At the time of placing an order you can choose the address to which the compound must be delivered. More than one shipment of same order is charged to customer.",@"Click ‘Shipping Information’ from ‘My Profile’ page and add your shipping details.",@"Yes, you can change your shipping details by going to ‘Shipping Information’ from ‘My Profile’. You can also delete a shipping address you no longer require.", nil];
    
    
    
    
    
    
    
    myAccountDataArray = [[NSMutableArray alloc] initWithObjects:@"1. How do I create my account ?",@"2. I forgot my password ?",@"3. Can I change my password ?",@"4. How to tell my friend about the app ?",@"5. How can I change my user name ?", nil];
   
    ///////////
    myAccountDataAnsArray = [[NSMutableArray alloc] initWithObjects:@"Go to the eCollab App and click ‘New User’. Enter your registration details and authenticate via the link sent by the app on your mail id. Viola! It’s done. Please check.",@"Click on ‘Forgot Password’ from the login page and enter your registered email address. An email will be sent to your to help you reset your password.",@"Yes, the password can be changed by choosing ‘Change Password’ from your profile. ",@"Share your app with your friends on either Twitter, Facebook, LinkedIn or Google Plus by choosing share from the contextual menu that pops us on clicking three horizontal bars icon.",@"No, you can only edit personal details like first name, last name, company and designation from ‘My Profile’.", nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    // If you're serving data from an array, return the length of the array:
    if (section == 0) {
        return generalDataArray.count;
    }else if (section == 1){
        return orderingAndTrackinDataArray.count;
    }else if (section == 2){
        return DeliveryAndPaymentDataArray.count;
    }else{
        return myAccountDataArray.count;
    }
//    return nil;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"FAQTableViewCellID";
    
    FAQTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[FAQTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // set the accessory view:
    //cell.accessoryType =  UITableViewCellAccessoryDetailButton;
    if (indexPath.section == 0) {
        cell.FAQLabelOutlet.text = [NSMutableString stringWithFormat:@"%@",[generalDataArray objectAtIndex:indexPath.row]];
    }else if (indexPath.section == 1){
        cell.FAQLabelOutlet.text = [NSMutableString stringWithFormat:@"%@",[orderingAndTrackinDataArray objectAtIndex:indexPath.row]];
    }else if (indexPath.section == 2){
        cell.FAQLabelOutlet.text = [NSMutableString stringWithFormat:@"%@",[DeliveryAndPaymentDataArray objectAtIndex:indexPath.row]];
    }
    else{
      cell.FAQLabelOutlet.text = [NSMutableString stringWithFormat:@"%@",[myAccountDataArray objectAtIndex:indexPath.row]];
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //put your values, this is part of my code
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50.0f)];
    [view setBackgroundColor:[UIColor lightGrayColor]];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, self.view.bounds.size.width-60, 40)];
    lbl.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:22];
    [lbl setTextAlignment:NSTextAlignmentCenter];

    //[lbl setFont:[UIFont systemFontOfSize:18]];
    [lbl setTextColor:[UIColor redColor]];
    [view addSubview:lbl];
    if (section == 0) {
        [lbl setText:[NSString stringWithFormat:@"Genenral"]];
    }else if (section == 1){
        [lbl setText:[NSString stringWithFormat:@"Ordering and Tracking"]];
    }else if (section == 2){
        [lbl setText:[NSString stringWithFormat:@"Delivery and Payment"]];
    }else{
        [lbl setText:[NSString stringWithFormat:@"My Account"]];
    }
    
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (flag == 0) {
        popviewDisplyaString = [[NSMutableString alloc] init];
        if (indexPath.section == 0) {
            popviewDisplyaString = [generalDataAnsArray objectAtIndex:indexPath.row];
            //[NSMutableString stringWithFormat:@"%@",[generalDataAnsArray objectAtIndex:indexPath.row]];
        }else if (indexPath.section == 1){
            popviewDisplyaString = [orderingAndTrackinDataAnsArray objectAtIndex:indexPath.row];
        }else if (indexPath.section == 2){
            popviewDisplyaString = [DeliveryAndPaymentDataAnsArray objectAtIndex:indexPath.row];
        }else{
            popviewDisplyaString = [myAccountDataAnsArray objectAtIndex:indexPath.row];
        }
        [self popViewWithString:popviewDisplyaString];
        flag = 1;
    }else{
        [self dismissPop:nil];
        flag = 0;
    }

}

- (IBAction)dismissPop:(id)sender {
    flag = 0;
    [[self.view viewWithTag:12345] removeFromSuperview];
}

-(void)popViewWithString:(NSMutableString*)displayString{
    popTextView = [[UITextView alloc]init];
    [popTextView setFrame:CGRectMake(0, 0, self.view.bounds.size.width-40, self.view.bounds.size.width-40)];
    popTextView.center = CGPointMake( self.view.bounds.size.width / 2, self.view.bounds.size.height / 2);
    
    [popTextView setBackgroundColor:[UIColor whiteColor]];
    popTextView.text = displayString;
    [popTextView setTextColor:[UIColor blackColor]];
    popTextView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    [popTextView setFont:[UIFont fontWithName:@"ArialMT" size:17]];
    
    
    [popTextView.layer setBorderWidth: 2.0];
    [popTextView.layer setCornerRadius:15.0f];
    [popTextView.layer setMasksToBounds:YES];
    [popTextView.layer setBorderColor:[[UIColor blackColor] CGColor]];
    
    
    popTextView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
    
    [self.view addSubview:popTextView];
    popTextView.editable = NO;
    
    [UIView animateWithDuration:0.3/1.5 animations:^{
        popTextView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3/2 animations:^{
            popTextView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3/2 animations:^{
                popTextView.transform = CGAffineTransformIdentity;
            }];
        }];
    }];
    [popTextView setTag:12345];
    
    button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self
               action:@selector(dismissPop:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"X" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 42, 42);
    button.center = CGPointMake( popTextView.bounds.size.width/2, popTextView.bounds.size.height - 21);
    [button setBackgroundColor:[UIColor redColor]];
    [button.layer setBorderWidth: 3.0];
    [button.layer setCornerRadius:18.0f];
    [popTextView addSubview:button];
    
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event  {
    NSLog(@"touches began");
    UITouch *touch = [touches anyObject];
    if(touch.view!=popTextView){
        popTextView.hidden = YES;
    }
}

@end
