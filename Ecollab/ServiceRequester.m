

#import "ServiceRequester.h"
#define kApplicationBaseURL [[NSBundle mainBundle] objectForInfoDictionaryKey:@"ApplicationBaseURL"]
//NSString *const kBase_URL = @"http://183.82.107.118:55666/eCollab/GvkWCF.svc";
NSString *const kBase_URL = @"http://ecollab.gvkbio.com/GvkWCF.svc";

//NSString *const kBase_URLWithHttps = @"https://115.119.121.188:8081/MobileService/services";
NSString *const kBase_Content_Type = @"application/json; charset=utf-8";

@implementation ServiceRequester
@synthesize serviceRequesterDelegate;

#pragma mark - ServiceStack
-(void)addServiceInterfaceToServiceStack:(ServiceInterface *)sInterface{
    if(!self.serviceStack){
        _serviceStack = [[NSMutableArray alloc]init];
    }
    [_serviceStack addObject:sInterface];
}

#pragma mark - Init
- (ServiceRequester*)init
{
   self = [super init];
    self.notificationQ = [[NSNotificationQueue alloc]initWithNotificationCenter:[NSNotificationCenter defaultCenter]];
    return self;
}
- (void)addToErrorQueue:(int)code
{
    if([_serviceStack count]>0){
        [_serviceStack removeAllObjects];
    }
}
#pragma mark - ServiceRequesterMethods

// REQUEST FOR LOGIN SREVICE
-(void)requestForLoginService:(NSDictionary *)detailDictionary
{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseLoginService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opLogin"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:detailDictionary options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    //or startWithURL is also working
    //[service startWithURL:url];
    service = nil;
    detailDictionary = nil;
}
// REQUEST FOR NEW USER SREVICE

-(void)requestForopCreatedUserService:(NSMutableDictionary *)detailDictionary{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseNewUserService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opCreatedUser"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:detailDictionary options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    service = nil;
    detailDictionary = nil;

}

-(void)requestForopForgotPassword:(NSString *)email
{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseForgotPasswordService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opForgotPassword?emailid=%@",email]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    //or startWithURL is also working
    //[service startWithURL:url];
    service = nil;
}

//opCreateChemistryRequest
-(void)requestForopCreateChemistryRequestService:(NSDictionary *)dict{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    if ([[dict valueForKey:@"ISSubmit"] isEqualToString:@"0"])
    {
        service.theSuccessMethod = @selector(responseopSaveChemistryRequestService:);
    }
    else
    {
        service.theSuccessMethod = @selector(responseopCreateChemistryRequestService:);
    }
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opCreateChemistryRequest"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    service = nil;
}

-(void)requestForopUpdateChemistryRequestService:(NSDictionary *)dict{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    if ([[dict valueForKey:@"ISSubmit"] isEqualToString:@"0"])
    {
        service.theSuccessMethod = @selector(responseopSaveChemistryRequestService:);
    }
    else
    {
        service.theSuccessMethod = @selector(responseopSaveChemistryRequestService:);
    }
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opUpdateChemistryRequest"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    service = nil;
}

-(void)requestForopUpdateProfileImage:(NSDictionary *)dict{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopUploadProfileImage:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/imageupload"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    service = nil;
}

//opGetUserDetails
-(void)requestForopGetUserDetailsService{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopGetUserDetailsService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    //[[DetailsManager sharedManager]auth_token]
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opGetUserDetails?rid=%@&ismobileuser=0&isgvkemployee=0",[[DetailsManager sharedManager] rID]]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    //or startWithURL is also working
    //[service startWithURL:url];
    service = nil;
}
//opSaveUserDetails
-(void)requestForopSaveUserDetailsService:(NSMutableDictionary *)detailDictionary{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopSaveUserDetailsService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opSaveUserDetails"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:detailDictionary options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    service = nil;
    detailDictionary = nil;
}

//opChangePassword
-(void)requestForopChangePasswordService:(NSMutableDictionary *)detailDictionary{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopChangePasswordService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opChangePassword"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:detailDictionary options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    service = nil;
    detailDictionary = nil;
}
//opInsertShippingAddressDetails
-(void)requestForopInsertShippingAddressDetailsService:(NSMutableDictionary *)detailDictionary{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopInsertShippingAddressDetailsService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opInsertShippingAddressDetails"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:detailDictionary options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    service = nil;
    detailDictionary = nil;
}
//opInsertShippingAddressDetails
-(void)requestForopUpdateShippingAddressDetailsService:(NSMutableDictionary *)detailDictionary{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopUpdateShippingAddressDetailsService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opUpdateShippingAddressDetails"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:detailDictionary options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    service = nil;
    detailDictionary = nil;
}

//opGetUserAddressDetails
-(void)requestForopGetShippingAddressDetailsService{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopGetUserAddressListService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opGetUserAddressDetails?UID=%@",[[DetailsManager sharedManager] rID]]];
    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;
}
//opSaveUserRatings
-(void)requestForopSaveUserRatingsService:(NSMutableDictionary *)detailDictionary{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopSaveUserRatingsService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opSaveUserRatings"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:detailDictionary options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    service = nil;
    detailDictionary = nil;

}
//opLoadMaster
-(void)requestForopLoadMasterService{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopLoadMasterService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opLoadMaster"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;
}
//opSavedOrdersList
-(void)requestForopSavedOrdersListService{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopSavedOrdersListService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opSavedOrdersList?UID=%@",[[DetailsManager sharedManager] rID]]];
    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;
}
//opUserAlertsOrNotifications
-(void)requestFopUserAlertsOrNotificationsService{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopUserAlertsOrNotificationsService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opUserAlertsOrNotifications?UID=%@",[[DetailsManager sharedManager] rID]]];
    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;
}

-(void)requestFopUserAlertsOrNotificationsServiceForSideMenu{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopUserAlertsOrNotificationsServiceForSideMenu:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opUserAlertsOrNotifications?UID=%@",[[DetailsManager sharedManager] rID]]];
    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;
}

-(void)getAddressForPinCode:(NSString *)strPinCode{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseGetAddressForPinCode:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [NSString stringWithFormat:@"http://www.whizapi.com/api/v2/util/ui/in/indian-city-by-postal-code?AppKey=lqabadiabeg7hndxg63r5xk7&pin=%@",strPinCode];
    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;
    
}


//opGetProjectTrackerDetails
-(void)requestFopGetProjectTrackerDetailsService{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopGetProjectTrackerDetailsService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opGetProjectTrackerDetails?uid=%@",[[DetailsManager sharedManager] rID]]];
    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;

}
//opImagesOnTherapiticArea
-(void)requestForopImagesOnTherapiticAreaService:(NSString *)therapiticidString{
    //responseopImagesOnTherapiticAreaService
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopImagesOnTherapiticAreaService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opImagesOnTherapiticArea?therapiticid=%@",therapiticidString]];
    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;

}
//opGetDependencyDetails
-(void)requestForopGetDependencyDetailsService:(NSMutableDictionary *)detailDictionary{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopGetDependencyDetailsService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opGetDependencyDetails"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:detailDictionary options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    service = nil;
    detailDictionary = nil;

    
}
-(void)sendAlertViewedToServerWithRID:(NSString*)strRID{
    //http://183.82.107.118:55666/eCollab/GvkWCF.svc/opGetUserNotified?uid=2&rid=286976&isviewed=1

    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopUserAlertsOrNotificationsService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opGetUserNotified?uid=%@&rid=%@&isviewed=1",[[DetailsManager sharedManager] rID],strRID]];
    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;
}

-(void)AlertViewedResponse:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopUserAlertsViewed:jsonDict];
    // alert =  nil;
}


//opInsertBiologyRequest
-(void)requestForopInsertBiologyRequestService:(NSMutableDictionary *)detailDictionary{
        ServiceInterface *service = [[ServiceInterface alloc] init];
        service.theDelegate = self;
        service.theSuccessMethod = @selector(responseopInsertBiologyRequestService:);
        service.theFailureMethod = @selector(requestFailedWithError:);
        [self addServiceInterfaceToServiceStack:service];
        NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opInsertBiologyRequest"]];
        NSURL* url = [NSURL URLWithString:stringURL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:detailDictionary options:NSJSONWritingPrettyPrinted error:nil];
        request.HTTPBody = requestBodyData;
        request.HTTPMethod = @"POST";
        [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
        
        NSLog(@"request  %@",request);
        [service startWithRequest:request];
        service = nil;
        detailDictionary = nil;
        

}

//opInsertBiologyRequest
-(void)requestForopUpdateBiologyRequestService:(NSMutableDictionary *)detailDictionary{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopInsertBiologyRequestService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opUpdateBiologyRequest"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:detailDictionary options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    service = nil;
    detailDictionary = nil;
    
    
}

//opTrackSelecctedOrderDetails
-(void)requestForopTrackSelecctedOrderDetailsService:(NSMutableDictionary *)detailDictionary{
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopTrackSelecctedOrderDetailsService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opTrackSelecctedOrderDetails?uid=%@&orderid=%@&ordertype=%@",[[DetailsManager sharedManager] rID],[detailDictionary objectForKey:@"orderid"],[detailDictionary objectForKey:@"ordertype"]]];
    // NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opTrackSelecctedOrderDetails?&orderid=%@&ordertype=%@",[detailDictionary objectForKey:@"orderid"],[detailDictionary objectForKey:@"ordertype"]]];

    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;
}
//opRequestedQuoteDetails
-(void)requestForopRequestedQuoteDetailsService:(NSMutableDictionary *)detailDictionary{
    //responseopRequestedQuoteDetailsService
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopRequestedQuoteDetailsService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opRequestedQuoteDetails?RID=%@&Type=%@",[detailDictionary objectForKey:@"RID"],[detailDictionary objectForKey:@"Type"]]];
    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;
}

-(void)requestForopDeleteRequest:(NSMutableDictionary *)detailDictionary{
    //responseopRequestedQuoteDetailsService
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopDeleteReqestService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL = @"";
    if(detailDictionary.allKeys.count == 3)
    {
        stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opDeleteRequest?uid=%@&RID=%@&Type=%@",[detailDictionary objectForKey:@"uid"],[detailDictionary objectForKey:@"rid"],[detailDictionary objectForKey:@"Type"]]];
    }
    else
    {
        stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opDeleteUserAddress?uid=%@&addressid=%@",[[DetailsManager sharedManager]rID],[detailDictionary objectForKey:@"ADDRESSID"]]];
    }
    NSURL* url = [NSURL URLWithString:stringURL];
    [service startWithURL:url];
    service = nil;
}

//opPlaceChemistryRequest
-(void)requestForopPlaceChemistryRequestService:(NSMutableDictionary *)detailDictionary{
    //responseopPlaceChemistryRequestService
    
    /*
     /opPlaceChemistryRequest
     
     (Chemistry Placer Order)
     RID : Req ID
     Type : 0
     RejectedComments : ""
     AddressID : Address ID from Address list
     (/opGetUserAddressDetails?uid={uid}) uid = Login user id

     */
    ServiceInterface *service = [[ServiceInterface alloc] init];
    service.theDelegate = self;
    service.theSuccessMethod = @selector(responseopPlaceChemistryRequestService:);
    service.theFailureMethod = @selector(requestFailedWithError:);
    [self addServiceInterfaceToServiceStack:service];
    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opPlaceChemistryRequest"]];
    NSURL* url = [NSURL URLWithString:stringURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *requestBodyData = [NSJSONSerialization dataWithJSONObject:detailDictionary options:NSJSONWritingPrettyPrinted error:nil];
    request.HTTPBody = requestBodyData;
    request.HTTPMethod = @"POST";
    [request setValue:kBase_Content_Type forHTTPHeaderField:@"Content-Type"];
    
    NSLog(@"request  %@",request);
    [service startWithRequest:request];
    //or startWithURL is also working
    //[service startWithURL:url];
    service = nil;
    detailDictionary = nil;
    
//    NSString* stringURL    = [kBase_URL stringByAppendingString:[NSString stringWithFormat:@"/opPlaceChemistryRequest?RID=%@&Type=%@&RejectedComments=%@&AddressID=%@",[detailDictionary objectForKey:@"RID"],[detailDictionary objectForKey:@"Type"],[detailDictionary objectForKey:@"RejectedComments"],[detailDictionary objectForKey:@"AddressID"]]];
//    NSURL* url = [NSURL URLWithString:stringURL];
//    [service startWithURL:url];
//    service = nil;
}
#pragma mark - ServiceResponceMethods
-(void)requestFailedWithError:(NSString *)errorMessage{
    
//    //[alert dismissWithClickedButtonIndex:0 animated:YES];
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection Error" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    [alertView show];
//    alert = nil;
    
}
#pragma mark - service Success Methods

//  Response Received for login service 
-(void)responseLoginService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
     NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedLoginResponce:jsonDict];
   // alert =  nil;
}
//  Response Received for new user service
-(void)responseNewUserService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopCreatedUserResponce:jsonDict];
    // alert =  nil;
}
-(void)responseForgotPasswordService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopForgotPasswordResponce:jsonDict];
    // alert =  nil;
}
//opCreateChemistryRequest

-(void)responseopCreateChemistryRequestService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopCreateChemistryRequestResponce:jsonDict];
    // alert =  nil;
}
-(void)responseopSaveChemistryRequestService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopSaveChemistryRequestResponce:jsonDict];
    // alert =  nil;
}

-(void)responseopUploadProfileImage:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopProfileImageUploadRequestResponse:jsonDict];
    // alert =  nil;
}



//opGetUserDetails

-(void)responseopGetUserDetailsService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopGetUserDetailsResponce:jsonDict];
    // alert =  nil;
}
//opSaveUserDetails
-(void)responseopSaveUserDetailsService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopSaveUserDetailsResponce:jsonDict];
    // alert =  nil;
}
//opChangePassword
-(void)responseopChangePasswordService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopChangePasswordResponce:jsonDict];
    // alert =  nil;
}
//opInsertShippingAddressDetails
-(void)responseopInsertShippingAddressDetailsService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopInsertShippingAddressDetailsResponce:jsonDict];
    // alert =  nil;
}
-(void)responseopUpdateShippingAddressDetailsService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopUpdateShippingAddressDetailsResponce:jsonDict];
    // alert =  nil;
}
//opSaveUserRatings
-(void)responseopSaveUserRatingsService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopSaveUserRatingsResponce:jsonDict];
    // alert =  nil;
}
//opLoadMaster
-(void)responseopLoadMasterService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopLoadMasterResponce:jsonDict];
    // alert =  nil;
}
//opSavedOrdersList
-(void)responseopSavedOrdersListService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopSavedOrdersListResponce:jsonDict];
    // alert =  nil;
}
////opUserAlertsOrNotifications
-(void)responseopUserAlertsOrNotificationsService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopUserAlertsOrNotificationsResponce:jsonDict];
    // alert =  nil;
}

-(void)responseopUserAlertsOrNotificationsServiceForSideMenu:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopUserAlertsOrNotificationsForSideMenuResponce:jsonDict];
    // alert =  nil;
}

//opGetProjectTrackerDetails
-(void)responseopGetProjectTrackerDetailsService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopGetProjectTrackerDetailsResponce:jsonDict];
    // alert =  nil;
}

-(void)responseGetAddressForPinCode:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedGetAddressFromPinCodeRequestResponse:jsonDict];
    // alert =  nil;
}
//opImagesOnTherapiticArea
-(void)responseopImagesOnTherapiticAreaService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopImagesOnTherapiticAreaResponce:jsonDict];
    // alert =  nil;
}
//opGetDependencyDetails
-(void)responseopGetDependencyDetailsService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopGetDependencyDetailsResponce:jsonDict];
    // alert =  nil;
}
//opInsertBiologyRequest
-(void)responseopInsertBiologyRequestService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopInsertBiologyRequestResponce:jsonDict];
    // alert =  nil;
}
//opTrackSelecctedOrderDetails
-(void)responseopTrackSelecctedOrderDetailsService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopTrackSelecctedOrderDetailsResponce:jsonDict];
    // alert =  nil;
}

-(void)responseopDeleteReqestService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopDeleteReqestResponce:jsonDict];
    // alert =  nil;
}


//opRequestedQuoteDetails
-(void)responseopRequestedQuoteDetailsService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopRequestedQuoteDetailsResponce:jsonDict];
    // alert =  nil;
}
//opPlaceChemistryRequest
-(void)responseopPlaceChemistryRequestService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopPlaceChemistryRequestResponce:jsonDict];
    // alert =  nil;
}
-(void)responseopGetUserAddressListService:(NSData *)data
{
    //[alert dismissWithClickedButtonIndex:0 animated:YES];
    NSError *e = nil;
    NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    NSLog(@"Parsed JSON Data: %@", jsonDict);
    [serviceRequesterDelegate requestReceivedopGetUserAddressListRequestResponce:jsonDict];
    // alert =  nil;
}


@end
