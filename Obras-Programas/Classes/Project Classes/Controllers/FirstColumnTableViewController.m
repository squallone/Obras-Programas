//
//  FirstColumnTableViewController.m
//  Prueba Graficas
//
//  Created by Pedro Contreras Nava on 06/10/14.
//  Copyright (c) 2014 Pedro Contreras Nava. All rights reserved.
//

#import "FirstColumnTableViewController.h"
#import "FichaTecnicaViewController.h"
#import "Obra.h"

@interface FirstColumnTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *firstColumn;

@end

@implementation FirstColumnTableViewController
@synthesize firstColumn;

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 9;
}


-    (void) tableView : (UITableView*) tableView
willDisplayHeaderView : (UIView*) view
           forSection : (NSInteger) section {
    [[((UITableViewHeaderFooterView*) view) textLabel] setTextColor : [UIColor blackColor]];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    NSLog(@"System time: %@", [self.obra.fechaInicio description]);
    
    
    // Configure the cell...
    if(indexPath.row == 0){
        cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"Identificador de Obra";
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.text = self.obra.idObra;

    }else if(indexPath.row == 1){
        cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"Denominación";
        cell.detailTextLabel.lineBreakMode = NSLineBreakByClipping;
        cell.detailTextLabel.numberOfLines = 2;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        
        
        NSString *fullString = self.obra.denominacion;
        NSString *prefix = nil;
        
        if ([fullString length] >= 80)
            prefix = [fullString substringToIndex:80];
        else
            prefix = fullString;
        
        
        cell.detailTextLabel.text = prefix;
    }
    else    if(indexPath.row == 2){
        cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"Dependencia/Secretaría";
        
        
        
        cell.detailTextLabel.text = self.obra.dependencia.nombreDependencia;

    }
    else    if(indexPath.row == 3){
        cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"Estado";
        cell.detailTextLabel.text = self.obra.estado.nombreEstado;

    }
    else    if(indexPath.row == 4){
        cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"Municipio";
        cell.detailTextLabel.text = self.obra.municipio;

    }
    else    if(indexPath.row == 5){
        cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"Tipo de Obra";
        cell.detailTextLabel.text = self.obra.tipoObra.nombreTipoObra;

    }
    else    if(indexPath.row == 6){
        cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"Avance";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %%",self.obra.porcentajeAvance];
       

    }
    else    if(indexPath.row == 7){
        cell = [tableView dequeueReusableCellWithIdentifier:@"CellFecha" forIndexPath:indexPath];
        UILabel *labelInicio = (UILabel*)[cell.contentView viewWithTag:1];
        labelInicio.text = [self.obra.fechaInicio description];
        
        UILabel *labelFinal = (UILabel*)[cell.contentView viewWithTag:2];
        labelFinal.text = [self.obra.fechaTermino description];
        
        [labelInicio setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];
        [labelFinal setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];

    }
    else    if(indexPath.row == 8){
        cell =[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell.textLabel.text = @"Última modificación";
        cell.detailTextLabel.text = [self.obra.fechaModificacion description];
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;

    }
    
    if(indexPath.row !=7) [cell.detailTextLabel setTextColor:[UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0]];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==7) {
        return 58;
    }
    else return 44;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .5;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // set title of section here
    return @"Datos Generales"; //set the title of each section as a date
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
