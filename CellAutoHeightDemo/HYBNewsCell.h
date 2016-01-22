//
//  HYBNewsCell.h
//  CellAutoHeightDemo
//
//  Created by huangyibiao on 15/9/1.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HYBNewsModel;

typedef void(^HYBExpandBlock)(BOOL isExpand);

@interface HYBNewsCell : UITableViewCell

@property (nonatomic, copy) HYBExpandBlock expandBlock;

- (void)configCellWithModel:(HYBNewsModel *)model;

@end
