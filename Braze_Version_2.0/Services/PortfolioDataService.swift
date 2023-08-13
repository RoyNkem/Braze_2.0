//
//  PortfolioDataService.swift
//  Braze
//
//  Created by Roy's MacBook M1 on 13/08/2023.
//

import CoreData

///Does all the logic to get portfolio data from Core Data
class PortfolioDataService {
    
    //set up coredata
    private let container: NSPersistentContainer
    private let containerName: String = "PortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    ///This array saves the result (PortfolioEntity objects) of fetch request from the view context. Bind & subscribe to this property from other views in the app.
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error = error {
                print("error loading Core Data: \(error)")
            }
        }
        self.getPortfolio()
    }
    
    //MARK: PUBLIC
    func updatePortfolio(coin: CoinModel, amount: Double) {
        //check whether coin exists in Core Data Stack (Portfolio) with its id
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            
            if amount > 0 {
                update(entity: entity, amount: amount)
            } else {
                remove(entity: entity) //if amount requested is 0, it means user wants to remove it from portfolio
            }
        } else { // coin does not exist
            add(coin: coin, amount: amount)
        }
    }
    
    func deletePortfolio(coin: CoinModel) {
        //we need to grab the particular portfolio coin
        if let selectedEntity = savedEntities.first(where: { $0.coinID == coin.id }) {
            remove(entity: selectedEntity)
        }
    }
    
    //MARK: PRIVATE CRUD Operations
    //Create
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        
        //assign atrtribute values
        entity.coinID = coin.id
        entity.amount = amount
        
        //save created entity and re-fetch data from the context
        applyChanges()
    }
    
    //Read
    private func getPortfolio() {
        
        //create fetch request -> NSFetch is generic so we need to give it a specific result type
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request) //call to fetch
        } catch let fetchError {
           print("Error fetching Portfolio Entities: \(fetchError)")
        }
    }
    
    //Update
    private func update(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    //Delete
    private func remove(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    //save the context after the entity has been added to the context
    private func save() {
        do {
            try container.viewContext.save()
        } catch let saveError {
            print("Error saving to Core Data: \(saveError)")
        }
    }
    
    ///Save the new context, re-fetch all coins from the context and set them to savedEntities var.
    /// - Update savedEntities Arr which will be pushed to subscribers -> call getPortfolio func again to create a new fetch request and save them to the arr
    //helper function called every time a write operation is done on object
    private func applyChanges() {
        save()
        getPortfolio()
    }
    
}
