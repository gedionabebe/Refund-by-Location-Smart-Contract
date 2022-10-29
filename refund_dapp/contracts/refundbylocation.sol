pragma solidity ^0.8.17;

contract paybylocation{
    
    struct employee_info{
        uint lat;
        uint long;
        bool iscompling;
        string name;
        uint allowed_distance;
        
    }
    mappings  (address => employee_info) public employee_store;
function create_employee(uint lat, uint long, string name,address employee_address,uint allowed_distance;){
     employee_store[employee_address].lat = lat;
     employee_store[employee_address].long = long;
     employee_store[employee_address].iscompling = false;
     employee_store[employee_address].name = name;
     employee_store[employee_address].allowed_distance = allowed_distance;

}

function sqrt(uint x) public pure returns (uint y) {
    uint z = (x + 1) / 2;
    y = x;
        while (z < y) {
            y = z;
            z = (x / z + z) / 2;
        }
        return y;
    }
function distance_calculator(uint256 lat, uint256 long,uint256 lat2, uint256 long2) public returns (uint256 distance)
    {
    
        uint256 distance = uint256(sqrt((lat2 - lat1) ** 2 + (long2 - long1) ** 2));
        return uint256(distance);

    }
function is_compling(address employee_address, lat, uint256 long) public {
    uint256 lat2 = employee_store[employee_address].lat;
    uint256 long2 = employee_store[employee_address].long;
    uint256 distance = distance_calculator(lat,long,lat2,long2);
    uint256 allowed_distance = employee_store[employee_address].allowed_distance;
    if (distance <= allowed_distance){
        employee_store[employee_address].is_compling = true;
    }
    else{
        employee_store[employee_address].is_compling = false;
    }

}
}
