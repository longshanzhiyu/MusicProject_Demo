//
//  HotCell.h
//  PTMusic
//
//  Created by qianfeng on 14-6-17.
//  Copyright (c) 2014年 PT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotCell : UITableViewCell
{
    void(^_blockCB)(void);
}
@property UIImageView *headImage;
@property UILabel *nameLabel;
@property UILabel *StyleLabel;
@property UILabel *authorLabel;
@property UIButton *downLoadButton;
- (id)initPlayLIstWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(void)setBlock:(void(^)(void))blockCb;
@end
