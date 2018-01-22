//
//  NetworkRequest.m
//  NJMusic
//
//  Created by njw on 2017/12/19.
//  Copyright © 2017年 njw. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest

static NetworkRequest *_networkRequest;

+ (instancetype)shareRequest
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_networkRequest == nil) {
            _networkRequest = [[super alloc] init];
        }
    });
    return _networkRequest;
}

- (void)requestWithModel:(NetworkRequestType)requestType withUrl:(NSString *)url withParam:(id)param success:(void (^)(id))success failure:(void (^)(id))failure
{
    if (requestType == NetworkRequestTypePost) {
        [self postRequestWithUrl:url withParam:param success:^(id result) {
            success(result);
        } failure:^(id error) {
            failure(error);
        }];
    }
    else if (requestType == NetworkRequestTypeGet) {
        [self getRequestWithUrl:url withParam:param success:^(id result) {
            success(result);
        } failure:^(id error) {
            failure(error);
        }];
    }
}

- (void)postRequestWithUrl:(NSString *)url withParam:(id)param success:(void (^)(id))success failure:(void (^)(id))failure {
    // 创建管理者对象
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    [sessionManager POST:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"进度");
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"请求成功");
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败");
        failure(error);
    }];
}

- (void)getRequestWithUrl:(NSString *)url withParam:(id)param success:(void (^)(id))success failure:(void (^)(id))failure {
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
 
    // 超时时间
    sessionManager.requestSerializer.timeoutInterval = 30;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    //    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
    
    // 声明获取到的数据格式
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
    //    manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    [sessionManager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
//        NSLog(@"进度");
        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString *result = [self strAnalysisyWithString:[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]];
        NSDictionary *dict = [result objectFromJSONString];
        success(dict);
//        NSLog(@"请求成功");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
//        NSLog(@"请求失败");
    }];
}

-(NSString*)strAnalysisyWithString:(NSString *)str{
    NSString *st=[str substringFromIndex:9];
    NSRange r=[st rangeOfString:@"("];
    NSString *str1=[st substringFromIndex:r.location+1];
    NSString *subString=[str1 substringToIndex:str1.length-2];
    return subString;
}

- (void)downLoadWithUrlString:(NSString *)urlString
{
    // 1.创建管理者对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2.设置请求的URL地址
    NSURL *url = [NSURL URLWithString:urlString];
    // 3.创建请求对象
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 4.下载任务
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 下载进度
        NSLog(@"当前下载进度为:%lf", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // 下载地址
        NSLog(@"默认下载地址%@",targetPath);
        // 设置下载路径,通过沙盒获取缓存地址,最后返回NSURL对象
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
        return nil;
        return [NSURL fileURLWithPath:filePath]; // 返回的是文件存放在本地沙盒的地址
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // 下载完成调用的方法
        NSLog(@"%@---%@", response, filePath);
    }];
    // 5.启动下载任务
    [task resume];
}

- (void)requestTestWithModel:(NetworkRequestType)requestType withUrl:(NSString *)url withParam:(id)param success:(void (^)(id))success failure:(void (^)(id))failure {
    // 创建管理者对象
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    switch (requestType) {
        case NetworkRequestTypeGet: {
            [sessionManager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"进度");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"请求成功");
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败");
                failure(error);
            }];
        }
            break;
            
        case NetworkRequestTypePost: {
            [sessionManager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"请求成功");
                success(responseObject);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSLog(@"请求失败");
                failure(error);
            }];
        }
            break;
            
        default:
            break;
    }
}

@end
