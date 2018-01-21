pragma solidity ^0.4.17;
contract smartSponsor {
  address public owner;
  address public benefactor;
  bool public refunded;
  bool public complete;
  uint public numPledges;
  struct Pledge {
    uint amount;
    address eth_address;
    bytes32 message;
  }
  mapping(uint => Pledge) public pledges;

  // constructor
  function smartSponsor(address _benefactor) public{
    owner = msg.sender;
    numPledges = 0;
    refunded = false;
    complete = false;
    benefactor = _benefactor;
  }

  // add a new pledge
  function pledge(bytes32 _message)payable public {
    if (msg.value == 0 || complete || refunded) revert();
    pledges[numPledges] = Pledge(msg.value, msg.sender, _message);
    numPledges++;
  }

  function getPot() constant public returns (uint){
    return this.balance;
  }

  // refund the backers
  function refund() public {
    if (msg.sender != owner || complete || refunded) revert();
    for (uint i = 0; i < numPledges; ++i) {
      pledges[i].eth_address.transfer(pledges[i].amount);
    }
    refunded = true;
    complete = true;
  }

  // send funds to the contract benefactor
  function drawdown() public {
    if (msg.sender != owner || complete || refunded) revert();
    benefactor.transfer(this.balance);
    complete = true;
  }
}

geth --datadir "./chain-1" --networkid 71 --port 30301 --nodiscover console