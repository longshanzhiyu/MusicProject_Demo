//
//  NJMyMusicController.m
//  NJMusic
//
//  Created by njw on 2017/12/18.
//  Copyright © 2017年 njw. All rights reserved.
//

#import "NJMyMusicController.h"

@interface NJMyMusicController ()

@end

@implementation NJMyMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)download:(UIButton *)sender {
    [[NetworkRequest shareRequest] downLoadWithUrlString:@"http://localhost/bravesayno.mp3"];
}

- (IBAction)testclicked:(UIButton *)sender {
    
//    [[NetworkRequest shareRequest] requestTestWithModel:NetworkRequestTypeGet withUrl:@"http://localhost/" withParam:nil success:^(id result) {
//
//    } failure:^(id error) {
//
//    }];
//    [[NetworkRequest shareRequest] requestTestWithModel:NetworkRequestTypePost withUrl:@"http://localhost/test_post.php" withParam:@{@"page":@"1"} success:^(id result) {
//
//    } failure:^(id error) {
//
//    }];
    
    [[NetworkRequest shareRequest] requestTestWithModel:NetworkRequestTypeGet withUrl:@"http://localhost:8088/test_mysql" withParam:nil success:^(id result) {
        for (NSDictionary *d in result) {
            NSString *str = [d objectForKey:@"name"];
            NSLog(@"str: %@  %@", str, [self replaceUnicode:str]);
        }
    } failure:^(id error) {
        
    }];
}
    
- (NSString *)replaceUnicode:(NSString *)unicodeStr {
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
//    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
//                                                           mutabilityOption:NSPropertyListImmutable
//                                                                     format:NULL
//                                                           errorDescription:NULL];
    NSString * returnStr = [NSPropertyListSerialization propertyListWithData:tempData options:NSPropertyListImmutable format:NULL error:NULL];
    
    NSLog(@"Output = %@", returnStr);
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"];
}

@end
