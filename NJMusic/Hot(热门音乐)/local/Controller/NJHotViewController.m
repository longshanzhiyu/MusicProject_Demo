//
//  NJHotViewController.m
//  NJMusic
//
//  Created by njw on 2017/12/18.
//  Copyright © 2017年 njw. All rights reserved.
//

#import "NJHotViewController.h"

@interface NJHotViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) NSMutableArray *dataArray;
@end

@implementation NJHotViewController

- (NSMutableArray *)dataArray
{
    if (nil == _dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI
{
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:@[@"热门单曲",@"热门音乐人"]];
    segment.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segment;
}

- (void)requestFromNetwork
{
//    ?type=song&cb=%24.setp(0.43932564719580114)&app_name=music_artist&version=52&_=1403066278330
    NSDictionary *param = @{@"type":@"song", @"cb":@"%24.setp(0.43932564719580114)", @"app_name":@"music_artist", @"version":@"52", @"_":@"1403066278330"};
    __weak typeof(self) weakSelf = self;
    [NJHotService getHotDataFromNetWithModel:NetworkRequestTypeGet withUrl:SINGLEMUSIC withParam:nil success:^(id result) {
        [weakSelf.dataArray removeAllObjects];
        weakSelf.dataArray = result;
        [weakSelf.tableview reloadData];
    } failure:^(id error) {
        
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID=@"cell";
    HotCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[HotCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    HotModel *model=self.dataArray[indexPath.row];
    cell.nameLabel.text=model.name;
    [cell.headImage setImageWithURL:[NSURL URLWithString:model.picture]];
    cell.authorLabel.text=model.artist;
    cell.StyleLabel.text=model.length;
    cell.downLoadButton.alpha=1;
    cell.downLoadButton.selected=NO;
//    for (MusicModel *modell in [musicView musicNameArray]) {
//        if ([modell.name isEqualToString:model.name]) {
//            cell.downLoadButton.selected=YES;
//            break;
//        }
//    }
//    [cell setBlock:^{
//        NSString *name=[self removeXieGangInString:model.name];
//        [musicView addObjectOfDownLoadArrayWithName:name andActor:model.artist andWangZhi:model.src];
//        [[FileMenager shareDistance] addActionWithUrl:model.src andPath:[MUSICLIST stringByAppendingFormat:@"/%@.mp3",name] andName:name];
//    }];
    return cell;
}

@end
