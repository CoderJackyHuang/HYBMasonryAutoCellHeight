//
//  UITableView+HYBCacheHeight.m
//  CellAutoHeightDemo
//
//  Created by huangyibiao on 16/1/22.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "UITableView+HYBCacheHeight.h"
#import <objc/runtime.h>

static const void *__hyb_tableview_cacheCellHeightKey = "__hyb_tableview_cacheCellHeightKey";

@implementation UITableView (HYBCacheHeight)

- (NSMutableDictionary *)hyb_cacheCellHeightDict {
 NSMutableDictionary *dict = objc_getAssociatedObject(self, __hyb_tableview_cacheCellHeightKey);
  
  if (dict == nil) {
    dict = [[NSMutableDictionary alloc] init];
    objc_setAssociatedObject(self,
                             __hyb_tableview_cacheCellHeightKey,
                             dict,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  }
  
  return dict;
}

@end
