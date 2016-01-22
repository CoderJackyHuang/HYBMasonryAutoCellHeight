//
//  UITableView+HYBCacheHeight.h
//  CellAutoHeightDemo
//
//  Created by huangyibiao on 16/1/22.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  基于Masonry自动布局实现的自动计算cell的行高扩展
 *
 *  @author huangyibiao
 *  @email  huangyibiao520@163.com
 *  @github https://github.com/CoderJackyHuang
 *  @blog   http://www.henishuo.com/masonry-cell-height-auto-calculate/
 *
 *  @note Make friends with me：
 *        QQ:(632840804)
 *        Please tell me your real name when you send message to me.3Q.
 */
@interface UITableView (HYBCacheHeight)

/**
 *	@author 黄仪标, 16-01-22 20:01:09
 *
 *	用于缓存cell的行高
 */
@property (nonatomic, strong, readonly) NSMutableDictionary *hyb_cacheCellHeightDict;

@end
