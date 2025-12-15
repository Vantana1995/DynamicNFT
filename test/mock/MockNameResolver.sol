// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MockNameResolver {
    function name(bytes32) external pure returns (string memory) {
        return "MrPicule";
    }
}