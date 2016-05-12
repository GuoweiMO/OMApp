//
//  OMRequest.h
//  OstModernApp
//
//  Created by Guowei Mo on 06/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_API_URL @"http://feature-code-test.skylark-cms.qa.aws.ostmodern.co.uk:8000/api/"

@interface OMRequest : NSMutableURLRequest

- (void)configRequestWithAPIURL:(NSString *)urlString;

@end
