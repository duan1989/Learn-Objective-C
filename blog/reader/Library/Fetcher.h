//
//  Fetcher.h
//  reader
//
//  Created by 李恺 on 13-1-19.
//  Copyright (c) 2013年 likai. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FetcherDelegate <NSObject>

@required
- (void)didFinishConnection: (NSData *)data;

@end

@interface Fetcher : NSObject<NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSURLRequest *request;
@property (strong, nonatomic) NSURLResponse *response;
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSMutableData *receivedData;
@property (strong, nonatomic) id delegate;

- (id)initWithURL: (NSString *)stringURL;

@end
