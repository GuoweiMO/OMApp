//
//  SWConnectionManager.h
//  Swipe
//
//  Created by Guowei Mo on 16/04/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWCard.h"
#import "SWRequest.h"

typedef void(^completionBlock)(BOOL success,id response, NSError *error);

@interface SWConnectionManager : NSObject<NSURLConnectionDataDelegate>

+ (instancetype)sharedManager;

- (void)makeCreateCardRequestWithCard:(SWCard *)card completion:(completionBlock)completion;
- (void)makeUpdateStatusRequestWithCard:(NSString *)status completion:(completionBlock)completion;
- (void)makeSendCardRequestWithCompletion:(completionBlock)completion;
- (void)makeReceiveCardRequestWithCompletion:(completionBlock)completion;

@end
