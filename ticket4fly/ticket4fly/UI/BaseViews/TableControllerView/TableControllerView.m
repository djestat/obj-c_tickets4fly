//
//  TableControllerView.m
//  ticket4fly
//
//  Created by Igor on 15/09/2019.
//  Copyright © 2019 Igorlab. All rights reserved.
//

#import "TableControllerView.h"
#import "ThemeManager.h"
#import "PlaceTableViewCell.h"
#import "PlaceCellModel.h"

#import "RouteTableViewCell.h"
#import "RouteCellModel.h"

@interface TableControllerView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray* models;
@property (nonatomic, weak) UITableView* tableView;
@property (nonatomic, weak) ThemeManager* themeManager;


@end

@implementation TableControllerView

- (void)reload:(NSArray<CellModel *> *)models {
    [self.models removeAllObjects];
    [self.models addObjectsFromArray: models];
    [self.tableView reloadData];
}

#pragma mark - Init Frame

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame: frame];
    
    self.models = [NSMutableArray new];
    
    self.themeManager = [ThemeManager shared];
    [self addNotifications];
    [self addSubviews];
    [self updateTheme];
    
    return self;
}

- (void)dealloc {
    [self removeNotifications];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

#pragma mark - Subviews

- (void) addSubviews {
    if (nil != self.tableView) {
        return;
    }
    
    UITableView* tableView = [UITableView new];
    [self addSubview: tableView];
    self.tableView = tableView;

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    NSString* baseCellID = NSStringFromClass([UITableViewCell class]);
    [self.tableView registerClass: [UITableViewCell class] forCellReuseIdentifier: baseCellID];
    
    NSString* placeCellID = NSStringFromClass([PlaceTableViewCell class]);
    [self.tableView registerClass: [PlaceTableViewCell class] forCellReuseIdentifier: placeCellID];
        
    NSString* routeCellID = NSStringFromClass([RouteTableViewCell class] );
    [self.tableView registerClass: [RouteTableViewCell class] forCellReuseIdentifier: routeCellID];
}

#pragma mark - Theme

- (void) updateTheme {
    BaseTheme* activeTheme = [self.themeManager activeTheme];
    
    UIColor* viewBackgroundColor = [activeTheme viewBackgroundColor];
    self.backgroundColor = viewBackgroundColor;
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    /*
    self.layer.cornerRadius = [activeTheme actionCornerRadius];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 1.0f;
    self.layer.masksToBounds = YES; */
}

#pragma mark - Notifications

- (void) addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(didReceiveChangedThemeNotification)
                                                 name: [self.themeManager didChangedThemeNotificationName]
                                               object: nil];
}

- (void) removeNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: [self.themeManager didChangedThemeNotificationName]
                                                  object: nil];
}

- (void) didReceiveChangedThemeNotification {
    [self updateTheme];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CellModel* model = [self.models objectAtIndex: indexPath.row];
    [model didSelect];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellModel* model = [self.models objectAtIndex: indexPath.row];
    return [model heightInTableView: tableView];
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
        
    CellModel* model = [self.models objectAtIndex: indexPath.row];
    
    if ([model isKindOfClass: [PlaceCellModel class]]) {
        NSString* placeCellID = NSStringFromClass([PlaceTableViewCell class]);
        
        PlaceTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: placeCellID forIndexPath: indexPath];
        [cell configureWith: (PlaceCellModel*)model];
        return cell;
    }
    
    if ([model isKindOfClass: [RouteCellModel class]]) {
        NSString* routeCellID = NSStringFromClass([RouteTableViewCell class] );
        RouteTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: routeCellID forIndexPath: indexPath];
        [cell configureWith: (RouteCellModel*)model];
        tableView.separatorColor = [UIColor clearColor];
        return cell;
    }
    
    if ([model isKindOfClass: [CellModel class]]) {
        NSString* baseCellID = NSStringFromClass([UITableViewCell class]);
        return [tableView dequeueReusableCellWithIdentifier: baseCellID forIndexPath: indexPath];
    }
    
    NSString* baseCellID = NSStringFromClass([UITableViewCell class]);
    return [tableView dequeueReusableCellWithIdentifier: baseCellID forIndexPath: indexPath];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CellModel* model = [self.models objectAtIndex: indexPath.row];

    if ([model isKindOfClass: [RouteCellModel class]]) {
        
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI_2);
        cell.transform = CGAffineTransformMakeScale(0, 0);
        
        [UIView animateWithDuration:0.8
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            cell.contentView.transform = CGAffineTransformIdentity;
            cell.transform = CGAffineTransformIdentity;
        }
                         completion: nil];
        
    }
}

- (void)didSelectTicket:(nonnull Ticket *)ticket {
    NSLog(@"didSelectTicket t cv");
           /*
            NSString* message = [NSString stringWithFormat: @"Do you want add to favorites ticket: %@ - %@ price: %@ ", ticket.from, ticket.to, ticket.price];
               
               UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Add to favorites?" message: message preferredStyle:UIAlertControllerStyleAlert];
               
               UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   //button click event
                   NSLog(@"YES Add");
                   [[DataBaseManager shared] saveTickets: ticket];
               }];
               UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
               [alert addAction:cancel];
               [alert addAction:ok];
               [self presentViewController:alert animated:YES completion:nil];
            */
    //        NSMutableArray<Ticket*>* tickets = [NSMutableArray new];
    //        [tickets addObject: ticket];
}


@end
