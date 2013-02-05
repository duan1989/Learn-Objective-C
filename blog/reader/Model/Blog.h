//
//  Blog.h
//  reader
//
//  Created by 李恺 on 13-1-19.
//  Copyright (c) 2013年 likai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Blog : NSObject

@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate *date;

- (UITableViewCell *)toTableCell;

@end
