//
//  OMConnectionManager.h
//  OstModernApp
//
//  Created by Guowei Mo on 06/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMRequest.h"

typedef void(^completionBlock)(NSData *data, NSURLResponse *response, NSError *error);

@interface OMConnectionManager : NSObject<NSURLConnectionDataDelegate>

+ (instancetype)sharedManager;
- (void)makeRetrieveSetsTaskWithCompletion:(completionBlock)completion;
- (void)makeRetrieveEpisodeTaskWithURLString:(NSString *)urlString completion:(completionBlock)completion;

@end
