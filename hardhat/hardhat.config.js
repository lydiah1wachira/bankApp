require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.9",
  networks:{
    hardhat:{},
    mumbai:{
      url:"https://polygon-mumbai.g.alchemy.com/v2/C9oZh-SerJj7wN0JzNu5O2TltPF6X6Eg",
      accounts:["2bf4ff8ce773dc389891dffe4a7f4828ed92fd019fb9c1e3a94720a190f09eca"],
      chainId:80001,
    },
  },
  
};
