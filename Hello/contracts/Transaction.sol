pragma solidity ^0.4.17;
import "../node_modules/zeppelin-solidity/contracts/token/StandardToken.sol";

contract Transaction is StandardToken {
    address employee;
    address employer;
    uint balances;
    uint create_time = now;
    uint expire = 24 weeks;
    uint working_hours;
    bool ended = false;

    function new_transaction(address new_employer, address new_employee, uint new_balances) public {
        if (ended == true) return;
        employee = new_employee;
        employer = new_employer;
        balances = new_balances;
    }
    
    function is_expire() public {
        if (ended == true) return;
        if (now > create_time + expire) ended = false;
        else ended = true;
    }
}