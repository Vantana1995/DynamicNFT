// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import { NFTCard } from "../src/erc721.sol";

contract DeployNFT is Script {
    address allowedSeadrops = 0x00005EA00Ac477B1030CE78506496e8C2dE24bf5;
    address registrar = 0xa58E81fe9b61B5c3fE2AFD33CF304c454AbFc7Cb;
    address ens = 0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e;

    function run() public returns(NFTCard) {
        address[] memory _allowedSeadrops = new address[](1);
        _allowedSeadrops[0] = allowedSeadrops;

        vm.startBroadcast();
        NFTCard nftCard = new NFTCard(_allowedSeadrops, registrar, ens);
        vm.stopBroadcast();
        return nftCard;
    }

}