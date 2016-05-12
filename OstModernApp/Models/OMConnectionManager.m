//
//  SWConnectionManager.m
//  Swipe
//
//  Created by Guowei Mo on 16/04/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import "SWConnectionManager.h"

@interface SWConnectionManager ()

@property(nonatomic, strong) NSURLConnection *createCardConnection;
@property(nonatomic, strong) NSURLConnection *sendCardConnection;
@property(nonatomic, strong) NSURLConnection *receiveCardConnection;
@property(nonatomic, strong) NSURLConnection *updateStausConnection;
@property(nonatomic, strong) NSURLConnection *retrieveCardConnection;

@property(nonatomic, strong) completionBlock createCardCompletion;
@property(nonatomic, strong) completionBlock sendCardCompletion;
@property(nonatomic, strong) completionBlock receiveCardCompletion;
@property(nonatomic, strong) completionBlock updateStausCompletion;
@property(nonatomic, strong) completionBlock retrieveCardCompletion;

@end

@implementation SWConnectionManager

- (instancetype)init
{
  self = [super init];
  return self;
}

+ (instancetype)sharedManager
{
  static SWConnectionManager *instance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
      instance = [[self alloc] init];
  });
  return instance;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
  if(data)
  {
    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    if(connection == self.createCardConnection)
    {
      self.createCardCompletion(YES, data, nil);
    }
    else if(connection == self.retrieveCardConnection)
    {
      NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                           options:kNilOptions
                                                             error:nil];
      SWCard *retrievedCard = [[SWCard alloc] initWithData:json];
      self.retrieveCardCompletion(YES, retrievedCard, nil);
    }
    else if(connection == self.sendCardConnection)
    {
      self.sendCardCompletion(YES, nil, nil);
    }
    else if(connection == self.receiveCardConnection)
    {
      NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                           options:kNilOptions
                                                             error:nil];
      SWCard *receivedCard = [[SWCard alloc] initWithData:json];
      self.receiveCardCompletion(YES, receivedCard, nil);
    }
    else if(connection == self.updateStausConnection)
    {
      self.updateStausCompletion(YES, nil, nil);
    }
  }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
  __block completionBlock completion;
  if(connection == self.createCardConnection)
  {
    completion = self.createCardCompletion;
  }
  else if(connection == self.retrieveCardConnection)
  {
    completion = self.retrieveCardCompletion;
  }
  else if(connection == self.sendCardConnection)
  {
    completion = self.sendCardCompletion;
  }
  else if(connection == self.receiveCardConnection)
  {
    completion = self.receiveCardCompletion;
  }
  else if(connection == self.updateStausConnection)
  {
    completion = self.updateStausCompletion;
  }
  completion(NO, nil, error);
}

- (void)makeCreateCardRequestWithCard:(SWCard *)card completion:(completionBlock)completion
{
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  SWRequest *request = [[SWRequest alloc] init];
  [params setObject: card.fullName forKey: @"name"];
  [params setObject: card.jobTitle forKey: @"title"];
  [params setObject: card.email forKey: @"email"];
  [params setObject: @"01000899778" forKey: @"phone"];
  [params setObject: card.cardPicUrl.absoluteString forKey: @"imageUrl"];
  [params setObject: @"on" forKey: @"status"];
  [params setObject: @"newCard" forKey: @"method"];
  
  [request configureRequestWithParams:params];
  
  self.createCardConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  self.createCardCompletion = completion;
}

- (void)makeRetrieveCardRequestWithId:(NSString *)cardId completion:(completionBlock)completion
{
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  [params setObject:cardId forKey:@"id"];
  
  SWRequest *request = [[SWRequest alloc] init];
  [request configureRequestWithParams:params];
  
  self.retrieveCardConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  self.retrieveCardCompletion = completion;
}


- (void)makeUpdateStatusRequestWithCard:(NSString *)status completion:(completionBlock)completion
{
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  [params setObject: status forKey: @"status"];
  
  SWRequest *request = [[SWRequest alloc] init];
  [request configureRequestWithParams:params];
  
  self.updateStausConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  self.updateStausCompletion = completion;
}

- (void)makeSendCardRequestWithCompletion:(completionBlock)completion
{
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  [params setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"id"] forKey:@"id"];
  [params setObject: @"updateStatus" forKey:@"method"];
  [params setObject: @"sending" forKey:@"status"];
  
  SWRequest *request = [[SWRequest alloc] init];
  [request configureRequestWithParams:params];
  
  self.sendCardConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  self.sendCardCompletion = completion;
}

- (void)makeReceiveCardRequestWithCompletion:(completionBlock)completion
{
  NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
  [params setObject:@"receiveCard" forKey:@"method"];
  
  SWRequest *request = [[SWRequest alloc] init];
  [request configureRequestWithParams:params];
  
  self.receiveCardConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
  self.receiveCardCompletion = completion;
}

@end
