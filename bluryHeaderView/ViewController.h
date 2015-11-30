//
//  ViewController.h
//  bluryHeaderView
//
//  Created by 谈Xx on 15/8/26.
//  Copyright (c) 2015年 谈Xx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "bluryView.h"
@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) bluryView *bluryView;


@end

