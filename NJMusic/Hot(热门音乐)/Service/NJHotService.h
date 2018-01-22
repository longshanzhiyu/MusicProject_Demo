//
//  NJHotService.h
//  NJMusic
//
//  Created by njw on 2017/12/19.
//  Copyright © 2017年 njw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJHotService : NSObject
+ (void)getHotDataFromNetWithModel:(NetworkRequestType)requestType withUrl:(NSString *)url withParam:(id)param success:(void (^)(id))success failure:(void (^)(id))failure;
@end
