// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MockReverseRegistrar {
    function node(address) external pure returns (bytes32) {
        return bytes32(uint256(1));
    }
}