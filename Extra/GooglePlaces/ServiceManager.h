//
//  ServiceManager.h
//  venue
//
//  Created by Mitesh on 06/01/16.
//  Copyright © 2016 vue. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ServiceManagerDelegate <NSObject>

-(void)webServiceCallSuccess:(id)response forTag:(NSString *)tagname;
-(void)webServiceCallFailure:(NSError *)error forTag:(NSString *)tagname;

@end

@interface ServiceManager : NSObject

@property (nonatomic, weak) id<ServiceManagerDelegate> delegate;
+ (ServiceManager *)sharedManager;


-(void)callWebServiceWithGET:(NSString *)webpath withTag:(NSString *)tagname params:(NSDictionary *)params;

-(void)callWebServiceWithPOST:(NSString *)webpath withTag:(NSString *)tagname params:(NSDictionary *)params;

-(void)callWebServiceWithGETWithCustomHeader:(NSString *)webpath withTag:(NSString *)tagname params:(NSDictionary *)params withSecretKey:(NSString *)accessToken;

-(void)callWebServiceWithPOSTWithCustomHeader:(NSString *)webpath withTag:(NSString *)tagname params:(NSDictionary *)params withSecretKey:(NSString *)accessToken;
-(void)callWebServiceWithPOST:(NSString *)webpath withTag:(NSString *)tagname params:(NSArray *)params imgArray:(NSMutableArray *)arrImages;



@end
