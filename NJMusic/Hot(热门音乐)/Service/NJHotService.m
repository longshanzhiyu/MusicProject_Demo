//
//  NJHotService.m
//  NJMusic
//
//  Created by njw on 2017/12/19.
//  Copyright © 2017年 njw. All rights reserved.
//

#import "NJHotService.h"

@implementation NJHotService
+ (void)getHotDataFromNetWithModel:(NetworkRequestType)requestType withUrl:(NSString *)url withParam:(id)param success:(void (^)(id))success failure:(void (^)(id))failure
{
    [[NetworkRequest shareRequest] requestWithModel:requestType withUrl:url withParam:param success:^(id result) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in [result objectForKey:@"songs"]) {
            HotModel *model=[[HotModel alloc]init];
            for (NSString *key in dic) {
                [model setValue:dic[key] forKey:key];
            }
            [dataArray addObject:model];
        }
        success(dataArray);
    } failure:^(id error) {
        failure(error);
    }];
}
@end
