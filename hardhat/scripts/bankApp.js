const hre = require("hardhat");


async function main() {
    const signers = await hre.ethers.getSigners()
    // console.log("Signers", signers)
    const account0 = signers[0].address;
    const account1 = signers[1].address;
    const BankApp = await hre.ethers.getContractFactory("BankApp");
    const bankApp = await BankApp.deploy("Lois Lane");
    await bankApp.deployed();

    await bankApp.register(account0, 1234, "Lois Lane", "A000gffher", 40000);
    await bankApp.register(account1, 4567, "Clark kent", "A000guger", 20000);
    await bankApp.connect(signers[0]).login;
    await bankApp.login();
    await bankApp.deposit(200);
    // check account0 balance
    await bankApp.checkBalance(account0);
    // log the balance of account0
    console.log(await bankApp.checkBalance(account0));
    // transfer to account1
    await bankApp.connect(signers[0]).transfer(account1, 20);
    // check account1 balance 
    console.log(await bankApp.connect(signers[0]).checkBalance(account1));
    // log the balance after the transfer
    console.log(await bankApp.checkBalance(account0));

}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});