//
//  ViewController.m
//  CellAutoHeightDemo
//
//  Created by huangyibiao on 15/9/1.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "Masonry/View+MASAdditions.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "HYBNewsModel.h"
#import "HYBNewsCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.tableView = [[UITableView alloc] init];
  [self.view addSubview:self.tableView];
  
  [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.mas_equalTo(self.view);
  }];
  
  self.tableView.backgroundColor = [UIColor whiteColor];
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
}

- (NSMutableArray *)dataSource {
  if (_dataSource == nil) {
    _dataSource = [[NSMutableArray alloc] init];
    
    int titleTotalLength = (int)[[self titleAll] length];
    int descTotalLength = (int)[[self descAll] length];
    for (NSUInteger i = 0; i < 40; ++i) {
      int titleLength = rand() % titleTotalLength + 15;
      if (titleLength > titleTotalLength - 1) {
        titleLength = titleTotalLength;
      }
      
      HYBNewsModel *model = [[HYBNewsModel alloc] init];
      model.title = [[self titleAll] substringToIndex:titleLength];
      model.uid = (int)i + 1;
      model.isExpand = YES;
      
      int descLength = rand() % descTotalLength + 20;
      if (descLength >= descTotalLength) {
        descLength = descTotalLength;
      }
      model.desc = [[self descAll] substringToIndex:descLength];
      
      [_dataSource addObject:model];
    }
  }
  
  return _dataSource;
}

- (NSString *)titleAll {
  return @"欢迎使用HYBMasonryAutoCellHeight扩展，由作者huangyibiao提供，如有任何疑问，请给作者发email：huangyibiao520@163.com，谢谢您的支持！！！";
}

- (NSString *)descAll {
  return @"HYBMasonryAutoCellHeight是基于Masonry第三方开源库而实现的，如想更深入了解Masonry，可直接到github上的官方文档阅读，或可以到作者的博客中阅读相关文章：http://www.hybblog.com/masonryjie-shao/，如果阅读时有疑问，可直接联系作者（email或者QQ），最直接的方式就是在文章后面留言，作者会在收到反馈后的第一时间迅速查看，并给予相应的回复。欢迎留言，希望我们能成为朋友。";
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.dataSource.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView
                 cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  static NSString *cellIdentifier = @"CellIdentifier";
  HYBNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (!cell) {
      cell = [[HYBNewsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                reuseIdentifier:cellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  }
  
  HYBNewsModel *model = nil;
  if (indexPath.row < self.dataSource.count) {
    model = [self.dataSource objectAtIndex:indexPath.row];
  }
  [cell configCellWithModel:model];
  
  cell.expandBlock = ^(BOOL isExpand) {
    model.isExpand = isExpand;
    [tableView reloadRowsAtIndexPaths:@[indexPath]
                     withRowAnimation:UITableViewRowAnimationFade];
  };
  
  return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  HYBNewsModel *model = nil;
  if (indexPath.row < self.dataSource.count) {
    model = [self.dataSource objectAtIndex:indexPath.row];
  }
  
  NSString *stateKey = nil;
  if (model.isExpand) {
    stateKey = @"expanded";
  } else {
    stateKey = @"unexpanded";
  }
  
  return [HYBNewsCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
    HYBNewsCell *cell = (HYBNewsCell *)sourceCell;
    // 配置数据
    [cell configCellWithModel:model];
  } cache:^NSDictionary *{
    return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%d", model.uid],
             kHYBCacheStateKey : stateKey,
             // 如果设置为YES，若有缓存，则更新缓存，否则直接计算并缓存
             // 主要是对社交这种有动态评论等不同状态，高度也会不同的情况的处理
             kHYBRecalculateForStateKey : @(NO) // 标识不用重新更新
             };
  }];
}

@end
