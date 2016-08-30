//
//  TableViewController.m
//  toDoObjC
//
//  Created by Ellen Mey on 8/29/16.
//  Copyright © 2016 Ellen Mey. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *editButton;

@property NSMutableArray *taskList;


@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _taskList = [[NSMutableArray alloc] initWithObjects:@"Do Dishes", nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_taskList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = _taskList[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if ([cell isEditing] == YES) {
        UIAlertController *editTaskAlert = [UIAlertController
                                            alertControllerWithTitle:@"Do It!"
                                            message:@"Change your task"
                                            preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *save = [UIAlertAction
                              actionWithTitle:@"Save"
                              style:UITableViewCellStyleDefault
                              handler:^(UIAlertAction *action){
                                  // add text field input to array and repopulate table
                                  NSString *newTaskName = ((UITextField *)[editTaskAlert.textFields objectAtIndex:0].text);
                                  [_taskList replaceObjectAtIndex:indexPath.row withObject:newTaskName];
                                  NSLog(@"%@", _taskList);
                                  [self.tableView reloadData];
                              }];
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleCancel
                                 handler:^(UIAlertAction *action) {
                                     [editTaskAlert dismissViewControllerAnimated:YES completion:nil];
                                 }];
        [editTaskAlert addAction:save];
        [editTaskAlert addAction:cancel];
        
        [editTaskAlert addTextFieldWithConfigurationHandler:^(UITextField *textField){
            textField.placeholder = cell.textLabel.text;
        }];
        
        [self presentViewController:editTaskAlert animated:YES completion:nil];
 
    } else {
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            [cell.textLabel setTextColor:[UIColor blackColor]];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            [cell.textLabel setTextColor:[UIColor grayColor]];
        }
    }
    
}

- (IBAction)addTaskButtonClicked:(id)sender {
    UIAlertController *addTaskAlert =  [UIAlertController
                                        alertControllerWithTitle:@"Do It!"
                                        message:@"Add a task"
                                        preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *add = [UIAlertAction
                          actionWithTitle:@"Add"
                                    style:UITableViewCellStyleDefault
                                    handler:^(UIAlertAction *action){
                                        // add text field input to array and repopulate table
                                        NSString *taskAdded = ((UITextField *)[addTaskAlert.textFields objectAtIndex:0].text);
                                        [_taskList addObject:taskAdded];
                                        NSLog(@"%@", _taskList);
                                        [self.tableView reloadData];
                                    }];
    UIAlertAction *cancel = [UIAlertAction
                             actionWithTitle:@"Cancel"
                             style:UIAlertActionStyleCancel
                             handler:^(UIAlertAction *action) {
                                 [addTaskAlert dismissViewControllerAnimated:YES completion:nil];
                             }];
    [addTaskAlert addAction:add];
    [addTaskAlert addAction:cancel];
    
    [addTaskAlert addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"What do you want to get done?";
    }];
    
    [self presentViewController:addTaskAlert animated:YES completion:nil];
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_taskList removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        if (_taskList.count == 0) {
            self.editButtonItem.enabled = NO;
            self.editButtonItem.title = @"Edit";
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        //NSString *newTask =
    }   
}

- (IBAction)editButtonClicked:(id)sender {
    if ([self.tableView isEditing]) {
        // If it's already in edit mode, turn it off and change the text of the button
        [self.tableView setEditing:NO animated:YES];
        [self.editButton setTitle:@"Edit"];
    } else {
        self.editButton.title = @"Done";
       // [self.editButtonItem setTitle:@"Done"];
        [self.tableView setEditing:YES animated:YES];
    }
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
