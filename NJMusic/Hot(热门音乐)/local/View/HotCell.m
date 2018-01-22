//
//  HotCell.m
//  PTMusic
//
//  Created by qianfeng on 14-6-17.
//  Copyright (c) 2014年 PT. All rights reserved.
//

#import "HotCell.h"

@implementation HotCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createUI];
    }
    return self;
}

-(void)createUI{
    UIImageView *bgimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 80)];
    bgimage.image=[UIImage imageNamed:@"cellbg.png"];
    [self.contentView addSubview:bgimage];
    
    self.headImage=[[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 70, 70)];
    self.headImage.backgroundColor=[UIColor blueColor];
    [self.contentView addSubview:self.headImage];
    
    self.nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(85, 10, 150, 20)];
    self.nameLabel.textColor=[UIColor blackColor];
    self.nameLabel.font=[UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:self.nameLabel];
    
    self.StyleLabel=[[UILabel alloc] initWithFrame:CGRectMake(85, 30, 200, 20)];
    self.StyleLabel.textColor=[UIColor grayColor];
    self.StyleLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.StyleLabel];
    
    self.authorLabel=[[UILabel alloc]initWithFrame:CGRectMake(85, 45, 200, 30)];
    self.authorLabel.textColor=[UIColor grayColor];
    self.authorLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.authorLabel];
    
    self.downLoadButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.downLoadButton.frame=CGRectMake(self.bounds.size.width-70, 25, 25, 25);
    [self.downLoadButton setBackgroundImage:[UIImage imageNamed:@"unDownload.png"] forState:UIControlStateNormal];
    [self.downLoadButton setBackgroundImage:[UIImage imageNamed:@"download.png"] forState:UIControlStateSelected];
    [self.downLoadButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.downLoadButton];
}
-(void)setBlock:(void(^)(void))blockCb{
    _blockCB=[blockCb copy];
}
-(void)btnClick{
    if (!self.downLoadButton.selected) {
        _blockCB();
        self.downLoadButton.selected=YES;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (id)initPlayLIstWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self createPlayListUI];
    }
    return self;
}
-(void)createPlayListUI{
    UIImageView *bgimage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    bgimage.image=[UIImage imageNamed:@"artistcell.png"];
    [self.contentView addSubview:bgimage];
    
    
    self.nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, 150, 20)];
    self.nameLabel.textColor=[UIColor blackColor];
    self.nameLabel.font=[UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:self.nameLabel];
    
    self.authorLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 25, 200, 10)];
    self.authorLabel.textColor=[UIColor grayColor];
    self.authorLabel.font=[UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.authorLabel];
    
    self.downLoadButton=[UIButton buttonWithType:UIButtonTypeCustom];
    self.downLoadButton.frame=CGRectMake(self.bounds.size.width-70, 5, 30, 30);
    [self.downLoadButton setBackgroundImage:[UIImage imageNamed:@"unDownload.png"] forState:UIControlStateNormal];
    [self.downLoadButton setBackgroundImage:[UIImage imageNamed:@"download.png"] forState:UIControlStateSelected];
    [self.downLoadButton addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.downLoadButton];

}

@end
