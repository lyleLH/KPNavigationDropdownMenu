//
//  ViewController.m
//  LHDropmenuTest
//
//  Created by lyleKP on 2017/2/24.
//  Copyright © 2017年 lyle. All rights reserved.
//

#import "ViewController.h"
#import "KPNavigationDropdownMenu.h"
@interface ViewController ()
@property (nonatomic,strong)KPNavigationDropdownMenu *topMenu ;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.titleView = self.topMenu;
}


- (KPNavigationDropdownMenu *)topMenu {
    if(!_topMenu) {
        _topMenu = [[KPNavigationDropdownMenu alloc] initWithNavigationController:self.navigationController andTitles:@[@"全部订单", @"悬赏订单", @"服务订单", @"商品订单",@"闪付订单",@"维保订单",@"全部订单", @"悬赏订单", @"服务订单", @"商品订单",@"闪付订单",@"维保订单"]];
        _topMenu.categoryBtnClicked = ^(UIButton *btn) {
            NSLog(@"%ld",btn.tag - kOrderListCategoryButtonTagOffset);
            
        };
    }
    return _topMenu;
}


@end
