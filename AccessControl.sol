// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract AccessControl {
    mapping(address => mapping(bytes32 => bool)) private roles;

    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);
    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    modifier onlyRole(bytes32 role) {
        require(hasRole(role, msg.sender), "AccessControl: caller does not have the required role");
        _;
    }

    function grantRole(bytes32 role, address account) public onlyRole(keccak256("ADMIN_ROLE")) {
        roles[account][role] = true;
        emit RoleGranted(role, account, msg.sender);
    }

    function revokeRole(bytes32 role, address account) public onlyRole(keccak256("ADMIN_ROLE")) {
        roles[account][role] = false;
        emit RoleRevoked(role, account, msg.sender);
    }

    function hasRole(bytes32 role, address account) public view returns (bool) {
        return roles[account][role];
    }
}