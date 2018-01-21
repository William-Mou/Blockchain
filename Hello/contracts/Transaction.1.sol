pragma solidity ^0.4.17;

contract Transaction {
    address employee;
    address employer;
    uint create_time;
    uint base_wage;
    uint payables;
    uint expire = 100;
    uint working_hours;
    uint ETH_to_TWD_100 = 3000000;
    bool ended = false;
    bool usaged = false;
    /*
    event Deposit(
        address employee,
        bool endeded
    );*/
    
    function Transaction(address new_employee, uint new_working_hours ,uint new_base_wage)payable public{
        if (ended == true) revert();
        employee = new_employee;
        employer = msg.sender;
        working_hours = new_working_hours;
        base_wage=new_base_wage;
        if (working_hours >= 2) payables = (working_hours-2)*base_wage*266+working_hours*233*base_wage;
        else payables = working_hours*233*base_wage;
        if (msg.value>=payables/ETH_to_TWD_100) usaged=true;
        else return;
        create_time=now;
    }
    function add_more(uint new_working_hours )payable public{
        if (ended == true) revert();
        working_hours+=new_working_hours;
        if (working_hours >= 2) payables = (working_hours-2)*base_wage*266+working_hours*233*base_wage;
        else payables = working_hours*233*base_wage;
        if (payables>=this.balance/ETH_to_TWD_100) usaged=true;
        create_time=now;
    }
    /*
    function is_expire() public returns(uint){
        if (ended == true) revert();
        if ((now - create_time)> (expire * 1 seconds)) {
            ended = false;
            return (now - create_time);
        }
        else {
            ended = true;
            return (now - create_time);
        }
    }*/
    
    function collectMoney() public {
        //Deposit(employee,ended);
        if ((now - create_time)> (expire * 1 seconds)) {
            ended = false;
        }
        else {
            ended = true;
        }
        if (msg.sender!=employee || ended == false || ended == false) revert();
        employee.transfer(this.balance);
    }
}

//[{"adress new_employee":"0xca35b7d915458ef540ade6068dfe2f44e8fa733c" , "uint new_working_hours": 1 , "uint new_base_wage" : 140 }]
//0xca35b7d915458ef540ade6068dfe2f44e8fa733c