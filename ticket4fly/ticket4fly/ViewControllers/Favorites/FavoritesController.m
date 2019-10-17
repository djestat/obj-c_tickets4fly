//
//  FavoritesController.m
//  ticket4fly
//
//  Created by Igor on 29/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "FavoritesController.h"
#import "FavoriteTicketCell.h"

#import "LocalNotificationManager.h"



@interface FavoritesController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UISegmentedControl* segmentedControl;
@property (nonatomic, strong) NSMutableArray* ticketsCollection;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation FavoritesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Favorites";
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 20.0;
    layout.minimumInteritemSpacing = 20.0;
    layout.sectionInset = UIEdgeInsetsMake(10.0, 0, 0, 0);
    layout.itemSize = CGSizeMake((self.view.bounds.size.width - 40.0), (self.view.bounds.size.height / 5));
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[FavoriteTicketCell class] forCellWithReuseIdentifier:@"ReuseIdentifier"];

    [self.view addSubview: _collectionView];
    
    [self addSubviews];
}

#pragma mark - Subviews

-(void) addSubviews {
    [self addHeader];
}

-(void) addHeader {

    CGFloat headerHeight = 90;
    /*
    UIView *headerView = ({
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, -headerHeight, self.collectionView.frame.size.width, headerHeight);
        view;
    });*/
        
    UIView* headerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, self.view.frame.size.width, headerHeight)];
    headerView.backgroundColor = [UIColor systemGreenColor];
    [self.view addSubview: headerView];

//    [self.collectionView addSubview: headerView];
//    [self.view insertSubview: headerView aboveSubview: self.collectionView];
    _collectionView.contentInset = UIEdgeInsetsMake(headerHeight / 2, 0, 0, 0);
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"All", @"Searched", @"MAP", nil]];
    CGFloat segmentedControlWidth = 240;
    CGFloat segmentedControlHeight = 30;
    CGFloat segmentedControlX = (self.view.frame.size.width - segmentedControlWidth) / 2;
    CGFloat segmentedControlY = headerHeight - segmentedControlHeight * 1.25;

    _segmentedControl.frame = CGRectMake(segmentedControlX, segmentedControlY, segmentedControlWidth, segmentedControlHeight);
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(sortingSegmentControl) forControlEvents: UIControlEventValueChanged];
    [headerView addSubview: _segmentedControl];
}


#warning segment controller sort All/Search/Map
-(void) sortingSegmentControl {
    
    switch (_segmentedControl.selectedSegmentIndex) {
    case 1:
            NSLog(@"Sort by search");

            break;
    case 2:
            NSLog(@"Sort by map");
            break;

    default:
            NSLog(@"Sort for all");

            break;
    }

}




#pragma mark Collection ViewData Source

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ticketsCollection.count + 15;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FavoriteTicketCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"ReuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell
    cell.layer.cornerRadius = 10;
    cell.backgroundColor = [UIColor lightGrayColor];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
#warning notification - change TimeInterval to Date
    
    NSString *text = [NSString stringWithFormat: @"Your ticket with row %ld", indexPath.item];
    NSTimeInterval time = 5;
    
    [[LocalNotificationManager shared] requestPermissionsWithText: text after: time];

    NSLog(@"Don't touch me");
    
}


@end
