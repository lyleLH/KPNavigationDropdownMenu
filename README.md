# KPNavigationDropdownMenu


###安装
将KPNavigationDropdownMenu文件夹拖进工程即可
###使用
- 增加`KPNavigationDropdownMenu *topMenu ` 属性

```
@interface KPOrderListViewController 
@property (nonatomic,strong)KPNavigationDropdownMenu *topMenu ;
@end

```
- 将控制器的`navigationItem.titleView`设置为`topMenu ` 视图

```
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.titleView = self.topMenu;
}
```
- 懒加载初始化并调用block监听事件

```
- (KPNavigationDropdownMenu *)topMenu {
    if(!_topMenu) {
        _topMenu = [[KPNavigationDropdownMenu alloc] initWithNavigationController:self.navigationController
                                                                        andTitles:@[@"全部订单",
                                                                                    @"悬赏订单",
                                                                                    @"服务订单",
                                                                                    @"商品订单",
                                                                                    @"闪付订单",
                                                                                    @"维保订单"]];
        _topMenu.categoryBtnClicked = ^(UIButton *btn) {
            NSLog(@"%ld",btn.tag - kOrderListCategoryButtonTagOffset);
            self.orderType = (KPOrderType)(btn.tag - kOrderListCategoryButtonTagOffset);
            [self fakData];
        };
    }
    return _topMenu;
}

```
###效果图
![image](https://github.com/lyleLH/KPNavigationDropdownMenu/blob/master/Untitled.gif)