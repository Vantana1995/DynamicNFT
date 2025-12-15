// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { ENS } from "@ensdomains/registry/ENS.sol";
import { INameResolver } from "@ensdomains/resolvers/profiles/INameResolver.sol";
import { IReverseRegistrar } from "@ensdomains/reverseRegistrar/IReverseRegistrar.sol";

contract ENSManager {

    IReverseRegistrar private registrar;
    ENS private ensRegistry;
    
    constructor(address _registrar, address _ens) {
        registrar = IReverseRegistrar(_registrar);
        ensRegistry = ENS(_ens);
    }

    function getName(address _user) public view returns (bool, string memory name) {
        bytes32 _node = _getNode(_user);
        address _resolver = _getResolver(_node);
        name = _getName(_node, _resolver);
        if (bytes(name).length > 0) {
            return (true, name);
        } else {
            return (false, "");
        }
    }

    function _getName(bytes32 _node, address _resolverAddr) internal view returns(string memory) {
        return INameResolver(_resolverAddr).name(_node);
    }

    function _getNode(address _user) internal view returns(bytes32) {
        return registrar.node(_user);
    }

    function _getResolver(bytes32 _node) internal view returns(address) {
        return ensRegistry.resolver(_node);
    }
}