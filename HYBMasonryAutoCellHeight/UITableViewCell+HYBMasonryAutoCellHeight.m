//
//  UITableViewCell+HYBMasonryAutoCellHeight.m
//  CellAutoHeightDemo
//
//  Created by huangyibiao on 15/9/1.
//  Copyright © 2015年 huangyibiao. All rights reserved.
//

#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import <objc/runtime.h>

const void *s_hyb_lastViewInCellKey = "hyb_lastViewInCellKey";
const void *s_hyb_bottomOffsetToCellKey = "hyb_bottomOffsetToCellKey";

@implementation UITableViewCell (HYBMasonryAutoCellHeight)

#pragma mark - Public
+ (CGFloat)hyb_heightForIndexPath:(NSIndexPath *)indexPath config:(HYBCellBlock)config {
  UITableViewCell *cell = [[self alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:nil];
  
  if (config) {
    config(cell);
  }

  return [cell private_hyb_heightForIndexPath:indexPath];
}

- (void)setHyb_lastViewInCell:(UIView *)hyb_lastViewInCell {
  objc_setAssociatedObject(self,
                           s_hyb_lastViewInCellKey,
                           hyb_lastViewInCell,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)hyb_lastViewInCell {
  return objc_getAssociatedObject(self, s_hyb_lastViewInCellKey);
}

- (void)setHyb_bottomOffsetToCell:(CGFloat)hyb_bottomOffsetToCell {
  objc_setAssociatedObject(self,
                           s_hyb_bottomOffsetToCellKey,
                           @(hyb_bottomOffsetToCell),
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)hyb_bottomOffsetToCell {
  NSNumber *valueObject = objc_getAssociatedObject(self, s_hyb_bottomOffsetToCellKey);
  if ([valueObject respondsToSelector:@selector(floatValue)]) {
    return valueObject.floatValue;
  }
  
  return 0.0;
}

#pragma mark - Private
- (CGFloat)private_hyb_heightForIndexPath:(NSIndexPath *)indexPath {
  NSAssert(self.hyb_lastViewInCell != nil, @"您未指定cell排列中最后一个视图对象，无法计算cell的高度");
  
  [self layoutIfNeeded];
  
  CGFloat rowHeight = self.hyb_lastViewInCell.frame.size.height + self.hyb_lastViewInCell.frame.origin.y;
  rowHeight += self.hyb_bottomOffsetToCell;
  
  return rowHeight;
}



@end
