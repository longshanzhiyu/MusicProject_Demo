//
//  NJSystemManager.h
//  NJMusic
//
//  Created by njw on 2017/12/18.
//  Copyright © 2017年 njw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NJSystemManager : NSObject
+ (instancetype)shareManger;
- (id)createTabbarWithSettings:(id)setting;
- (id)cheakTabbarSettingFromSource:(NSString *)source;
@end
