//
//  ServiceManager.m
//  venue
//
//  Created by Mitesh on 06/01/16.
//  Copyright © 2016 vue. All rights reserved.
//

#import "ServiceManager.h"

@implementation ServiceManager

#pragma mark - Private Initialization

- (id)init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

#pragma mark - Default Manager

+ (ServiceManager *)sharedManager {
    static ServiceManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}


-(void)callWebServiceWithGET:(NSString *)webpath withTag:(NSString *)tagname params:(NSDictionary *)params{
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    [manager GET:webpath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Response : %@",[responseObject description]);
        NSLog(@"success!");
        
        [_delegate webServiceCallSuccess:responseObject forTag:tagname];

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error: %@", error);
        [_delegate webServiceCallFailure:error forTag:tagname];

        
    }];
    
    
}


-(void)callWebServiceWithPOST:(NSString *)webpath withTag:(NSString *)tagname params:(NSDictionary *)params{
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];

    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    
    [manager POST:webpath parameters:params
         progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"Response : %@",[responseObject description]);
             NSLog(@"success!");
             
             [_delegate webServiceCallSuccess:responseObject forTag:tagname];
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"error: %@", error);
             
             [_delegate webServiceCallFailure:error forTag:tagname];
             
    }];
    
    
}

-(void)callWebServiceWithGETWithCustomHeader:(NSString *)webpath withTag:(NSString *)tagname params:(NSDictionary *)params withSecretKey:(NSString *)accessToken{
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:accessToken forHTTPHeaderField:@"X-AccessToken"];
    
    [manager GET:webpath parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"Response : %@",[responseObject description]);
        NSLog(@"success!");
        
        [_delegate webServiceCallSuccess:responseObject forTag:tagname];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error: %@", error);
        
        [_delegate webServiceCallFailure:error forTag:tagname];

        
    }];
    
}

-(void)callWebServiceWithPOSTWithCustomHeader:(NSString *)webpath withTag:(NSString *)tagname params:(NSDictionary *)params withSecretKey:(NSString *)accessToken{
    
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:accessToken forHTTPHeaderField:@"X-AccessToken"];
    
    [manager POST:webpath parameters:params
         progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             
             NSLog(@"Response : %@",[responseObject description]);
             NSLog(@"success!");
             
             [_delegate webServiceCallSuccess:responseObject forTag:tagname];
             
             
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             
             NSLog(@"error: %@", error);
             
             [_delegate webServiceCallFailure:error forTag:tagname];
             
         }];
    
    
}

-(void)callWebServiceWithPOST:(NSString *)webpath withTag:(NSString *)tagname params:(NSArray *)params imgArray:(NSMutableArray *)arrImages{
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    for(NSDictionary *currentDic in params){
        [parameters addEntriesFromDictionary:currentDic];
    }
    
    NSLog(@"\n%@", webpath);
    NSLog(@"%@\n", parameters);
    
    NSMutableURLRequest *request  = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:webpath parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
       
        
        for(int i = 0; i < [arrImages count]; i++){
            
            /* AttachmentViewModel *attachmentModel = arrImages[i];
             UIImage *img = attachmentModel.Image;
             NSData *imgData = [self CompressImage:img];
             //NSString *name = attachmentModel.ImageFileName;
             NSString *name = @"Profile_pic";*/
            
            UIImage *img = arrImages[i];
            NSData *imgData = UIImageJPEGRepresentation(img, 0.5);
            NSInteger imageSize   = imgData.length;
            NSLog(@"SIZE OF IMAGE: %.2f Mb", (float)imageSize/1024/1024);
            
            
            UIImage *compressedImage = [UIImage imageWithData:imgData];
            [formData appendPartWithFileData:UIImagePNGRepresentation(compressedImage) name:@"file" fileName:@"profile_pic.png" mimeType:@"image/png"];
            
            
            // [formData appendPartWithFileData:imgData name:name/*@"uploadedfile"*/ fileName:name mimeType:@"image/png"];
            
        }
        
        NSLog(@"%@", formData);
        
    } error:nil];
    
 
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [request setValue:@"va2f40cc914983764463b4477ac33e" forHTTPHeaderField:@"Apz-AppId"];
    [request setValue:@"Basic dmFAZWJpenppbmZvdGVjaC5jb206MTIzNDU2Nzg=" forHTTPHeaderField:@"Apz-Token"];
    [request setValue:@"application/json" forHTTPHeaderField:@"accept"];
    
    NSURLSessionUploadTask *uploadTask = [manager
                                          uploadTaskWithStreamedRequest:request
                                          progress:^(NSProgress * _Nonnull uploadProgress) {
                                              
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  //Update the progress view
                                                  NSLog(@"Completed : %f", uploadProgress.fractionCompleted);
                                              });
                                          }
                                          completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                              if (error) {
                                                  if ([self.delegate respondsToSelector:@selector(webServiceCallFailure:forTag:)]) {
                                                      [self.delegate webServiceCallFailure:error forTag:tagname];
                                                  }
                                              } else {
                                                  NSError *err;
                                                  id responseFromServer = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
                                                  if(err){
                                                      NSLog(@"Error : %@", err.localizedDescription);
                                                      NSString *strResponse = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                                                      NSLog(@"Response : %@", strResponse);
                                                  }
                                                  [self.delegate webServiceCallSuccess:responseFromServer forTag:tagname];
                                              }
                                              
                                          }];
    
    [uploadTask resume];
}



@end
