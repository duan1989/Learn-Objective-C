//
//  ContentViewController.h
//  reader
//
//  Created by 李恺 on 13-1-19.
//  Copyright (c) 2013年 likai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model/Blog.h"

@interface ContentViewController : UIViewController<UIWebViewDelegate>

@property (strong, nonatomic) Blog *blog;

@end
