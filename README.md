# Refund-by-Location-Smart-Contract
## A smart contract to pay employees based on their location. 

Table of contents

- Overview
- Requirements
- Install
- Repository Structure
- Contrbutors

## Overview
The aim of this project is to design a smart contract that will allow an employer to transfer funds to an employee if a certain condition has been satisfied. The refund by location smart contract is aimed to be used when one party, for example an employer, agrees to pay another party, for example an employee, for being present in a certain geographic area for a certain duration. The employee’s phone sends its GPS location to a smart contract at a certain interval. Based on the pre-agreed contract codified in an Ethereum smart contract, a cryptocurrency payment is executed when all the agreed conditions are met.

If, at any point, the GPS sensor indicates that an employee is outside the range of the agreed GPS area, the contract state will be updated to indicate that it is out of compliance.


## Requirements
>NPM
>
>Truffle
>
>Flutter
>
>Ganache


## Install
1.Install the project
```
git clone https://github.com/gedionabebe/Refund-by-Location-Smart-Contract.git
cd Refund-by-Location-Smart-Contract
npm install
```
## Repository Structure
```bash
├── build\contracts\(Smart contractss build files)
│   
├── contracts(Solidity smart contracts)
│
├── dist(Index page)
│
├── migrations(Migrations file)
│
├── src(javascript and css files)
│
├── tests(Tests)
│
├── README.md(Project information)
│
├── package.json(Porject requirements)
│
├──truffle-config.js(Truffle config file)
│
├──truffle.js(Truffle config file)
│
├──webpack.config.js(Webpack Config file)
```
## Contrbutors
- Gedion Abebe
