//
//  CharacterTableVIewController.swift
//  writype
//
//  Created by 金築良磨 on 2016/07/25.
//  Copyright © 2016年 AkkeyLab. All rights reserved.
//

import UIKit

class CharacterTableVIewController: UITableViewController {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        // #warning Incomplete implementation, return the number of sections

        return 1

    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        // #warning Incomplete implementation, return the number of rows

        return 10

    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell

    {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        // Configure the cell...

        cell.textLabel?.text = indexPath.row.description

        return cell

    }
}
