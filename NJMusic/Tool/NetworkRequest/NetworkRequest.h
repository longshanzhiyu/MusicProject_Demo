//
//  NetworkRequest.h
//  NJMusic
//
//  Created by njw on 2017/12/19.
//  Copyright © 2017年 njw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NetworkRequestTypeGet,
    NetworkRequestTypePost,
} NetworkRequestType;

@interface NetworkRequest : NSObject
+ (instancetype)shareRequest;
- (void)requestWithModel:(NetworkRequestType)requestType withUrl:(NSString *)url withParam:(id)param success:(void (^)(id))success failure:(void (^)(id))failure;
- (void)downLoadWithUrlString:(NSString *)urlString;

- (void)requestTestWithModel:(NetworkRequestType)requestType withUrl:(NSString *)url withParam:(id)param success:(void (^)(id))success failure:(void (^)(id))failure;
@end
