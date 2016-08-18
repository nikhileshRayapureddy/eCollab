
#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "ServiceInterface.h"
#import "DetailsManager.h"

@protocol ServiceRequesterProtocol;


@interface ServiceRequester : NSObject
{
    id <ServiceRequesterProtocol> serviceRequesterDelegate;
}

@property (strong) id <ServiceRequesterProtocol> serviceRequesterDelegate;
@property (nonatomic, retain) NSMutableArray *serviceStack;
@property (nonatomic, strong) NSNotificationQueue *notificationQ;
- (ServiceRequester*)init;

#pragma mark - ServiceRequesterMethods

-(void)requestForLoginService:(NSDictionary *)dict;
-(void)requestForopCreatedUserService:(NSMutableDictionary *)detailDictionary;
-(void)requestForopForgotPassword:(NSString *)email;
//opCreateChemistryRequest
-(void)requestForopCreateChemistryRequestService:(NSDictionary *)dict;
//opGetUserDetails
-(void)requestForopGetUserDetailsService;
//opSaveUserDetails
-(void)requestForopSaveUserDetailsService:(NSMutableDictionary *)detailDictionary;
//opChangePassword
-(void)requestForopChangePasswordService:(NSMutableDictionary *)detailDictionary;
//opInsertShippingAddressDetails
-(void)requestForopInsertShippingAddressDetailsService:(NSMutableDictionary *)detailDictionary;
////opSaveUserRatings
-(void)requestForopSaveUserRatingsService:(NSMutableDictionary *)detailDictionary;
//opLoadMaster
-(void)requestForopLoadMasterService;
//opSavedOrdersList
-(void)requestForopSavedOrdersListService;
//opUserAlertsOrNotifications
-(void)requestFopUserAlertsOrNotificationsService;
//opGetProjectTrackerDetails
-(void)requestFopGetProjectTrackerDetailsService;
//opImagesOnTherapiticArea
-(void)requestForopImagesOnTherapiticAreaService:(NSString *)therapiticidString;
//opGetDependencyDetails
-(void)requestForopGetDependencyDetailsService:(NSMutableDictionary *)detailDictionary;
//opInsertBiologyRequest
-(void)requestForopInsertBiologyRequestService:(NSMutableDictionary *)detailDictionary;
//opTrackSelecctedOrderDetails
-(void)requestForopTrackSelecctedOrderDetailsService:(NSMutableDictionary *)detailDictionary;
//opRequestedQuoteDetails
-(void)requestForopRequestedQuoteDetailsService:(NSMutableDictionary *)detailDictionary;
//opPlaceChemistryRequest
-(void)requestForopPlaceChemistryRequestService:(NSMutableDictionary *)detailDictionary;
-(void)requestForopUpdateBiologyRequestService:(NSMutableDictionary *)detailDictionary;
@end

#pragma mark - ServiceRequesterProtocol
@protocol ServiceRequesterProtocol <NSObject>
@optional

-(void)requestReceivedLoginResponce:(NSMutableDictionary *)aregistrationDict;
-(void)requestReceivedopCreatedUserResponce:(NSMutableDictionary *)aregistrationDict;
-(void)requestReceivedopForgotPasswordResponce:(NSMutableDictionary *)aregistrationDict;
-(void)requestReceivedopCreateChemistryRequestResponce:(NSMutableDictionary *)aregistrationDict;
-(void)requestReceivedopGetUserDetailsResponce:(NSMutableDictionary *)aregistrationDict;
//opSaveUserDetails
-(void)requestReceivedopSaveUserDetailsResponce:(NSMutableDictionary *)aregistrationDict;
//opChangePassword
-(void)requestReceivedopChangePasswordResponce:(NSMutableDictionary *)aregistrationDict;
//opInsertShippingAddressDetails
-(void)requestReceivedopInsertShippingAddressDetailsResponce:(NSMutableDictionary *)aregistrationDict;
//opSaveUserRatings
-(void)requestReceivedopSaveUserRatingsResponce:(NSMutableDictionary *)aregistrationDict;
//opLoadMaster
-(void)requestReceivedopLoadMasterResponce:(NSMutableDictionary *)aregistrationDict;
//opSavedOrdersList
-(void)requestReceivedopSavedOrdersListResponce:(NSMutableDictionary *)aregistrationDict;
//opUserAlertsOrNotifications
-(void)requestReceivedopUserAlertsOrNotificationsResponce:(NSMutableDictionary *)aregistrationDict;
//opGetProjectTrackerDetails
-(void)requestReceivedopGetProjectTrackerDetailsResponce:(NSMutableDictionary *)aregistrationDict;
////opImagesOnTherapiticArea
-(void)requestReceivedopImagesOnTherapiticAreaResponce:(NSMutableDictionary *)aregistrationDict;
//opGetDependencyDetails
-(void)requestReceivedopGetDependencyDetailsResponce:(NSMutableDictionary *)aregistrationDict;
//opInsertBiologyRequest
-(void)requestReceivedopInsertBiologyRequestResponce:(NSMutableDictionary *)aregistrationDict;
//opTrackSelecctedOrderDetails
-(void)requestReceivedopTrackSelecctedOrderDetailsResponce:(NSMutableDictionary *)aregistrationDict;
//opRequestedQuoteDetails
-(void)requestReceivedopRequestedQuoteDetailsResponce:(NSMutableDictionary *)aregistrationDict;
//opPlaceChemistryRequest
-(void)requestReceivedopPlaceChemistryRequestResponce:(NSMutableDictionary *)aregistrationDict;
@end
