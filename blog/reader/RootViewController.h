//
//  RootViewController.h
//  reader
//
//  Created by 李恺 on 13-1-19.
//  Copyright (c) 2013年 likai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/Blog.h"

@interface RootViewController : UITableViewController<NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *blogs;
@property (strong, nonatomic) Blog *blog;
@property (strong, nonatomic) NSString *nodeName;
@property (strong, nonatomic) NSMutableString *nodeContent;
@property NSInteger currentPage;
@property NSInteger pageSize;
@property NSInteger totalPage;

@end