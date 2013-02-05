//
//  Blog.m
//  reader
//
//  Created by 李恺 on 13-1-19.
//  Copyright (c) 2013年 likai. All rights reserved.
//

#import "Blog.h"

@implementation Blog

- (UITableViewCell *)toTableCell {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier: @"blog"];
    
    //set title
    cell.textLabel.font = [UIFont fontWithName: @"Monaco" size: 12];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.text = self.title;
    
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat: @"yyyy-MM-dd"];
    cell.detailTextLabel.font = [UIFont fontWithName: @"Verdana" size: 10];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.textAlignment = NSTextAlignmentRight;
    cell.detailTextLabel.text = [NSString stringWithFormat: @"发布于 %@", [formater stringFromDate: self.date]];
    
    return cell;
}

@end