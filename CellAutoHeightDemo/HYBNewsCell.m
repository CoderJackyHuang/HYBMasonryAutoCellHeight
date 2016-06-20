//
//  HYBNewsCell.m
//  CellAutoHeightDemo
//
//  Created by huangyibiao on 15/9/1.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "HYBNewsCell.h"
#import "HYBNewsModel.h"
#import "Masonry.h"

// 建议放在pch文件中
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"

@interface HYBNewsCell ()

@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, assign) BOOL isExpandedNow;

@end

@implementation HYBNewsCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
  if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
    self.mainLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.mainLabel];
    self.mainLabel.numberOfLines = 0;
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(15);
      make.top.mas_equalTo(20);
      make.right.mas_equalTo(-15);
      make.height.mas_lessThanOrEqualTo(80);
    }];
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.mainLabel.preferredMaxLayoutWidth = w - 30;
    
    self.descLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.descLabel];
    self.descLabel.numberOfLines = 0;
    [self.descLabel sizeToFit];
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(15);
      make.right.mas_equalTo(-15);
      make.top.mas_equalTo(self.mainLabel.mas_bottom).offset(15);
    }];
    // 应该始终要加上这一句
    // 不然在6/6plus上就不准确了
    self.descLabel.preferredMaxLayoutWidth = w - 30;
    self.descLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(onTap)];
    [self.descLabel addGestureRecognizer:tap];
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contentView addSubview:self.button];
    [self.button setTitle:@"我是cell的最后一个" forState:UIControlStateNormal];
    [self.button setBackgroundColor:[UIColor greenColor]];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.mas_equalTo(15);
      make.right.mas_equalTo(-15);
      make.height.mas_equalTo(45);
      make.top.mas_equalTo(self.descLabel.mas_bottom).offset(40);
    }];
    
    // 必须加上这句
//    self.hyb_lastViewInCell = self.button;
    self.hyb_lastViewsInCell = @[self.button];
    
    self.hyb_bottomOffsetToCell = 20;
    self.isExpandedNow = YES;
  }
  
  return self;
}

- (void)configCellWithModel:(HYBNewsModel *)model {
  NSLog(@"配置数据");
  self.mainLabel.text = model.title;
  self.descLabel.text = model.desc;
  
  if (model.isExpand != self.isExpandedNow) {
    self.isExpandedNow = model.isExpand;
    
    if (self.isExpandedNow) {
      [self.descLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.mainLabel.mas_bottom).offset(15);
      }];
    } else {
      [self.descLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_lessThanOrEqualTo(60);
      }];
    }
  }
}

- (void)onTap {
  if (self.expandBlock) {
    self.expandBlock(!self.isExpandedNow);
  }
}

@end
