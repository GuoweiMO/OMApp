//
//  OMEpisodeViewController.m
//  OstModernApp
//
//  Created by Guowei Mo on 11/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import "OMEpisodeViewController.h"
#import "OMEpisodeCell.h"
#import "OMConnectionManager.h"

@interface OMEpisodeViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *episodes;

@end

@implementation OMEpisodeViewController

- (instancetype)initWithCellItem:(NSInteger)item
{
  self = [super init];
  if(self != nil)
  {
    self.setItem = item;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  UITableView *episodeTable = [UITableView new];
  episodeTable.frame = self.view.bounds;
  [self.view addSubview:episodeTable];
  episodeTable.delegate = self;
  episodeTable.dataSource = self;

  UINib *cellNib = [UINib nibWithNibName:@"OMEpisodeCell" bundle:nil];
  [episodeTable registerNib:cellNib forCellReuseIdentifier:@"episode_cell"];
  self.tableView = episodeTable;
  self.episodes = [NSMutableArray new];
  
  self.navigationItem.title = @"Episodes";
}

- (void)retrieveEpisodeDataFromURL:(NSString *)urlString
{
  __weak OMEpisodeViewController *weakSelf = self;
  [[OMConnectionManager sharedManager] makeRetrieveEpisodeTaskWithURLString:urlString completion:^(NSData *data, NSURLResponse *response, NSError *error) {
    __strong OMEpisodeViewController *strongSelf = weakSelf;
    if(data)
    {
      NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
      OMEpisode *episode = [[OMEpisode alloc] initWithData:jsonData];
      [strongSelf.episodes addObject:episode];
    }
    if(strongSelf.episodes.count == (NSInteger)[self.delegate numberOfEpisodesAtSetItem:self.setItem])
    {
     dispatch_async(dispatch_get_main_queue(), ^{
       [strongSelf.tableView reloadData];
     });
    }
  }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 80.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return self.episodes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  OMEpisodeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"episode_cell"];
  [cell updateCellWithEpisodeInfo:self.episodes[indexPath.row]];
  return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
