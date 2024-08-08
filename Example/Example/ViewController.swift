//
//  ViewController.swift
//  Example
//
//  Created by Sun on 2024/8/8.
//

import UIKit

import EthereumKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // It generates an array of random mnemonic words. Use it for back-ups.
        // You can specify which language to use for the sentence by second parameter.
        let mnemonic: [String] = [
            "vivid",
            "episode",
            "rabbit",
            "vapor",
            "they",
            "expose",
            "excess",
            "ten",
            "fog",
            "old",
            "ridge",
            "abandon"
        ]
        
        // Then generate seed data from the mnemonic sentence.
        // You can set password for more secure seed data.
        let seed = try! Mnemonic.createSeed(mnemonic: mnemonic)
        
        // Create wallet by passing seed data and which network you want to connect.
        // for network, EthereumKit currently supports mainnet and ropsten.
        let wallet: Wallet
        do {
            wallet = try Wallet(seed: seed, network: .palmTestnet, debugPrints: true)
        } catch let error {
            fatalError("Error: \(error.localizedDescription)")
        }
        
        // Generate an address, or private key by simply calling
        let address = wallet.address()
        
        // Create an instance of `Geth` with `Configuration`.
        // In configuration, specify
        // - network: network to use
        // - nodeEndpoint: url for the node you want to connect
        // - etherscanAPIKey: api key of etherscan
        let configuration = Configuration(
            network: .ropsten,
            nodeEndpoint: "https://palm-testnet.infura.io/v3/b369a5cf61c649d4946de59ae753c844",
            etherscanAPIKey: "CDB3JMWSZN3T9U7I517V1UJSS542KXDEMH",
            debugPrints: true
        )
        
        let geth = Geth(configuration: configuration)
        
        // To get a balance of an address, call `getBalance`.
        geth.getBalance(of: address) { result in
            switch result {
            case .success(let balance):
                print("Banalce: \(balance.wei)")
            case .failure(let error):
                print("getBalance: \(error)")
            }
        }
        
        // You can get the current nonce by calling
        geth.getTransactionCount(of: address) { result in
            switch result {
            case .success(let nonce):
                let wei: BInt
                do {
                    wei = try Converter.toWei(ether: "0.00001")
                } catch let error {
                    fatalError("Error: \(error.localizedDescription)")
                }
                
                let rawTransaction = RawTransaction(value: wei, to: address, gasPrice: Converter.toWei(GWei: 10), gasLimit: 21000, nonce: nonce)
                let tx: String
                do {
                    tx = try wallet.sign(rawTransaction: rawTransaction)
                } catch let error {
                    fatalError("Error: \(error.localizedDescription)")
                }
                
                // It returns the transaction ID.
                geth.sendRawTransaction(rawTransaction: tx) { _ in }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
        
        let contract = ERC20(contractAddress: "0xd99b8A7fA48E25Cce83B81812220A3E03Bf64e5f", decimal: 18, symbol: "SKM")
        geth.getTokenBalance(contract: contract, address: address) { result in
            switch result {
                
            case .success(let balance):
                print("Token balance: \(balance)")
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
