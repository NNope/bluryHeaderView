//
//  ViewController.m
//  bluryHeaderView
//
//  Created by 谈Xx on 15/8/26.
//  Copyright (c) 2015年 谈Xx. All rights reserved.
//

#import "ViewController.h"
#import "bluryHeaderView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width, 500)];
    self.table.backgroundColor = [UIColor lightGrayColor];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.view addSubview:self.table];
    
    // 创建headerView，设置图片 位置
    bluryHeaderView *dd = [bluryHeaderView
                           bluryWithbluryImg:[UIImage imageNamed:@"thumb"]
                           andFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 220)
                           andBluryType:nil];
    
    // 主文本 “折”自带
    [dd setMainLabelTitle:@"8.8" andIsNeedZhe:YES];
    // 副文本
    [dd setMinorLabelTitle:@"最高减20元  | 155235人已领"];
    // 按钮文字 按钮颜色（高亮颜色不需要写，不过没什么用，一按下就触发事件了， 高亮要过一会才能看到，不舒服。。。。）
    [dd setBtnWithTitle:@"领取折扣" andBgColor:[UIColor colorWithRed:30/255.0 green:171/255.0 blue:235/255.0 alpha:1]];
    // 设置
    self.table.tableHeaderView = dd;
}


// 状态栏颜色风格
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark UISCrollViewDelegate
/**
 *  tableView滑动后，传递事件给头部的scrollView
 *
 *  @param scrollView
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.table)
    {
        [(bluryHeaderView *)self.table.tableHeaderView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
    }
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 单元格复用
    static NSString *sectionsTableIdentifier = @"sectionsTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionsTableIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:sectionsTableIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
