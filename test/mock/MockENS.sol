// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MockENS {
    address public mockResolver;
    
    constructor(address _resolver) {
        mockResolver = _resolver;
    }
    
    function resolver(bytes32) external view returns (address) {
        return mockResolver;
    }
}