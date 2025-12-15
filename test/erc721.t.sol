// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import { NFTCard } from "../src/erc721.sol";
import { MockNameResolver } from "./mock/MockNameResolver.sol";
import { MockENS } from "./mock/MockENS.sol";
import { MockReverseRegistrar } from "./mock/MockReverseRegistrar.sol";

contract TestNFTCard is Test {
    NFTCard public nftCard;
    MockReverseRegistrar public registrar;
    MockENS public ens;
    MockNameResolver public resolver;
    address public owner = makeAddr('owner');

    function setUp() public {
        // Деплоим моки
        resolver = new MockNameResolver();
        ens = new MockENS(address(resolver));
        registrar = new MockReverseRegistrar();
        
        // Даем owner 2 ETH
        vm.deal(owner, 2 ether);
        
        // Деплоим NFTCard с МОКАМИ
        address[] memory _allowedSeadrops = new address[](1);
        _allowedSeadrops[0] = address(0);
        vm.prank(owner);
        nftCard = new NFTCard(_allowedSeadrops, address(registrar), address(ens));
    }

    function testCreatingURI() public view {
        console.log("Owner balance:", owner.balance);
        string memory uri = nftCard.tokenURI(1);
    }
}