//
//  HotModel.h
//  PTMusic
//
//  Created by qianfeng on 14-6-17.
//  Copyright (c) 2014年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PlayInfor :NSObject

@property NSString * title;
@property NSString *id;
@property NSString *name;

//songs内容
@property NSString * artist;
@property NSString * artist_id;
@property NSString * count;
@property NSString * length;
@property NSString * picture ;
@property NSString * src;
@property int  widget_id;
@end


@interface Playlist : NSObject

@property NSString *artist_id;
@property NSString *artist_name;
@property PlayInfor *playlist;
@property NSArray *songs;
@end

@interface HotModel : NSObject
@property NSString * artist;
@property NSString *artist_id;
@property NSString *artist_name;
@property NSString *count;
@property NSString *id;
@property NSString *length;
@property NSString *name;
@property NSString *picture ;
@property NSString *rank ;
@property NSString *src ;
@property NSString *widget_id;




@property NSString * added ;
@property NSString *follower ;
@property NSString *member;
@property NSString *style;
@property NSString *type ;

@property NSArray *playList;






@end
