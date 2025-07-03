// SPDX-License-Identifier: MIT
pragma solidity 0.8.29;

contract DomainRegistry {
    struct Domain {
        string name;
        address owner;
        uint256 registrationDate;
    }

    mapping(string => Domain) public domains;

    event DomainRegistered(string domainName, address owner, uint256 registrationDate);

    function registerDomain(string memory _name) public {
        require(bytes(domains[_name].name).length == 0, "Domain already registered");
        domains[_name] = Domain(_name, msg.sender, block.timestamp);
        emit DomainRegistered(_name, msg.sender, block.timestamp);
    }

    function getDomainInfo(string memory _name) public view returns (string memory, address, uint256) {
        require(bytes(domains[_name].name).length != 0, "Domain not registered");
        Domain memory domain = domains[_name];
        return (domain.name, domain.owner, domain.registrationDate);
    }
}