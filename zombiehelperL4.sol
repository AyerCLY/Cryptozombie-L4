pragma solidity >=0.5.0 <0.6.0;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {

  //Let's create a payable function in our zombie game.
  //Let's say our game has a feature where users can pay ETH to level up their zombies. 
  //The ETH will get stored in the contract, which you own — this a simple example of how you could make money on your games!
  //Note: If a function is not marked payable and you try to send Ether to it as above, the function will reject your transaction.
  // 1. Define levelUpFee here
  uint levelUpFee = 0.001 ether;
 
  modifier aboveLevel(uint _level, uint _zombieId) {
    require(zombies[_zombieId].level >= _level);
    _;
  }

  // 1. Create withdraw function here
  //Note that we're using owner() and onlyOwner from the Ownable contract, assuming that was imported.
  //It is important to note that you cannot transfer Ether to an address unless that address is of type address payable. But the _owner variable is of type uint160, meaning that we must explicitly cast it to address payable.
  //address(this).balance will return the total balance stored on the contract. So if 100 users had paid 1 Ether to our contract, address(this).balance would equal 100 Ether.
  function withdraw() external onlyOwner {
    address payable _owner = address(uint160(owner()));
    _owner.transfer(address(this).balance);
  }

  // 2. Create setLevelUpFee function here
  function setLevelUpFee(uint _fee) external onlyOwner {
    levelUpFee = _fee;
  }
  // 2. Insert levelUp function here
  function levelUp(uint _zombieId) external payable {
    require(msg.value == levelUpFee);
    zombies[_zombieId].level++;
  }

  function changeName(uint _zombieId, string calldata _newName) external aboveLevel(2, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].name = _newName;
  }

  function changeDna(uint _zombieId, uint _newDna) external aboveLevel(20, _zombieId) {
    require(msg.sender == zombieToOwner[_zombieId]);
    zombies[_zombieId].dna = _newDna;
  }

  function getZombiesByOwner(address _owner) external view returns(uint[] memory) {
    uint[] memory result = new uint[](ownerZombieCount[_owner]);
    uint counter = 0;
    for (uint i = 0; i < zombies.length; i++) {
      if (zombieToOwner[i] == _owner) {
        result[counter] = i;
        counter++;
      }
    }
    return result;
  }

}
