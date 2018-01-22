//
//  NJSystemManager.m
//  NJMusic
//
//  Created by njw on 2017/12/18.
//  Copyright © 2017年 njw. All rights reserved.
//

#import "NJSystemManager.h"

@implementation NJSystemManager

static NJSystemManager *_systemManager;

+ (instancetype)shareManger
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_systemManager == nil) {
            _systemManager = [[super alloc] init];
        }
    });
    return _systemManager;
}

- (id)cheakTabbarSettingFromSource:(NSString *)source {
    NSMutableDictionary *info = [[NSMutableDictionary alloc] initWithContentsOfFile:source];  ;
    NSArray *settings = [info objectForKey:@"TabBar"];
    return settings;
}

- (id)createTabbarWithSettings:(id)setting {
    
    NJMainTabBarController *mainTab = [[NJMainTabBarController alloc] init];
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    for (NSDictionary *set in setting) {
        NSString *clsStr = [set objectForKey:@"className"];
        Class cls = NSClassFromString(clsStr);
        NJRootViewController *rootvc = [[cls alloc] init];
        NJRootNavViewController *rootNav = [[NJRootNavViewController alloc] initWithRootViewController:rootvc];
        rootvc.title = [set objectForKey:@"titleName"];
        NSString *imageName = [set objectForKey:@"imageNormal"];
        rootNav.tabBarItem.image = [UIImage imageNamed:imageName];
        [temp addObject:rootNav];
    }
    mainTab.viewControllers = temp;
    
    return mainTab;
}

@end
