pragma solidity >=0.5.0 <0.6.0;

import "./zombiehelper.sol";

contract ZombieAttack is ZombieHelper {
  //Random number generation via keccak256
  //Let's implement a random number function we can use to determine the outcome of our battles, even if it isn't totally secure from attack.
  uint randNonce = 0;
  
  //Our zombie battles will work as follows:
//You choose one of your zombies, and choose an opponent's zombie to attack.
//If you're the attacking zombie, you will have a 70% chance of winning. The defending zombie will have a 30% chance of winning.
//All zombies (attacking and defending) will have a winCount and a lossCount that will increment depending on the outcome of the battle.
//If the attacking zombie wins, it levels up and spawns a new zombie.
//If it loses, nothing happens (except its lossCount incrementing).
//Whether it wins or loses, the attacking zombie's cooldown time will be triggered.
  // Create attackVictoryProbability here
  uint attackVictoryProbability = 70;
 
 //Random number generation via keccak256
  //Let's implement a random number function we can use to determine the outcome of our battles, even if it isn't totally secure from attack.
  function randMod(uint _modulus) internal returns(uint) {
    randNonce++;
    return uint(keccak256(abi.encodePacked(now, msg.sender, randNonce))) % _modulus;
  }
  
   // Create new function attack here
  // 1. Add modifier here
  function attack(uint _zombieId, uint _targetId) external ownerOf(_zombieId) {
    // 2. Start function definition here
    //The first thing our function should do is get a storage pointer to both zombies so we can more easily interact with them:
    Zombie storage myZombie = zombies[_zombieId];
    Zombie storage enemyZombie = zombies[_targetId];
    uint rand = randMod(100);
  }
}
