# HYBMasonryAutoCellHeight
A very helpful category for calculating the height of cell automatically.

##说明
在github没有找到基于Masonry自动计算行高的库，倒是找到了使用xib和storyboard在添加约束来自动计算行高的库，如： UITableView-FDTemplateLayoutCell 

本人非常推崇Masonry来实现代码的自动布局，因此项目中都是使用Masonry布局的，为了自动计算行高，决定写一个扩展，以达到自动计算的效果，如此一来，开发者不用再关心那些非固定行高的cell的动态计算问题了。

##使用
只需要在UITableView的代理方法中调用：

```
/**
 * 通过此方法来计算行高，需要在config中调用配置数据的API
 *
 * @param indexPath 必传，对应的indexPath
 * @param confi     必须要实现，且需要调用配置数据的API
 *
 * @return 计算的行高
 */
+ (CGFloat)hyb_heightForIndexPath:(NSIndexPath *)indexPath config:(HYBCellBlock)config;
```

调用方式类似如下：
```
- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
  HYBNewsModel *model = nil;
  if (indexPath.row < self.dataSource.count) {
    model = [self.dataSource objectAtIndex:indexPath.row];
  }

  return [HYBNewsCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
    HYBNewsCell *cell = (HYBNewsCell *)sourceCell;
    
    // 配置数据
    [cell configCellWithModel:model];
  }];
}
```

具体使用和具体API说明，请参考Demo！

#Versions

* 1.0.0
  -* 增加缓存API
* 2.0.1
  -* 增加hyb_lastViewsInCell，当不确定哪个是最后一个时，可以使用此数组属性


##作者相关

个人博客地址：http://101.200.209.244.com/<br/>
CSDN博客地址：http://blog.csdn.net/woaifen3344<br/>
个人常用邮箱：huangyibiao520@163.com<br/>

##博文讲解

[Masonry自动计算行高](http://101.200.209.244/masonry-cell-height-auto-calculate/)

##致谢
感谢UITableView-FDTemplateLayoutCell的作者sunnyxx给了我灵感，这才有现在的基于Masonry版本的自动计算行高的开源库。
感谢所有使用本开源库的开发者，感谢你们的使用和反馈。

##关注我

如果在使用过程中遇到问题，或者想要与我交流，可加入有问必答**QQ群：[324400294]()**

关注微信公众号：[**iOSDevShares**]()

关注新浪微博账号：[标哥Jacky](http://weibo.com/u/5384637337)


##License
MIT
