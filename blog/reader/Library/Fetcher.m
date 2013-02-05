//
//  Fetcher.m
//  reader
//
//  Created by 李恺 on 13-1-19.
//  Copyright (c) 2013年 likai. All rights reserved.
//

#import "Fetcher.h"

@implementation Fetcher

@synthesize url;
@synthesize request;
@synthesize response;
@synthesize connection;
@synthesize receivedData;
@synthesize delegate;

- (id)initWithURL:(NSString *)stringURL {
    Fetcher *fetcher = [[Fetcher alloc] init];
    NSURL *theURL = [NSURL URLWithString: stringURL];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL: theURL];
    NSURLConnection *theConnection = [NSURLConnection connectionWithRequest: theRequest delegate: fetcher];
    
    fetcher.url = theURL;
    fetcher.request = theRequest;
    fetcher.connection = theConnection;
    
    if(fetcher.connection) {
        receivedData = [[NSMutableData alloc] init];
        NSLog(@"connected");
    }
    
    return fetcher;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connect failed: %@", error);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)theResponse {
    response = theResponse;
    NSLog(@"respond");
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [receivedData appendData: data];
    NSLog(@"data fetching");
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if([delegate conformsToProtocol: @protocol(FetcherDelegate)]) {
        [delegate didFinishConnection: receivedData];
    }
    NSLog(@"connection finished");
}

@end