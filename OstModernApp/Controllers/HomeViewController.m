//
//  ViewController.m
//  OstModernApp
//
//  Created by Guowei Mo on 06/05/2016.
//  Copyright © 2016 Guowei Mo. All rights reserved.
//

#import "HomeViewController.h"
#import "OMSetViewCell.h"
#import "OMSet.h"
#import "OMConnectionManager.h"
#import "OMEpisodeViewController.h"

#define kSetCellId @"set_cell"

@interface HomeViewController ()

@property (nonatomic, strong) NSMutableArray *setList;
@property (nonatomic, strong) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

@implementation HomeViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  if(self.setList == nil)
  {
    self.setList = [[NSMutableArray alloc] init];
  }
  
  self.flowLayout.itemSize = CGSizeMake(100, 140);
  self.flowLayout.minimumInteritemSpacing = 20.0f;
  
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  
  UINib *cellNib = [UINib nibWithNibName:@"OMSetViewCell" bundle:nil];
  [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:kSetCellId];
  [self setAutomaticallyAdjustsScrollViewInsets:NO];
  
  [self retrieveSetData];
}

- (void)retrieveSetData
{
  __weak HomeViewController *weakSelf = self;
  [[OMConnectionManager sharedManager] makeRetrieveSetsTaskWithCompletion:^(NSData *data, NSURLResponse *response, NSError *error) {
    __strong HomeViewController *strongSelf = weakSelf;
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *setList = jsonData[@"objects"];
    for (NSDictionary *setData in setList) {
      OMSet *set = [[OMSet alloc] initWithData:setData];
      [strongSelf.setList addObject:set];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
      [strongSelf.collectionView reloadData];
    });
    
  }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.setList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  OMSetViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSetCellId forIndexPath:indexPath];
  OMSet *aSet = self.setList[indexPath.item];
  cell.streamSetTitle.text = [aSet coverTitle];;
  
  return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  OMEpisodeViewController *controller = [[OMEpisodeViewController alloc] initWithCellItem:indexPath.item];
  controller.delegate = self;
  OMSet *selectedSet = self.setList[indexPath.item];
  for(int i = 0; i < [selectedSet numberOfEpisodes]; i++)
  {
    [controller retrieveEpisodeDataFromURL:[selectedSet episodeURLAtIndex:i]];
  }
  [self.navigationController pushViewController:controller animated:YES];
}

- (NSInteger)numberOfEpisodesAtSetItem:(NSInteger)item
{
  OMSet *currentSet = self.setList[item];
  return [currentSet numberOfEpisodes];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  
}

@end
