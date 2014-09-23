//
//  SNViewController.m
//  SampleCollectionView
//
//  Created by shahid on 27/08/14.
//  Copyright (c) 2014 SourceN. All rights reserved.
//

#import "SNViewController.h"
#import "SNCustomCell.h"

@interface SNViewController () <UICollectionViewDataSource,UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic) NSInteger numberOfCells;

@property (nonatomic) NSInteger page;

@property (nonatomic) NSInteger prevPage;

@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation SNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.page = 0;
    self.prevPage = -1;
    
    // Delay execution of my block for 10 seconds.

    self.dataArray = [[NSMutableArray alloc]init];
    self.numberOfCells = 0;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [self.collectionView performBatchUpdates:^{
                        [self.dataArray addObject:[NSIndexPath indexPathForRow:self.numberOfCells inSection:0]];
                        [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:self.dataArray.lastObject, nil]];
                    } completion:^(BOOL finished) {
                        
                        [self.collectionView performBatchUpdates:^{
                            self.numberOfCells ++;
                            [self.dataArray addObject:[NSIndexPath indexPathForRow:self.numberOfCells inSection:0]];
                            [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:self.dataArray.lastObject, nil]];
                        } completion:^(BOOL finished) {
                            [self.collectionView performBatchUpdates:^{
                                self.numberOfCells ++;
                                [self.dataArray addObject:[NSIndexPath indexPathForRow:self.numberOfCells inSection:0]];
                                [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:self.dataArray.lastObject, nil]];
                            } completion:^(BOOL finished) {
                                [self.collectionView performBatchUpdates:^{
                                    self.numberOfCells ++;
                                    [self.dataArray addObject:[NSIndexPath indexPathForRow:self.numberOfCells inSection:0]];
                                    [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:self.dataArray.lastObject, nil]];
                                } completion:^(BOOL finished) {
                                }];
                            }];
                        }];
                    }];
        });
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView Datasource
// 1
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
// 2
- (NSInteger)numberOfSectionsInCollectionView: (UICollectionView *)collectionView {
    return 1;
}
// 3
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SNCustomCell *cell = [cv dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    cell.textLbl.text = [NSString stringWithFormat:@"%d",indexPath.row];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    CGSize headerSize = CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
    return headerSize;
}

#pragma mark UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (CGRectIntersectsRect(scrollView.bounds, CGRectMake(0, self.collectionView.contentSize.height - self.collectionView.frame.size.height, CGRectGetWidth(self.view.frame), 40)) && self.collectionView.contentSize.height > 0 && self.prevPage != self.page)
    {
        self.page ++;
        self.prevPage = self.page;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [self.collectionView performBatchUpdates:^{
                self.numberOfCells ++;
                [self.dataArray addObject:[NSIndexPath indexPathForRow:self.numberOfCells inSection:0]];
                [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:self.dataArray.lastObject, nil]];
            } completion:^(BOOL finished) {
                [self.collectionView performBatchUpdates:^{
                    self.numberOfCells ++;
                    [self.dataArray addObject:[NSIndexPath indexPathForRow:self.numberOfCells inSection:0]];
                    [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:self.dataArray.lastObject, nil]];
                } completion:^(BOOL finished) {
                    [self.collectionView performBatchUpdates:^{
                        self.numberOfCells ++;
                        [self.dataArray addObject:[NSIndexPath indexPathForRow:self.numberOfCells inSection:0]];
                        [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:self.dataArray.lastObject, nil]];
                    } completion:^(BOOL finished) {
                        self.prevPage = self.page-1;
                        [self.collectionView performBatchUpdates:^{
                            self.numberOfCells ++;
                            [self.dataArray addObject:[NSIndexPath indexPathForRow:self.numberOfCells inSection:0]];
                            [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:self.dataArray.lastObject, nil]];
                        } completion:^(BOOL finished) {
                        }];
                    }];
                }];
            }];
        });
    }
}

@end
