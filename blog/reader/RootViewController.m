//
//  RootViewController.m
//  reader
//
//  Created by 李恺 on 13-1-19.
//  Copyright (c) 2013年 likai. All rights reserved.
//

#import "RootViewController.h"
#import "ContentViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

@synthesize blogs;
@synthesize blog;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = INDEX_VIEW_TITLE;
        
        self.pageSize = PAGE_SIZE;
        self.currentPage = 1;
        
        [self fetchBlogs];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget: self action: @selector(refreshTableView) forControlEvents: UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void) refreshTableView {
    [self performSelector:  @selector(endRefreshTableView) withObject: nil afterDelay: 1];
}

- (void) endRefreshTableView {
    [self refreshBlogs];
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}


// set tableView section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// set tableView rows
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = self.currentPage * self.pageSize;
    NSInteger total = blogs.count - 1;
    return (rows > total ? total : rows) + 1;
}

// set tableView row height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

// set tableView row content
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row + 1 > (self.currentPage * self.pageSize)) {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.font = [UIFont fontWithName: @"Monaco" size: 12];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.textLabel.text = @"加载更多...";
        return cell;
    } else {
        blog = [blogs objectAtIndex: indexPath.row];
        return [blog toTableCell];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row + 1 > (self.currentPage * self.pageSize)) {
        if(self.currentPage >= self.totalPage) {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];
            cell.textLabel.text = @"没有了...";
        } else {
            self.currentPage++;
            UITableViewCell *cell = [tableView cellForRowAtIndexPath: indexPath];
            cell.textLabel.text = @"加载中...";
            [self.tableView reloadData];
        }
    } else {
        blog = [blogs objectAtIndex: indexPath.row];
        ContentViewController *viewController = [[ContentViewController alloc] init];
        viewController.blog = blog;
        [self.navigationController pushViewController: viewController animated: YES];
    }
}

// 获取博客列表
- (void)fetchBlogs {
    NSData *data;
    NSString *cacheFile = [self getCacheFile];
    NSFileHandle *fileHandler = [NSFileHandle fileHandleForReadingAtPath: cacheFile];
    data = [fileHandler readDataToEndOfFile];
    [fileHandler closeFile];
    
    blogs = [[NSMutableArray alloc] init];
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData: data];
    parser.delegate = self;
    [parser parse];
    
    self.totalPage = (int)ceil((double)blogs.count / (double)self.pageSize);
}

- (void)refreshBlogs {
    NSData *data;
    NSError *error;
    NSString *cacheFile = [self getCacheFile];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 如果文件不存在则创建
    if(![fileManager fileExistsAtPath: cacheFile]) {
        [fileManager createFileAtPath: cacheFile contents: nil attributes: nil];
    }
    
    NSFileHandle *fileHandler = [NSFileHandle fileHandleForReadingAtPath: cacheFile];
    
    NSURL *url = [NSURL URLWithString: RSS_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    data = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: &error];
    fileHandler = [NSFileHandle fileHandleForWritingAtPath: cacheFile];
    [fileHandler writeData: data];
    [fileHandler closeFile];
    
    [self fetchBlogs];
    
    NSLog(@"refresh blogs: %@", cacheFile);
}

- (NSString *) getCacheFile {
    NSArray *dirs = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [dirs objectAtIndex: 0];
    return [cachePath stringByAppendingPathComponent: @"data.cache"];
}

// start tag
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if([elementName isEqualToString: @"item"]) {
        blog = nil;
        blog = [[Blog alloc] init];
    }
}

// parse string
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
//    [self.nodeContent appendString: string];
    [self.nodeContent appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

// end tag
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString: @"title"]) {
        blog.title = self.nodeContent;
    }
    
    if([elementName isEqualToString: @"pubDate"]) {
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat: @"EEE, d MMM yyyy HH:mm:ss z"];
        NSDate *date = [format dateFromString: self.nodeContent];
        blog.date = date;
    }
    
    if([elementName isEqualToString: @"link"]) {
        blog.link = self.nodeContent;
    }
    
    if([elementName isEqualToString: @"description"]) {
        blog.content = self.nodeContent;
    }
    
    if([elementName isEqualToString: @"item"]) {
        [blogs addObject: blog];
    }
    
    self.nodeContent = [[NSMutableString alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
